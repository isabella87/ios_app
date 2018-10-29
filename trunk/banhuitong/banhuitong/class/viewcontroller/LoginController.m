//
//  LoginController.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/27.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "LoginController.h"

@implementation LoginController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader2:@"登录"];
    [self.txtPassword setSecureTextEntry:YES];
    self.swRemeberUser.on = YES;
    [self.swRemeberUser addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissSelf) name:NOTIFY_BACK_INDEX_AFTER_REGISTER object:nil];
    
    NSString *userRemembered = [[NSUserDefaults standardUserDefaults] objectForKey:REMEMBER_USER];
    
    if (userRemembered) {
        self.txtUsername.text = userRemembered;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_BACK_INDEX_AFTER_REGISTER object:nil];
}

- (void) onBackAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_BACK_INDEX object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_BACK_INDEX_FROM_DETAIL object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectPageNotification" object:self userInfo:@{@"index":@0}];
    }];
}

- (IBAction)login:(id)sender {
    NSString *userName = self.txtUsername.text;
    NSString *password = self.txtPassword.text;
    
    if ([userName isEqualToString:@""]) {
        [self showAlertWithText:@"用户名不能为空！"];
        [self.txtUsername becomeFirstResponder];
        return;
    } else if ([password isEqualToString:@""]) {
        [self showAlertWithText:@"密码不能为空！"];
        [self.txtPassword becomeFirstResponder];
        return;
    }else {
        [self showActiveLoading];
        BaseOperation *op = [[LoginOperation alloc] initWithUsername:userName andWithPassword:password andWithDelegate:self];
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    }
}

- (IBAction)register:(id)sender {
    InputMobileController *controller = (InputMobileController *)[Utils getControllerFromStoryboard:@"InputMobileVC"];
    [self presentViewController:controller animated:NO completion:nil];
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code == RESP_LOGIN_SUCCESS) {
        NSLog(@"登录成功",nil);
        
        [[NSUserDefaults standardUserDefaults] setObject:self.txtUsername.text forKey:SAVE_USERNAME];
        [[NSUserDefaults standardUserDefaults] setObject:self.txtPassword.text forKey:SAVE_PASSWORD];
        
        BOOL isRememberUser = [self.swRemeberUser isOn];
        if (isRememberUser==YES) {
            [[NSUserDefaults standardUserDefaults] setObject:self.txtUsername.text forKey:REMEMBER_USER];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:REMEMBER_USER];
        }
        
        [self onBackAction];
    }else if (code == RESP_LOGIN_FAILED) {
        NSLog(@"登录失败",nil);
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登录失败！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];

    }
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {

    }else {

    }
}

-(void)dismissSelf
{
    [self dismissViewControllerAnimated:NO completion:^{
        [self dismissViewControllerAnimated:NO completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_BACK_INDEX object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"selectPageNotification" object:self userInfo:@{@"index":@0}];
        }];
    }];
}

- (IBAction)findbackPwd:(id)sender {
    FindbackPwdController *controller = (FindbackPwdController *)[Utils getControllerFromStoryboard:@"FindbackPwdVC"];
    [self presentViewController:controller animated:NO completion:nil];
}
@end
