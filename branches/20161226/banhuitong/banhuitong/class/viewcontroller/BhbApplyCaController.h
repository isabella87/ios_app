//
//  BhbApplyCaController.h
//  banhuitong
//
//  Created by 陈鲁 on 16/1/15.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "AsyncCenter.h"
#import "PrjBhbDetailOperation.h"
#import "CacheObject.h"
#import "SendMobileCodeOperation2.h"
#import "BhbCaApplyOperation.h"

@interface BhbApplyCaController : BaseViewController

@property(nonatomic)int tiId;
@property(nonatomic) NSDecimalNumber* maxAssignAmt;
@property(nonatomic) NSDecimalNumber* minAssignAmt;
@property(nonatomic) NSDecimalNumber* unPaiedBonusAmt;
@property(nonatomic) long waitingDays;
@property(nonatomic) long daysRemaining;
@property(nonatomic) long maxWaitingDays;
@property(nonatomic) NSString* mobileCode;
@property(nonatomic) NSString* password;
@property(nonatomic) NSDecimalNumber* assignAmt;
@property(nonatomic) NSString* mobile;
@property(nonatomic) long expectedBorrowTime;
@property(nonatomic) long borrowDays;

@property (strong, nonatomic) IBOutlet UILabel *lblItemNo;
@property (strong, nonatomic) IBOutlet UILabel *lblItemShowName;
@property (strong, nonatomic) IBOutlet UILabel *lblRemainingBorrowDays;
@property (strong, nonatomic) IBOutlet UILabel *lblMoneyRate;
@property (strong, nonatomic) IBOutlet UILabel *lblUnpaid;
@property (strong, nonatomic) IBOutlet UITextField *txtAssignDays;
@property (strong, nonatomic) IBOutlet UITextField *txtAssignAmt;
@property (strong, nonatomic) IBOutlet UILabel *lblSendCode;
@property (strong, nonatomic) IBOutlet UITextField *txtCode;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnApply;
@property (strong, nonatomic) IBOutlet UILabel *lblCurAmt;

- (IBAction)onApply:(id)sender;

@end
