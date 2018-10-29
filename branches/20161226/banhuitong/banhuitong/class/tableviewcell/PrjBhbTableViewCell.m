//
//  PrjBhbTableViewCell.m
//  banhuitong
//
//  Created by user on 15-12-31.
//  Copyright (c) 2015年 banhuitong. All rights reserved.
//

#import "PrjBhbTableViewCell.h"

@implementation PrjBhbTableViewCell

- (void)awakeFromNib {
    
    self.pv = [[ProgressView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.3, 35, 50, 50)];
    self.pv .arcFinishColor = MYCOLOR_DARK_RED;
    self.pv .arcUnfinishColor = MYCOLOR_DARK_RED;
    self.pv.arcBackColor = [UIColor lightGrayColor];
    [self addSubview:self.pv];
    
    self.lblBorrowDays =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, 45, self.lblBorrowDays.frame.size.width, self.lblBorrowDays.frame.size.height )];
    self.lblBorrowDays.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [self.contentView addSubview:self.lblBorrowDays];
    
    self.lblBorrowDaysName  =  [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/2, 63, 50, 25 )];
    self.lblBorrowDaysName.text = @"存续期";
    self.lblBorrowDaysName.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.lblBorrowDaysName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
