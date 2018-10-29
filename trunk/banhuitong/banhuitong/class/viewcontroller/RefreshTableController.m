//
//  RefreshTableController.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/22.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "RefreshTableController.h"

@interface RefreshTableController ()

@end

@implementation RefreshTableController

float startY = 0;
bool isTop = false;
bool isBottom = false;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tv.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    self.tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tv.dataSource = self;
    self.tv.delegate = self;
    self.tv.backgroundColor = [UIColor clearColor];
    
    self.currentPage = 1;
    
    __unsafe_unretained UITableView *tableView = self.tv;
    
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 结束刷新
//            [tableView.mj_header endRefreshing];
//        });
        [self refreshTableViewDataSource];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
//    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 结束刷新
//            [tableView.mj_footer endRefreshing];
//        });
//        [self loadMoreTableViewDataSource];
//    }];

}

- (void) dealloc{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

-(void)reloadDataAndResetHeaderFooter
{
    [self.tv reloadData];
}

#pragma mark Data Source Loading / Reloading Methods

- (void)refreshTableViewDataSource{
    
    if (isLoading == NO) {
        isLoading = YES;
        
        self.dataArray = [[NSMutableArray alloc]init];
        
        self.currentPage = 1;
        [self loadDataSource];
        
        [self performSelector:@selector(doneRefreshTableViewData) withObject:nil afterDelay:2];
    }
}

- (void)doneRefreshTableViewData{
    isLoading = NO;
    [self.tv.mj_header endRefreshing];
}

- (void)loadMoreTableViewDataSource{
    
    if (isLoading == NO) {
        isLoading = YES;
        self.currentPage++;
        [self loadDataSource];
        
        [self performSelector:@selector(doneLoadMoreTableViewData) withObject:nil afterDelay:0];
    }
}

- (void)doneLoadMoreTableViewData{
    isLoading = NO;
//     [self.tv.mj_footer endRefreshing];
}

#pragma mark - Scroll view delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    startY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"### End Decelerating ### startY = %f; contentOffset = %f", startY, scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
        NSLog(@"滑到底部");
        isBottom = true;
        if (isLoading==NO) {
            [self loadMoreTableViewDataSource];
        }
    }else{
        isBottom = false;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

@end
