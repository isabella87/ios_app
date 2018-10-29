//
//  ApplyCaController.h
//  banhuitong
//
//  Created by 陈鲁 on 16/1/15.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "AsyncCenter.h"
#import "PrjEntDetailOperation.h"
#import "CacheObject.h"
#import "SendMobileCodeOperation2.h"
#import "CaApplyOperation.h"

@interface ApplyCaController : BaseViewController

@property(nonatomic)int tiId;
@property(nonatomic)int lockType;
@property(nonatomic) NSDecimalNumber* maxAssignAmt;
@property(nonatomic) NSDecimalNumber* minAssignAmt;
@property(nonatomic) NSDecimalNumber* maxAssignRate;
@property(nonatomic) NSDecimalNumber* minAssignRate;
@property(nonatomic) NSDecimalNumber* capital;
@property(nonatomic) NSDecimalNumber* unpaidAmt;
@property(nonatomic) long waitingDays;
@property(nonatomic) long daysRemaining;
@property(nonatomic) long maxWaitingDays;
@property(nonatomic) NSString* mobileCode;
@property(nonatomic) NSString* password;
@property(nonatomic) NSDecimalNumber* assignAmt;
@property(nonatomic) NSDecimalNumber* assignRate;
@property(nonatomic) NSString* mobile;

@property (strong, nonatomic) IBOutlet UILabel *lblItemNo;
@property (strong, nonatomic) IBOutlet UILabel *lblItemShowName;
@property (strong, nonatomic) IBOutlet UILabel *lblRemainingBorrowDays;
@property (strong, nonatomic) IBOutlet UILabel *lblMoneyRate;
@property (strong, nonatomic) IBOutlet UILabel *lblUnpaid;
@property (strong, nonatomic) IBOutlet UITextField *txtAssignDays;
@property (strong, nonatomic) IBOutlet UILabel *lblAssignRate;
@property (strong, nonatomic) IBOutlet UITextField *txtAssignRate;
@property (strong, nonatomic) IBOutlet UILabel *lblAssignAmt;
@property (strong, nonatomic) IBOutlet UITextField *txtAssignAmt;
@property (strong, nonatomic) IBOutlet UILabel *lblSendCode;
@property (strong, nonatomic) IBOutlet UITextField *txtCode;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnApply;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)indexChanged:(id)sender;
- (IBAction)onEndEditAssignRate:(id)sender;
- (IBAction)onEndEditAssignAmt:(id)sender;
- (IBAction)onApply:(id)sender;

@end
