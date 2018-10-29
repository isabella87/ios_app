//
//  JxOpenAccountController.m
//  banhuitong
//
//  Created by user on 16/7/1.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "JxOpenAccountController.h"
#import "BaseOperation.h"
#import "AsyncCenter.h"
#import "CacheObject.h"
#import "JxGetMobileCodeWhenOpenAccountOperation.h"
#import "JxOpenAccountOperation.h"

@interface JxOpenAccountController ()

@end

@implementation JxOpenAccountController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader2:self.title];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *personalInfo = [CacheObject sharedInstance].personalInfo;
    if(personalInfo!=nil){
        self.mobile = [personalInfo objectForKey:@"mobile"];
    }
    
    self.countdown = 59;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    if ([self validate]) {
        [self showActiveLoading];
        BaseOperation *op = [[JxOpenAccountOperation alloc] initWithDelegate:self];
        ((JxOpenAccountOperation *)op).bankCard = self.bankcard;
        ((JxOpenAccountOperation *)op).idNo = self.idNo;
        ((JxOpenAccountOperation *)op).mobileCode = self.mobileCode;
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    }
}

- (IBAction)sendMobileCode:(id)sender {
    BaseOperation *op = [[JxGetMobileCodeWhenOpenAccountOperation alloc] initWithDelegate:self];
    ((JxGetMobileCodeWhenOpenAccountOperation *)op).mobile = self.mobile;
    ((JxGetMobileCodeWhenOpenAccountOperation *)op).type = @"1";
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
}

-(bool) validate{
    self.idNo = [self.tvID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.bankcard = [self.tvBankcard.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.mobileCode = [self.tvMobileCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([self.idNo isEqualToString:@""]){
        [self showAlertWithText:@"身份证号不能为空！"];
        [self.tvID becomeFirstResponder];
        return false;
    }
    
    if([self.bankcard isEqualToString:@""]){
        [self showAlertWithText:@"银行卡不能为空！"];
        [self.tvBankcard becomeFirstResponder];
        return false;
    }
    
    if([self.mobileCode isEqualToString:@""]){
        [self showAlertWithText:@"验证码不能为空！"];
        [self.tvMobileCode becomeFirstResponder];
        return false;
    }
    return true;
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code==JX_OPEN_ACCOUNT_SUCCESS) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"开户成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        alert.tag = 1;
        [alert show];
        
    }else if (code==SEND_MOBILE_CODE_SUCCESS) {
        NSString *msg = [NSString stringWithFormat:@"手机激活码已发送到手机【%@】上，请注意查收", [Utils formatMobile:self.mobile]];
        [self showAlertWithText:msg];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
        
    }else  if (code==NETWORK_ERROR) {
        NSString *msg = ((NSString*)data);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAlertWithText:msg];
        });
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1) {
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TO_JX object:nil userInfo:nil];
        }];
    }
}

-(void)dismissSelf
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)countdown:(NSTimer *)theTimer
{
    if (self.countdown > 0) {
        NSString *title = [NSString stringWithFormat:@"%d秒后重试", self.countdown];
        self.btnSendMobileCode.titleLabel.text = title;
        [self.btnSendMobileCode setTitle: title forState: UIControlStateNormal];
        [self.btnSendMobileCode setEnabled:NO];
        [self.btnSendMobileCode setBackgroundColor:MYCOLOR_GRAY];
        self.countdown--;
    }else{
        [self.btnSendMobileCode setTitle: @"获取验证码" forState: UIControlStateNormal];
        [self.btnSendMobileCode setEnabled:YES];
        [self.btnSendMobileCode setBackgroundColor:MYCOLOR_DARK_RED];
        self.countdown = 59;
        [theTimer invalidate];
    }
}

@end
