//
//  PrjCaTableViewCell.h
//  banhuitong
//
//  Created by user on 15-12-30.
//  Copyright (c) 2015年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrjCaTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblAssignRate;
@property (strong, nonatomic) IBOutlet UILabel *lblAssignAmt;
@property (strong, nonatomic) IBOutlet UILabel *lblDaysLeft;
@property (strong, nonatomic) IBOutlet UILabel *btnToInvest;
@property (strong, nonatomic) IBOutlet UILabel *lblItemNo;
@property (strong, nonatomic) IBOutlet UILabel *lblItemShowName;
@property (strong, nonatomic) IBOutlet UILabel *lblType;

@end
