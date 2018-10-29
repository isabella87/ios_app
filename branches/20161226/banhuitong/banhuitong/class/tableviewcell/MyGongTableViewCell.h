//
//  MyGongTableViewCell.h
//  banhuitong
//
//  Created by user on 16-1-7.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Constants.h"

@interface MyGongTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblType;
@property (strong, nonatomic) IBOutlet UILabel *lblItemNo;
@property (strong, nonatomic) IBOutlet UILabel *lblItemShowName;
@property (strong, nonatomic) IBOutlet UILabel *lblMoneyRate;
@property (strong, nonatomic) IBOutlet UILabel *lblAmt;
@property (strong, nonatomic) IBOutlet UILabel *lblBorrowDays;
@property (strong, nonatomic) IBOutlet UILabel *lblInvestDate;
@property (strong, nonatomic) IBOutlet UILabel *lblRepayCapitalDate;
@property (strong, nonatomic) IBOutlet UILabel *lblRepayCapitalDateName;
@property (strong, nonatomic) IBOutlet UILabel *lblAmtName;

@end
