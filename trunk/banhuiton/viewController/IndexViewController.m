//
//  IndexViewController.m
//  Navigation
//
//  Created by ym.sun on 16/12/15.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import "IndexViewController.h"
#import "DLPanableWebView.h"
#import "ProjectViewController.h"

#import "MyLogin.h"
#import <JavaScriptCore/JavaScriptCore.h>

//添加MJRefresh刷新组件：下拉刷新默认字体为系统字体
#import "MJRefresh.h"

@interface IndexViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet DLPanableWebView *indexWebView;

//定义jsContext，获取上下文
@property(strong, nonatomic) JSContext *jsContext ;

@end

@implementation IndexViewController

{
    __weak id<UIWebViewDelegate> originDelegate_;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 20)] ;
    topLabel.backgroundColor = [UIColor whiteColor] ;
    self.indexWebView = [[DLPanableWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    _indexWebView.delegate = self ;

    self.indexWebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{[self.indexWebView reload] ;}] ;
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString: INDEX_URL]] ;
    [self.view addSubview: topLabel] ;
    [self.view addSubview: self.indexWebView] ;
    [self.indexWebView loadRequest:request] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)webViewDidFinishLoad:(DLPanableWebView *)webView
{
    
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"] ;
    
    if([currentURL containsString: @"/m/project/"])
    {
        self.tabBarController.selectedIndex = 1 ;
        [self.indexWebView goBack];
    }else if ([currentURL containsString: @"/m/creditassign/"]){
        self.tabBarController.selectedIndex = 1 ;
        
        ProjectViewController *projectViewController = self.tabBarController.selectedViewController ;
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString: CREDIT_URL]];
        [self.tabBarController.selectedViewController.view addSubview: projectViewController.projectWebView];
        [projectViewController.projectWebView loadRequest:request];
        
        [self.indexWebView goBack];
    }else if ([currentURL containsString: @"login.html"])
    {
        self.tabBarController.selectedIndex = 2 ;
        [self.indexWebView goBack] ;
    }
    
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //创建myLogin对象
    MyLogin *myLogin = [[MyLogin alloc] init] ;
    myLogin.vc = self ;
    //将myLogin对象指向自身
    self.jsContext[@"myLogin"] = myLogin;
    myLogin.jsContext = self.jsContext ;
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };

    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (originDelegate_ && [originDelegate_ respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [originDelegate_ webViewDidFinishLoad:webView];
    }
}

@end
