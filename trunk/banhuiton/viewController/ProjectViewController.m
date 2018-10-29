//
//  ProjectViewController.m
//  Navigation
//
//  Created by ym.sun on 16/12/15.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import "ProjectViewController.h"

//添加MJRefresh刷新组件：下拉刷新默认字体为系统字体
#import "MJRefresh.h"

@interface ProjectViewController ()<UIWebViewDelegate>


@end

@implementation ProjectViewController

{
    __weak id<UIWebViewDelegate> originDelegate_;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated] ;
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 20)] ;
    topLabel.backgroundColor = [UIColor whiteColor] ;
    self.projectWebView = [[DLPanableWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    _projectWebView.delegate = self ;
    
    self.projectWebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{[self.projectWebView reload] ;}] ;
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString: PROJECT_URL]];
    [self.view addSubview: topLabel] ;
    [self.view addSubview: self.projectWebView];
    [self.projectWebView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(DLPanableWebView *)webView
{
    
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"] ;
    
    if([currentURL containsString: @"index.html"])
    {
        self.tabBarController.selectedIndex = 0 ;
        [self.projectWebView goBack] ;
    }else if ([currentURL containsString:@"login.html"]){
        self.tabBarController.selectedIndex = 2 ;
        //如果这里也采用webView的goBack函数，可能会造成死机
        //[self.projectWebView goBack] ;
        
    }
    
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (originDelegate_ && [originDelegate_ respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [originDelegate_ webViewDidFinishLoad:webView];
    }
}

@end
