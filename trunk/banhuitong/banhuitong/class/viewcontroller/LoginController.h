//
//  LoginController.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/27.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Constants.h"
#import "BaseOperation.h"
#import "AsyncCenter.h"
#import "LoginOperation.h"
#import "MainViewController.h"
#import "InputMobileController.h"
#import "FindbackPwdController.h"

@interface LoginController : BaseViewController

@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UISwitch *swRemeberUser;
@property (strong, nonatomic) IBOutlet UIButton *btnRegister;

- (IBAction)login:(id)sender;
- (IBAction)register:(id)sender;
- (IBAction)findbackPwd:(id)sender;

@end
