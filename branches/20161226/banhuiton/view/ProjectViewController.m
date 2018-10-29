//
//  ProjectViewController.m
//  Navigation
//
//  Created by ym.sun on 16/12/15.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import "ProjectViewController.h"
#import "DLPanableWebView.h"

@interface ProjectViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet DLPanableWebView *projectWebView;

@end

@implementation ProjectViewController

{
    __weak id<UIWebViewDelegate> originDelegate_;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated] ;
    [self viewDidLoad] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.projectWebView = [[DLPanableWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    _projectWebView.delegate = self ;
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString: PROJECT_URL]];
    [self.view addSubview: self.projectWebView];
    [self.projectWebView loadRequest:request];
    
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
    }else if ([currentURL containsString:@"login.html"])
    {
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
