//
//  RegisterStep1Controller.m
//  banhuitong
//
//  Created by 陈鲁 on 16/1/17.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "FindbackPwdController.h"

@interface FindbackPwdController ()

@end

@implementation FindbackPwdController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader2:@"找回密码"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCaptcha:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    [self.imgCaptchaCode setUserInteractionEnabled:YES];
    [self.imgCaptchaCode addGestureRecognizer:singleTap];
    
    self.countdown = 59;
    
    [self showCaptcha:nil];
}

- (void) dealloc{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code==GET_CAPTCHA_SUCCESS) {
        self.imgCaptchaCode.image = (UIImage*)data;
        
    }else if (code==SEND_MOBILE_CODE_SUCCESS) {
        NSString *msg = [NSString stringWithFormat:@"手机激活码已发送到手机【%@】上，请注意查收", (NSString*)data];
        [self showAlertWithText:msg];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
        
    }else if (code==MOBILE_CODE_VALID) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码已发送到手机上，请注意查收" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        alert.tag = 1;
        [alert show];
        
    }else  if (code==NETWORK_ERROR) {
        NSString *msg = ((NSString*)data);
        dispatch_async(dispatch_get_main_queue(), ^{
             [self showAlertWithText:msg];
        });
    }
}

-(void) showCaptcha:(UITapGestureRecognizer *)sender{
    BaseOperation *op = [[GetCaptchaOperation alloc] initWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
}

- (IBAction)sendMobileCode:(id)sender {
    self.captchaCode = [self.txtCaptchaCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.usernameOrMobile = [self.txtUsernameOrMobile.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([self validate2]){
        BaseOperation *op = [[SendMobileCodeLostPwdOperation alloc] initWithDelegate:self];
        ((SendMobileCodeLostPwdOperation *)op).usernameOrMobile = self.usernameOrMobile;
        ((SendMobileCodeLostPwdOperation *)op).captcha = self.captchaCode;
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    }
}

- (IBAction)findbackPwd:(id)sender {
    self.mobileCode = [self.txtMobileCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.usernameOrMobile = [self.txtUsernameOrMobile.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([self validate]){
        BaseOperation *op = [[FindbackPwdOperation alloc] initWithDelegate:self];
        ((FindbackPwdOperation *)op).usernameOrMobile = self.usernameOrMobile;
        ((FindbackPwdOperation *)op).activeCode = self.mobileCode;
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    }
}

-(BOOL) validate{
    if([self.usernameOrMobile isEqualToString:@""]){
        [self showAlertWithText:@"请输入正确的用户名或手机号码！"];
        [self.txtUsernameOrMobile becomeFirstResponder];
        return false;
    }
    if([self.mobileCode isEqualToString:@""]){
        [self showAlertWithText:@"激活码不能为空！"];
        [self.txtMobileCode becomeFirstResponder];
        return false;
    }
    return true;
}

-(BOOL) validate2{
    if([self.usernameOrMobile isEqualToString:@""]){
        [self showAlertWithText:@"请输入正确的用户名或手机号码！"];
        [self.txtUsernameOrMobile becomeFirstResponder];
        return false;
    }
    
    if([self.captchaCode isEqualToString:@""]){
        [self showAlertWithText:@"验证码不能为空！"];
        [self.txtCaptchaCode becomeFirstResponder];
        return false;
    }
    return true;
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
        [self.btnSendMobileCode setTitle: @"获取激活码" forState: UIControlStateNormal];
        [self.btnSendMobileCode setEnabled:YES];
        [self.btnSendMobileCode setBackgroundColor:MYCOLOR_DARK_RED];
        self.countdown = 59;
        [theTimer invalidate];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

@end
