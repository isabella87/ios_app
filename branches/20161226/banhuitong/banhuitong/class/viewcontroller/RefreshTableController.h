//
//  RefreshTableController.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/22.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Constants.h"
#import "MJRefresh.h"

@interface RefreshTableController : BaseViewController <UITableViewDelegate,UITableViewDataSource>
{
    BOOL isLoading;
}

@property (strong, nonatomic) IBOutlet UITableView *tv;

@property(nonatomic) int currentPage;

#pragma mark -Overide Load

-(void)loadDataSource;

#pragma mark -Refresh

- (void)refreshTableViewDataSource;
- (void)doneRefreshTableViewData;

#pragma mark -LoadMore

- (void)loadMoreTableViewDataSource;
- (void)doneLoadMoreTableViewData;

#pragma mark -Reload Data

-(void)reloadDataAndResetHeaderFooter;

@end
