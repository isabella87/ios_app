//
//  MyAccountController.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/27.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseOperation.h"
#import "AsyncCenter.h"
#import "GetAccOperation.h"
#import "GetAccSurveyOperation.h"
#import "GetPersonalInfoOperation.h"
#import "ShowWebViewController.h"
#import "PersonalInfoController.h"
#import "MyInvestController.h"
#import "RepayPlanController.h"
#import "GetUnreadMsgCountOperation.h"
#import "SettingController.h"

@interface MyAccountController : BaseViewController

@property (strong, nonatomic) IBOutlet UIView *layer1;
@property (strong, nonatomic) IBOutlet UIView *layer2;
@property (strong, nonatomic) IBOutlet UIView *layer3;
@property (strong, nonatomic) IBOutlet UIView *layer4;
@property (strong, nonatomic) IBOutlet UIView *layer5;
@property (strong, nonatomic) IBOutlet UIView *layer6;
@property (strong, nonatomic) IBOutlet UIView *layer7;
@property (strong, nonatomic) IBOutlet UIView *layer8;
@property (strong, nonatomic) IBOutlet UILabel *lblLoginName;
@property (strong, nonatomic) IBOutlet UILabel *lblBalance;
@property (strong, nonatomic) IBOutlet UILabel *lblUnpaid;
@property (strong, nonatomic) IBOutlet UILabel *lblFrz;
@property (strong, nonatomic) IBOutlet UIButton *btnWithdraw;
@property (strong, nonatomic) IBOutlet UIImageView *imgMessage;
@property (strong, nonatomic) IBOutlet UIImageView *imgSettings;
@property (strong, nonatomic) IBOutlet UIButton *btnRecharge;

- (IBAction)toWithdraw:(id)sender;
- (IBAction)toRecharge:(id)sender;

+ (NSDecimalNumber *) getTotalUnpaid;

@end
