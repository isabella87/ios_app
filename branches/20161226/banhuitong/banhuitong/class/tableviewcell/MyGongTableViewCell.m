//
//  MyGongTableViewCell.m
//  banhuitong
//
//  Created by user on 16-1-7.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "MyGongTableViewCell.h"

@implementation MyGongTableViewCell

- (void)awakeFromNib {
    
    self.lblAmt =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblMoneyRate.frame.origin.y + 6, 100, 25 )];
    self.lblAmt.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.lblAmt.textColor = MYCOLOR_DARK_RED;
    [self.contentView addSubview:self.lblAmt];
    
    self.lblAmtName  =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblMoneyRate.frame.origin.y + 24, 100, 25 )];
    self.lblAmtName.text = @"出借金额";
    self.lblAmtName.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.lblAmtName];
    
    self.lblRepayCapitalDate =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblInvestDate.frame.origin.y + 6, 100, 25)];
    self.lblRepayCapitalDate.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.lblRepayCapitalDate.textColor = MYCOLOR_DARK_GREEN;
    [self.contentView addSubview:self.lblRepayCapitalDate];
    
    self.lblRepayCapitalDateName  =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblInvestDate.frame.origin.y + 24, 100, 25)];
    self.lblRepayCapitalDateName.text = @"还本日期";
    self.lblRepayCapitalDateName.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.lblRepayCapitalDateName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
