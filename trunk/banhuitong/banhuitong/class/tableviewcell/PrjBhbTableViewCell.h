//
//  PrjBhbTableViewCell.h
//  banhuitong
//
//  Created by user on 15-12-31.
//  Copyright (c) 2015年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"
#import "AppDelegate.h"

@interface PrjBhbTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblNameOfTargetRate;

@property (strong, nonatomic) IBOutlet UILabel *lblItemNo;
@property (strong, nonatomic) IBOutlet UILabel *lblItemShowName;
@property (strong, nonatomic) IBOutlet UILabel *lblType;
@property (strong, nonatomic) IBOutlet UILabel *lblTargetRate;
@property (strong, nonatomic) IBOutlet UILabel *lblBorrowDays;
@property (strong, nonatomic) IBOutlet UILabel *lblDaysLeft;
@property (strong, nonatomic) IBOutlet UILabel *btnToInvest;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property(nonatomic) ProgressView *pv;
@property (strong, nonatomic) IBOutlet UILabel *lblBorrowDaysName;


@end
