//
//  MyBaoTableViewCell3.m
//  banhuitong
//
//  Created by user on 16-1-7.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "MyBaoTableViewCell3.h"

@implementation MyBaoTableViewCell3

- (void)awakeFromNib {
    
    self.lblholdDays =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblMoneyRate.frame.origin.y + 6, 100, 25 )];
    self.lblholdDays.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [self.contentView addSubview:self.lblholdDays];
    
    self.lblholdDaysName  =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblMoneyRate.frame.origin.y + 24, 100, 25 )];
    self.lblholdDaysName.text = @"持有天数";
    self.lblholdDaysName.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.lblholdDaysName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
