//
//  PersonalInfoController.m
//  banhuitong
//
//  Created by user on 16-1-6.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "PersonalInfoController.h"

@interface PersonalInfoController ()

@end

@implementation PersonalInfoController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showHeader2:@"个人概况"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblLoginName.text = [[CacheObject sharedInstance].personalInfo objectForKey:@"loginName"];
    self.lblRealName.text = [[CacheObject sharedInstance].personalInfo objectForKey:@"realName"];
    self.lblIdNo.text = [[CacheObject sharedInstance].personalInfo objectForKey:@"idCard"];
    self.lblMobile.text = [[CacheObject sharedInstance].personalInfo objectForKey:@"mobile"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc{
}

- (IBAction)logout:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认退出登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1) {
        if (buttonIndex==1) {
            [self showActiveLoading];
            
            BaseOperation *op = [[LogoutOperation alloc] initWithDelegate:self];
            [[AsyncCenter sharedInstance].operationQueue addOperation:op];
        }
    }
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code == RESP_LOGOUT_SUCCESS) {
        NSLog(@"登出成功",nil);
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:SAVE_USERNAME];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:SAVE_PASSWORD];
        
         [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_BACK_INDEX object:nil userInfo:nil];
        }];
    }
}

@end
