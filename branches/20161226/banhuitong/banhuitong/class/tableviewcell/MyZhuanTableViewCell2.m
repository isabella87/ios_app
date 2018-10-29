//
//  MyZhuanTableViewCell2.m
//  banhuitong
//
//  Created by user on 16-1-8.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "MyZhuanTableViewCell2.h"

@implementation MyZhuanTableViewCell2

- (void)awakeFromNib {
    
    self.lblUnpaid =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblLeftAssignDays.frame.origin.y + 6, 100, 25 )];
    self.lblUnpaid.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.lblUnpaid.textColor = MYCOLOR_DARK_GREEN;
    [self.contentView addSubview:self.lblUnpaid];
    
    self.lblUnpaidName  =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblLeftAssignDays.frame.origin.y + 24, 100, 25 )];
    self.lblUnpaidName.text = @"待收本息";
    self.lblUnpaidName.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.lblUnpaidName];
    
    self.lblApplyDate =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblMoneyRate.frame.origin.y + 6, 100, 25)];
    self.lblApplyDate.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.lblApplyDate.textColor = MYCOLOR_DARK_GREEN;
    [self.contentView addSubview:self.lblApplyDate];
    
    self.lblApplyDateName  =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblMoneyRate.frame.origin.y + 24, 100, 25)];
    self.lblApplyDateName.text = @"转让申请日";
    self.lblApplyDateName.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.lblApplyDateName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
