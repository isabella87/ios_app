//
//  MyBaoTableViewCell2.h
//  banhuitong
//
//  Created by user on 16-1-7.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MyBaoTableViewCell2 : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblItemNo;
@property (strong, nonatomic) IBOutlet UILabel *lblItemShowName;
@property (strong, nonatomic) IBOutlet UILabel *lblInvestType;
@property (strong, nonatomic) IBOutlet UILabel *lblMoneyRate;
@property (strong, nonatomic) IBOutlet UILabel *lblAmt;
@property (strong, nonatomic) IBOutlet UILabel *lblInvestDate;
@property (strong, nonatomic) IBOutlet UILabel *lblEndDate;
@property (strong, nonatomic) IBOutlet UILabel *lblCurAmt;
@property (strong, nonatomic) IBOutlet UILabel *lblAmtName;
@property (strong, nonatomic) IBOutlet UILabel *lblEndDateName;

@end
