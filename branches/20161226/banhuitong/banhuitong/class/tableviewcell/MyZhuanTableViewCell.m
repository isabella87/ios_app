//
//  MyZhuanTableViewCell.m
//  banhuitong
//
//  Created by user on 16-1-8.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "MyZhuanTableViewCell.h"

@implementation MyZhuanTableViewCell

- (void)awakeFromNib {
    
    self.lblInvestDate =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblAmt.frame.origin.y + 6, 100, 25 )];
    self.lblInvestDate.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.lblInvestDate.textColor = MYCOLOR_DARK_GREEN;
    [self.contentView addSubview:self.lblInvestDate];
    
    self.lblInvestDateName  =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblAmt.frame.origin.y + 24, 100, 25 )];
    self.lblInvestDateName.text = @"出借日期";
    self.lblInvestDateName.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.lblInvestDateName];
    
    self.lblRepayCapitalDate =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblMoneyRate.frame.origin.y + 6, 100, 25)];
    self.lblRepayCapitalDate.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.lblRepayCapitalDate.textColor = MYCOLOR_DARK_GREEN;
    [self.contentView addSubview:self.lblRepayCapitalDate];
    
    self.lblRepayCapitalDateName  =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblMoneyRate.frame.origin.y + 24, 100, 25)];
    self.lblRepayCapitalDateName.text = @"还本日期";
    self.lblRepayCapitalDateName.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.lblRepayCapitalDateName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
