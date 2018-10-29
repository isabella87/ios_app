//
//  MyGongController.h
//  banhuitong
//
//  Created by user on 16-1-7.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "RefreshTableController.h"
#import "PrjEntItem.h"
#import "MyGongOperation.h"
#import "AsyncCenter.h"
#import "MyGongTableViewCell.h"

@interface MyGongController : RefreshTableController

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)indexChanged:(UISegmentedControl *)sender;

+ (void) setTab:(int)tab;

@end
