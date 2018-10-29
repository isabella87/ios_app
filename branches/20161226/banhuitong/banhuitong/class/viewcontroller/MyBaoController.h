//
//  MyBaoController.h
//  banhuitong
//
//  Created by user on 16-1-7.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "RefreshTableController.h"
#import "PrjEntItem.h"
#import "MyBaoOperation.h"
#import "AsyncCenter.h"
#import "MyBaoTableViewCell.h"
#import "MyBaoTableViewCell2.h"
#import "MyBaoTableViewCell3.h"

@interface MyBaoController : RefreshTableController

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)indexChanged:(UISegmentedControl *)sender;

+ (void) setTab:(int)tab;

@end
