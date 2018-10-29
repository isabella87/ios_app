//
//  RegisterStep1Controller.h
//  banhuitong
//
//  Created by 陈鲁 on 16/1/17.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "AsyncCenter.h"
#import "GetCaptchaOperation.h"
#import "SendMobileCodeLostPwdOperation.h"
#import "FindbackPwdOperation.h"

@interface FindbackPwdController : BaseViewController

@property(nonatomic)NSString* usernameOrMobile;
@property(nonatomic)NSString* mobileCode;
@property(nonatomic)NSString* captchaCode;
@property(nonatomic)int countdown;

@property (strong, nonatomic) IBOutlet UITextField *txtCaptchaCode;
@property (strong, nonatomic) IBOutlet UIImageView *imgCaptchaCode;
@property (strong, nonatomic) IBOutlet UITextField *txtMobileCode;
@property (strong, nonatomic) IBOutlet UIButton *btnSendMobileCode;
@property (strong, nonatomic) IBOutlet UIButton *btnFindbackPwd;
@property (strong, nonatomic) IBOutlet UITextField *txtUsernameOrMobile;

- (IBAction)sendMobileCode:(id)sender;
- (IBAction)findbackPwd:(id)sender;

@end
