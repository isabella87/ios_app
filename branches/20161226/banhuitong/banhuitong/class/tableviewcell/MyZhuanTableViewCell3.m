//
//  MyZhuanTableViewCell3.m
//  banhuitong
//
//  Created by user on 16-1-8.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "MyZhuanTableViewCell3.h"

@implementation MyZhuanTableViewCell3

- (void)awakeFromNib {
    
    self.lblFee =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblAssignAmt.frame.origin.y + 6, 100, 25 )];
    self.lblFee.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.lblFee.textColor = MYCOLOR_DARK_RED;
    [self.contentView addSubview:self.lblFee];
    
    self.lblFeeName  =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblAssignAmt.frame.origin.y + 24, 100, 25 )];
    self.lblFeeName.text = @"转让手续费";
    self.lblFeeName.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.lblFeeName];
    
    self.lblTransDate =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblMoneyRate.frame.origin.y + 6, 100, 25)];
    self.lblTransDate.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.lblTransDate.textColor = MYCOLOR_DARK_GREEN;
    [self.contentView addSubview:self.lblTransDate];
    
    self.lblTransDateName  =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, self.lblMoneyRate.frame.origin.y + 24, 100, 25)];
    self.lblTransDateName.text = @"转让成交日";
    self.lblTransDateName.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.lblTransDateName];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
