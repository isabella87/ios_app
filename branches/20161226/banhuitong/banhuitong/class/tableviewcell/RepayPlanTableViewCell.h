//
//  RepayPlanTableViewCell.h
//  banhuitong
//
//  Created by 陈鲁 on 16/1/16.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyView2.h"

@interface RepayPlanTableViewCell: UITableViewCell

@property(nonatomic) NSDictionary *unpaid;

@property(nonatomic) MyView2 *myView;
@property (strong, nonatomic) IBOutlet UILabel *lblDatepoint;
@property (strong, nonatomic) IBOutlet UILabel *lblItemShowName;
@property (strong, nonatomic) IBOutlet UILabel *lblTranType;
@property (strong, nonatomic) IBOutlet UILabel *lblAmt;

@end
