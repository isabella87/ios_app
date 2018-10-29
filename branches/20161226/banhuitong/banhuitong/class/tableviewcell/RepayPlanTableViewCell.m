//
//  RepayPlanTableViewCell.m
//  banhuitong
//
//  Created by 陈鲁 on 16/1/16.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "RepayPlanTableViewCell.h"

@implementation RepayPlanTableViewCell

- (void)awakeFromNib {
    
    self.myView = [[MyView2 alloc]initWithFrame:CGRectMake(100, 0, 20, 100)];
    [self addSubview:self.myView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
