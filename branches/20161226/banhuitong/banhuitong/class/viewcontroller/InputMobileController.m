//
//  InputMobileController.m
//  banhuitong
//
//  Created by 陈鲁 on 16/1/17.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "InputMobileController.h"

@interface InputMobileController ()

@end

@implementation InputMobileController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader2:@"填写手机号"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissSelf) name:NOTIFY_BACK_INDEX_AFTER_REGISTER object:nil];
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_BACK_INDEX_AFTER_REGISTER object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)next:(id)sender {
    self.mobile = [self.txtMobile.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([self validate]) {
        BaseOperation *op = [[IsRegisterOperation alloc] initWithDelegate:self];
        ((IsRegisterOperation *)op).mobile = self.mobile;
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    }
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code==REGISTER_ALREADY) {
        [self showAlertWithText:@"该手机号已注册！"];
        
    }else if (code==REGISTER_NOT_YET) {
        RegisterStep1Controller *controller = (RegisterStep1Controller *)[Utils getControllerFromStoryboard:@"RegisterStep1VC"];
        controller.mobile = self.mobile;
        [self presentViewController:controller animated:NO completion:nil];
        
    }else  if (code==NETWORK_ERROR) {
        NSString *msg = ((NSString*)data);
        [self showAlertWithText:msg];
    }
}


-(bool) validate{
    if([self.mobile isEqualToString:@""]){
        [self showAlertWithText:@"手机号码不能为空！"];
        [self.txtMobile becomeFirstResponder];
        return false;
    }
    
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PATTERN_MOBILE];
    BOOL result = [numberPre evaluateWithObject:self.mobile];
    if(!result){
        [self showAlertWithText:@"手机号码无效！"];
        [self.txtMobile becomeFirstResponder];
        return false;
    }
    return true;
}

-(void)dismissSelf
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
