//
//  MoreViewController.m
//  Navigation
//
//  Created by ym.sun on 16/12/15.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import "MoreViewController.h"
#import "DLPanableWebView.h"

@interface MoreViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet DLPanableWebView *moreWebView;

@end

@implementation MoreViewController

{
    __weak id<UIWebViewDelegate> originDelegate_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moreWebView = [[DLPanableWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    _moreWebView.delegate = self ;
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString: MORE_URL]];
    [self.view addSubview: self.moreWebView];
    [self.moreWebView loadRequest:request];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)webViewDidFinishLoad:(DLPanableWebView *)webView
{
    
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"] ;
    
    if([currentURL containsString: @"index.html"])
    {
        self.tabBarController.selectedIndex = 0 ;
        [self.moreWebView goBack];
    }
    
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (originDelegate_ && [originDelegate_ respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [originDelegate_ webViewDidFinishLoad:webView];
    }
}

@end
