//
//  PrjEntTableViewCell.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/22.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"
#import "Constants.h"
#import "AppDelegate.h"

@interface PrjEntTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblType;
@property (strong, nonatomic) IBOutlet UILabel *btnToInvest;
@property (strong, nonatomic) IBOutlet UILabel *lblItemNo;
@property (strong, nonatomic) IBOutlet UILabel *lblItemShowName;
@property (strong, nonatomic) IBOutlet UILabel *lblMoneyRate;
@property (strong, nonatomic) IBOutlet UILabel *lblBorrowDays;
@property (strong, nonatomic) IBOutlet UILabel *lbldaysLeft;
@property(nonatomic) ProgressView *pv;
@property (strong, nonatomic) IBOutlet UILabel *lblBorrowDaysName;
@property (strong, nonatomic) IBOutlet UIImageView *imgSeal;

@end
