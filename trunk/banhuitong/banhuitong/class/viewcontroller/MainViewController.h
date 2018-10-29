//
//  mainViewController.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/22.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshTableController.h"
#import "PrjEntItem.h"
#import "PrjCaItem.h"
#import "PrjEntTableViewCell.h"
#import "PrjEntOperation.h"
#import "AsyncCenter.h"
#import "EntDetailController.h"
#import "PrjCaTableViewCell.h"
#import "PrjCaOperation.h"
#import "PrjBhbOperation.h"
#import "PrjBhbTableViewCell.h"
#import "BhbDetailController.h"
#import "CaDetailController.h"
#import "EntDetailController2.h"

@interface MainViewController : RefreshTableController

@property (nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)indexChanged:(UISegmentedControl *)sender;

+ (void) setTab:(int)tab;

@end
