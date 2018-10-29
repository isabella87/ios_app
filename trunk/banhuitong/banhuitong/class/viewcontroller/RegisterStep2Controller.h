//
//  RegisterStep2Controller.h
//  banhuitong
//
//  Created by 陈鲁 on 16/1/17.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "AsyncCenter.h"
#import "RegisterOperation.h"
#import "LoginOperation.h"
#import "CustomTabBarViewController.h"

@interface RegisterStep2Controller : BaseViewController

@property(nonatomic)NSString* mobile;
@property(nonatomic)NSString* realname;
@property(nonatomic)NSString* idNo;
@property(nonatomic)NSString* loginName;
@property(nonatomic)NSString* password;
@property(nonatomic)NSString* repassword;
@property(nonatomic)NSString* recommender;
@property(nonatomic)NSString* orgCode;

@property (strong, nonatomic) IBOutlet UITextField *txtRealname;
@property (strong, nonatomic) IBOutlet UITextField *txtIdNo;
@property (strong, nonatomic) IBOutlet UITextField *txtLoginName;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtRepassword;
@property (strong, nonatomic) IBOutlet UITextField *txtRecommender;
@property (strong, nonatomic) IBOutlet UITextField *txtOrgCode;
@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;

- (IBAction)submit:(id)sender;

@end
