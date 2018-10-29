//
//  MyBaoTableViewCell2.m
//  banhuitong
//
//  Created by user on 16-1-7.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "MyBaoTableViewCell2.h"

@implementation MyBaoTableViewCell2

- (void)awakeFromNib {
    
    self.lblAmt =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblMoneyRate.frame.origin.y + 6, 100, 25 )];
    self.lblAmt.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.lblAmt.textColor = MYCOLOR_DARK_RED;
    [self.contentView addSubview:self.lblAmt];
    
    self.lblAmtName  =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblMoneyRate.frame.origin.y + 24, 100, 25 )];
    self.lblAmtName.text = @"出借本金";
    self.lblAmtName.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.lblAmtName];
    
    self.lblEndDate =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblInvestDate.frame.origin.y + 6, 100, 25)];
    self.lblEndDate.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.lblEndDate.textColor = MYCOLOR_DARK_GREEN;
    [self.contentView addSubview:self.lblEndDate];
    
    self.lblEndDateName  =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblInvestDate.frame.origin.y + 24, 100, 25)];
    self.lblEndDateName.text = @"还本日期";
    self.lblEndDateName.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.lblEndDateName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
