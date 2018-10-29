//
//  IndexViewController.m
//  Navigation
//
//  Created by ym.sun on 16/12/15.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import "IndexViewController.h"
#import "DLPanableWebView.h"

@interface IndexViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet DLPanableWebView *indexWebView;

@end

@implementation IndexViewController

{
    __weak id<UIWebViewDelegate> originDelegate_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indexWebView = [[DLPanableWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    _indexWebView.delegate = self ;
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString: INDEX_URL]];
    [self.view addSubview: self.indexWebView];
    [self.indexWebView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)webViewDidFinishLoad:(DLPanableWebView *)webView
{
    
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"] ;
    
    if([currentURL containsString: @"/m/project/"]|| [currentURL containsString: @"/m/creditassign/"])
    {
        self.tabBarController.selectedIndex = 1 ;
        [self.indexWebView goBack];
    }else if ([currentURL containsString: @"login.html"])
    {
        self.tabBarController.selectedIndex = 2 ;
        [self.indexWebView goBack] ;
    }
    
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (originDelegate_ && [originDelegate_ respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [originDelegate_ webViewDidFinishLoad:webView];
    }
}

@end
