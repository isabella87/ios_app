//
//  AccountViewController.m
//  Navigation
//
//  Created by ym.sun on 16/12/14.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import "AccountViewController.h"
#import "DLPanableWebView.h"

//添加MJRefresh刷新组件：下拉刷新默认字体为系统字体
#import "MJRefresh.h"
//与js交互需要的头文件
#import "MyLogin.h"
#import <JavaScriptCore/JavaScriptCore.h>


@interface AccountViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet DLPanableWebView *accountWebView;
//定义jsContext，获取上下文
@property (strong ,nonatomic) JSContext *jsContext ;

@property (strong ,nonatomic) NSURLRequest *request ;

@end

@implementation AccountViewController

{
    __weak id<UIWebViewDelegate> originDelegate_;
}

@synthesize request ;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 20)] ;
    topLabel.backgroundColor = [UIColor whiteColor] ;
    
    self.accountWebView = [[DLPanableWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //引入代理
    _accountWebView.delegate = self ;
    //下拉刷新
    self.accountWebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{[self.accountWebView reload] ;}] ;
    //webView检测电话号(NO：禁止）
    //self.accountWebView.detectsPhoneNumbers = NO ;
    //webView检测电话号、URL、地址、日期（UIDataDetectorTypeNone都不检测）
    self.accountWebView.dataDetectorTypes = UIDataDetectorTypeNone ;
    //判断手机端是否登录过，如果登录过则直接进入账户中心，否则进入登录页面
    if ([AppDelegate isLogin]) {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",ACCOUNT_URL]]];
    } else {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",LOGIN_URL]]];
    }
    [self.view addSubview: topLabel] ;
    [self.view addSubview: self.accountWebView];
    [self.accountWebView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    首次打开app登录，再次打开app若已经登录则不需要在进行登录操作，否则要登录
//    if([AppDelegate isLogin]) {
//        NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_USERNAME];
//        NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_PASSWORD];
//        
//        BaseOperation *op = [[LoginOperation alloc] initWithUsername:userName andWithPassword:password andWithDelegate:self];
//        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
//    }else{
//        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    }
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
        [self.accountWebView goBack] ;
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
    } ;
}

@end
