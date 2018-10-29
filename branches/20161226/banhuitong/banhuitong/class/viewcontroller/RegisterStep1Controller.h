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
#import "SendMobileCodeOperation.h"
#import "ValidateMobileCodeOperation.h"
#import "RegisterStep2Controller.h"
#import "ShowWebViewController.h"

@interface RegisterStep1Controller : BaseViewController

@property(nonatomic)NSString* mobile;
@property(nonatomic)NSString* mobileCode;
@property(nonatomic)NSString* captchaCode;
@property(nonatomic)int countdown;

@property (strong, nonatomic) IBOutlet UITextField *txtCaptchaCode;
@property (strong, nonatomic) IBOutlet UIImageView *imgCaptchaCode;
@property (strong, nonatomic) IBOutlet UITextField *txtMobileCode;
@property (strong, nonatomic) IBOutlet UIButton *btnSendMobileCode;
@property (strong, nonatomic) IBOutlet UISwitch *swAgree;
@property (strong, nonatomic) IBOutlet UILabel *lblAgree;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;

- (IBAction)sendMobileCode:(id)sender;
- (IBAction)next:(id)sender;

@end
