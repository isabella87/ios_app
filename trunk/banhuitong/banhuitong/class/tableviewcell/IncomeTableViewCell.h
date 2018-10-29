//
//  IncomeTableViewCell.h
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncomeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblDatepoint;
@property (strong, nonatomic) IBOutlet UILabel *lblAmt;
@property (strong, nonatomic) IBOutlet UILabel *lblType;
@property (strong, nonatomic) IBOutlet UILabel *lblItemShowName;
@property (strong, nonatomic) IBOutlet UIImageView *imgSpinner;

@end
