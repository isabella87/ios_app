//
//  MoreViewController.m
//  Navigation
//
//  Created by ym.sun on 16/12/15.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import "MoreViewController.h"
#import "DLPanableWebView.h"

#import "MyLogin.h"
#import <JavaScriptCore/JavaScriptCore.h>

//添加MJRefresh刷新组件：下拉刷新默认字体为系统字体
#import "MJRefresh.h"

#import "MBProgressHUD.h"

@interface MoreViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet DLPanableWebView *moreWebView;

//定义jsContext，获取上下文
@property(strong, nonatomic) JSContext *jsContext ;

@end

@implementation MoreViewController

{
    __weak id<UIWebViewDelegate> originDelegate_;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 20)] ;
    topLabel.backgroundColor = [UIColor whiteColor] ;
    
    self.moreWebView = [[DLPanableWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    _moreWebView.delegate = self ;

     self.moreWebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{[self.moreWebView reload] ;}] ;
    //webView检测电话号(NO：禁止）
    //self.moreWebView.detectsPhoneNumbers = NO ;
    //webView检测电话号、URL、地址、日期（UIDataDetectorTypeNone都不检测）
    self.moreWebView.dataDetectorTypes = UIDataDetectorTypeNone ;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString: MORE_URL]];
    [self.view addSubview: topLabel] ;
    [self.view addSubview: self.moreWebView];
    [self.moreWebView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 监听可以注入js 方法的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCreateJSContext:) name:@"DidCreateContextNotification" object:nil];
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

#pragma mark - 可以注入js 的监听
- (void)didCreateJSContext:(NSNotification *)notification
{
    
    NSString *indentifier = [NSString stringWithFormat:@"indentifier%lud", (unsigned long)self.moreWebView.hash];
    NSString *indentifierJS = [NSString stringWithFormat:@"var %@ = '%@'", indentifier, indentifier];
    [self.moreWebView stringByEvaluatingJavaScriptFromString:indentifierJS];
    
    JSContext *context = notification.object;
    
    if (![context[indentifier].toString isEqualToString:indentifier]) return;
    
    self.jsContext = context;
    // 通过模型调用方法，这种方式更好些。
    MyLogin *myLogin = [[MyLogin alloc] init] ;
    myLogin.vc = self ;
    //将myLogin对象指向自身
    self.jsContext[@"myLogin"] = myLogin;
    myLogin.jsContext = self.jsContext ;
    NSLog(@"关于：%@", myLogin.getVersionName) ;
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}

@end

//建立一个分类
@implementation NSObject (JSInject)

- (void)webView:(id)unuse didCreateJavaScriptContext:(JSContext *)ctx forFrame:(id)frame {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidCreateContextNotification" object:ctx];
}

@end
