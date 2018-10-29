//
//  RegisterStep1Controller.m
//  banhuitong
//
//  Created by 陈鲁 on 16/1/17.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "RegisterStep1Controller.h"

@interface RegisterStep1Controller ()

@end

@implementation RegisterStep1Controller

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader2:@"手机验证"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissSelf) name:NOTIFY_BACK_INDEX_AFTER_REGISTER object:nil];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCaptcha:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    [self.imgCaptchaCode setUserInteractionEnabled:YES];
    [self.imgCaptchaCode addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer* singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAgreement:)];
    singleTap2.delegate = self;
    singleTap2.cancelsTouchesInView = NO;
    [self.lblAgree setUserInteractionEnabled:YES];
    [self.lblAgree addGestureRecognizer:singleTap2];
    
    self.countdown = 59;
    
    [self showCaptcha:nil];
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_BACK_INDEX_AFTER_REGISTER object:nil];
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
        NSString *msg = [NSString stringWithFormat:@"手机激活码已发送到手机【%@】上，请注意查收", [Utils formatMobile:self.mobile]];
        [self showAlertWithText:msg];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
        
    }else if (code==MOBILE_CODE_VALID) {
        NSLog(@"%@", @"进入注册下一步。");
        RegisterStep2Controller *controller = (RegisterStep2Controller *)[Utils getControllerFromStoryboard:@"RegisterStep2VC"];
        controller.mobile = self.mobile;
        [self presentViewController:controller animated:NO completion:nil];
        
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

-(void) showAgreement:(UITapGestureRecognizer *)sender{
    ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebViewVC"];
    controller.myTitle = @"注册协议";
    controller.myUrl = [NSString stringWithFormat:@"%@app/reg-contact.html", MOBILE_ADDRESS];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)sendMobileCode:(id)sender {
    self.captchaCode = [self.txtCaptchaCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([self validate2]){
        BaseOperation *op = [[SendMobileCodeOperation alloc] initWithDelegate:self];
        ((SendMobileCodeOperation *)op).mobile = self.mobile;
        ((SendMobileCodeOperation *)op).captcha = self.captchaCode;
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    }
}

- (IBAction)next:(id)sender {
    self.mobileCode = [self.txtMobileCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([self validate]){
        BaseOperation *op = [[ValidateMobileCodeOperation alloc] initWithDelegate:self];
        ((ValidateMobileCodeOperation *)op).mobile = self.mobile;
        ((ValidateMobileCodeOperation *)op).mobileCode = self.mobileCode;
        ((ValidateMobileCodeOperation *)op).captcha = self.captchaCode;
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    }
}

-(BOOL) validate{
    if([self.mobileCode isEqualToString:@""]){
        [self showAlertWithText:@"激活码不能为空！"];
        [self.txtMobileCode becomeFirstResponder];
        return false;
    }
    
    if([self.swAgree isOn]==NO){
         [self showAlertWithText:@"先阅读并勾选《班汇通注册协议》！"];
        return false;
    }
    return true;
}

-(BOOL) validate2{
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

@end
