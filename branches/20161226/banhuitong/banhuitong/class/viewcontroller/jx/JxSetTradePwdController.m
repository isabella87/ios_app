//
//  JxSetTradePwdController.m
//  banhuitong
//
//  Created by user on 16/7/1.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "JxSetTradePwdController.h"
#import "BaseOperation.h"
#import "AsyncCenter.h"
#import "CacheObject.h"
#import "JxGetMobileCodeWhenSetTradePwdOperation.h"
#import "ShowWebViewController.h"

@interface JxSetTradePwdController ()

@end

@implementation JxSetTradePwdController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader2:self.title];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissSelf) name:NOTIFY_BACK_MYACCOUNT object:nil];
    
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

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_BACK_MYACCOUNT object:nil];
}

- (IBAction)next:(id)sender {
    if ([self validate]) {
        ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebView2VC"];
        controller.noHeader = YES;
        controller.hasFooter = YES;
        
        controller.myUrl = [NSString stringWithFormat:@"%@app/to-jxpay-password.html?mobile-number=%@&&mobile-code=%@", MOBILE_ADDRESS, self.mobile, self.mobileCode];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (IBAction)sendMobileCode:(id)sender {
    BaseOperation *op = [[JxGetMobileCodeWhenSetTradePwdOperation alloc] initWithDelegate:self];
    ((JxGetMobileCodeWhenSetTradePwdOperation *)op).mobile = self.mobile;
     ((JxGetMobileCodeWhenSetTradePwdOperation *)op).type = @"2";
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
}

-(bool) validate{
    self.mobileCode = [self.tvMobileCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
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
    
   if (code==SEND_MOBILE_CODE_SUCCESS) {
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
