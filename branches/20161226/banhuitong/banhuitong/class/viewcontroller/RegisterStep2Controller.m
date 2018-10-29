//
//  RegisterStep2Controller.m
//  banhuitong
//
//  Created by 陈鲁 on 16/1/17.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "RegisterStep2Controller.h"

@interface RegisterStep2Controller ()

@end

@implementation RegisterStep2Controller

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader2:@"完善资料"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc{
}

- (IBAction)submit:(id)sender {
    self.realname = [self.txtRealname.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.idNo = [self.txtIdNo.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.loginName = [self.txtLoginName.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.password = [self.txtPassword.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.repassword = [self.txtRepassword.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.recommender = [self.txtRecommender.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.orgCode = [self.txtOrgCode.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([self validate]){
        BaseOperation *op = [[RegisterOperation alloc] initWithDelegate:self];
        ((RegisterOperation *)op).mobile = self.mobile;
        ((RegisterOperation *)op).realname = self.realname;
        ((RegisterOperation *)op).idNo = self.idNo;
        ((RegisterOperation *)op).username = self.loginName;
        ((RegisterOperation *)op).password = self.password;
        ((RegisterOperation *)op).recommenderNo = self.recommender;
        ((RegisterOperation *)op).orgCode = self.orgCode;
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    }
}

-(bool) validate{
    if([self.realname isEqualToString:@""]){
        [self showAlertWithText:@"真实姓名不能为空！"];
        [self.txtRealname becomeFirstResponder];
        return false;
    }
    
//    if([self.idNo isEqualToString:@""]){
//        [self showAlertWithText:@"身份证号不能为空！"];
//        [self.txtIdNo becomeFirstResponder];
//        return false;
//    }
    
    if([self.loginName isEqualToString:@""]){
        [self showAlertWithText:@"用户名不能为空！"];
        [self.txtLoginName becomeFirstResponder];
        return false;
    }
    
    if([self.password isEqualToString:@""]){
        [self showAlertWithText:@"密码不能为空！"];
        [self.txtPassword becomeFirstResponder];
        return false;
    }
    
    if(![self.repassword isEqualToString:self.password]){
        [self showAlertWithText:@"密码不一致！"];
        [self.txtRepassword becomeFirstResponder];
        return false;
    }
    
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PATTERN_LETTER_NUMBER];
    BOOL result = [numberPre evaluateWithObject:self.recommender];
    if(!result){
        [self showAlertWithText:@"推荐码只包含数字和字母！"];
        [self.txtRecommender becomeFirstResponder];
        return false;
    }

    return true;
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code==REGISTER_SUCCESS) {
        BaseOperation *op = [[LoginOperation alloc] initWithUsername:self.loginName andWithPassword:self.password andWithDelegate:self];
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
        
    }if (code==RESP_LOGIN_SUCCESS) {
        [[NSUserDefaults standardUserDefaults] setObject:self.loginName forKey:SAVE_USERNAME];
        [[NSUserDefaults standardUserDefaults] setObject:self.password forKey:SAVE_PASSWORD];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        alert.tag = 1;
        [alert show];

    }else  if (code==NETWORK_ERROR) {
        NSString *msg = ((NSString*)data);
        [self showAlertWithText:msg];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_BACK_INDEX_AFTER_REGISTER object:nil userInfo:nil];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

@end
