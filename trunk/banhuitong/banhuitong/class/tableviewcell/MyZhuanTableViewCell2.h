//
//  MyZhuanTableViewCell2.h
//  banhuitong
//
//  Created by user on 16-1-8.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MyZhuanTableViewCell2 : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblType;
@property (strong, nonatomic) IBOutlet UILabel *lblItemNo;
@property (strong, nonatomic) IBOutlet UILabel *lblItemShowName;
@property (strong, nonatomic) IBOutlet UILabel *lblLeftAssignDays;
@property (strong, nonatomic) IBOutlet UILabel *lblUnpaid;
@property (strong, nonatomic) IBOutlet UILabel *lblAssignAmt;
@property (strong, nonatomic) IBOutlet UILabel *lblMoneyRate;
@property (strong, nonatomic) IBOutlet UILabel *lblApplyDate;
@property (strong, nonatomic) IBOutlet UILabel *lblUnpaidName;
@property (strong, nonatomic) IBOutlet UILabel *lblApplyDateName;

@end
