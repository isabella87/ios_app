//
//  JxSetTradePwdController.h
//  banhuitong
//
//  Created by user on 16/7/1.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"

@interface JxSetTradePwdController : BaseViewController

@property (strong, nonatomic) IBOutlet UITextField *tvMobileCode;
@property (strong, nonatomic) IBOutlet UIButton *btnSendMobileCode;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;

@property(nonatomic) NSString *mobile;
@property(nonatomic) NSString *mobileCode;
@property(nonatomic)int countdown;

- (IBAction)next:(id)sender;
- (IBAction)sendMobileCode:(id)sender;

@end
