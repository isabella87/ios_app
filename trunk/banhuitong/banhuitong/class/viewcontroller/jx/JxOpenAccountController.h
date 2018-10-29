//
//  JxOpenAccountController.h
//  banhuitong
//
//  Created by user on 16/7/1.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"

@interface JxOpenAccountController : BaseViewController

@property (strong, nonatomic) IBOutlet UITextField *tvRealname;
@property (strong, nonatomic) IBOutlet UITextField *tvMobile;
@property (strong, nonatomic) IBOutlet UITextField *tvID;
@property (strong, nonatomic) IBOutlet UITextField *tvBankcard;
@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
@property (strong, nonatomic) IBOutlet UITextField *tvMobileCode;
@property (strong, nonatomic) IBOutlet UIButton *btnSendMobileCode;

@property(nonatomic) NSString *bankcard;
@property(nonatomic) NSString *idNo;
@property(nonatomic) NSString *mobile;
@property(nonatomic) NSString *mobileCode;
@property(nonatomic)int countdown;

- (IBAction)submit:(id)sender;
- (IBAction)sendMobileCode:(id)sender;

@end
