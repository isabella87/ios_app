//
//  MyZhuanControllerViewController.h
//  banhuitong
//
//  Created by user on 16-1-8.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "RefreshTableController.h"
#import "PrjEntItem.h"
#import "MyZhuanOperation.h"
#import "AsyncCenter.h"
#import "MyZhuanTableViewCell.h"
#import "MyZhuanTableViewCell2.h"
#import "MyZhuanTableViewCell3.h"
#import "ApplyCaController.h"
#import "CaCancelOperation.h"
#import "BhbApplyCaController.h"

@interface MyZhuanController : RefreshTableController

@property(nonatomic)NSString *cancelPid;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)indexChanged:(UISegmentedControl *)sender;

+ (void) setTab:(int)tab;

@end
