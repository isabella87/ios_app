//
//  GuideController.m
//  banhuitong
//
//  Created by 陈鲁 on 16/1/23.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "GuideController.h"
#import "CustomTabBarViewController.h"
#import "Utils.h"


@interface GuideController ()
    
@end

@implementation GuideController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect bounds = self.view.frame;  //获取界面区域
    
    UIImageView* imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, bounds.origin.y, bounds.size.width, bounds.size.height)];
    [imageView1 setImage:[UIImage imageNamed:@"launch2.jpg"]];
    
    UIImageView* imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(bounds.size.width, bounds.origin.y , bounds.size.width, bounds.size.height)];
    [imageView2 setImage:[UIImage imageNamed:@"guide1.jpg"]];
    
    UIImageView* imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(bounds.size.width*2, bounds.origin.y, bounds.size.width, bounds.size.height)];
    [imageView3 setImage:[UIImage imageNamed:@"guide2.jpg"]];
    
    UIImageView* imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(bounds.size.width*3, bounds.origin.y, bounds.size.width, bounds.size.height)];
    [imageView4 setImage:[UIImage imageNamed:@"guide3.jpg"]];
    
     UIButton* btnEntry = [[UIButton alloc] initWithFrame:CGRectMake(bounds.size.width*3.5 - 50, bounds.size.height - 100, 100, 30)];
    [btnEntry setTitle: @"立即体验" forState: UIControlStateNormal];
    [btnEntry setBackgroundColor:[UIColor redColor]];
    btnEntry.layer.cornerRadius = 5;
    [btnEntry addTarget:self action:@selector(entry:) forControlEvents:UIControlEventTouchUpInside];
    
    //创建UIScrollView
    self.scrView = [[UIScrollView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height)];
    [self.scrView setContentSize:CGSizeMake(bounds.size.width * 4, bounds.size.height)];
    self.scrView.pagingEnabled = YES;
    self.scrView.bounces = NO;
    [self.scrView setDelegate:self];
    self.scrView.showsHorizontalScrollIndicator = NO;
    [self.scrView addSubview:imageView4];
    [self.scrView addSubview:imageView3];
    [self.scrView addSubview:imageView2];
    [self.scrView addSubview:imageView1];
    [self.scrView addSubview:btnEntry];
    [self.view addSubview:self.scrView];
    
    //创建UIPageControl
    self.pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, bounds.size.height - 50, bounds.size.width, 30)];
    self.pageCtrl.numberOfPages = 4;
    self.pageCtrl.currentPage = 0;
    self.pageCtrl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageCtrl.currentPageIndicatorTintColor = MYCOLOR_LIGHT_BLUE;
    [self.pageCtrl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageCtrl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) dealloc{
    self.scrView.delegate = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [self.pageCtrl setCurrentPage:offset.x / bounds.size.width];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

//然后是点击UIPageControl时的响应函数pageTurn
- (void)pageTurn:(UIPageControl*)sender
{
    NSLog(@"currentPage: %ld",(long)sender.currentPage);
    
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = self.pageCtrl.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.scrView scrollRectToVisible:rect animated:YES];
}

-(void)entry:(id)sender{
    [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:HAS_ACCESS];
    
    CustomTabBarViewController *controller = (CustomTabBarViewController *)[Utils getControllerFromStoryboard:@"customVC"];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
