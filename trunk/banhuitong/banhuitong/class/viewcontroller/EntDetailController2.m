//
//  EntDetailController2.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/29.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "EntDetailController2.h"

@interface EntDetailController2 ()

@end

@implementation EntDetailController2

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.hasFooter==YES) {
        [self showFooter];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissSelf:) name:NOTIFY_BACK_INDEX_FROM_DETAIL object:nil];
    
    WKUserContentController* userContentController = WKUserContentController.new;
//    NSString *cookies = [NSString stringWithFormat:@"document.cookie='%@';domain=%@", [Utils readCurrentCookie], SERVER_DOMAIN];
//    WKUserScript * cookieScript = [[WKUserScript alloc]
//                                   initWithSource:cookies
//                                   injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
//    [userContentController addUserScript:cookieScript];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc]init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
//     默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    config.userContentController = userContentController;
    
    self.wvDetail = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-80) configuration:config];
    [self.view addSubview:self.wvDetail];
    self.wvDetail.allowsBackForwardNavigationGestures =YES;
    [self.wvDetail setNavigationDelegate:self];
    [self.wvDetail setUIDelegate:self];
    
    int x = arc4random();
    NSString *address = [NSString stringWithFormat:@"%@%@%d%@%@%@%d", MOBILE_ADDRESS, @"app/project-view.html?id=", self.pId, @"&hash=", self.myHash, @"&random=", x];
    
    NSURL *url =[[NSURL alloc] initWithString:address];
    NSMutableURLRequest  *request =  [[NSMutableURLRequest  alloc] initWithURL:url];
    NSString *cookie = [Utils readCurrentCookie];
    [request addValue:cookie forHTTPHeaderField:@"Cookie"];
    [self.wvDetail loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void) dealloc{
    self.wvDetail = nil;
    self.myHash = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_BACK_INDEX_FROM_DETAIL object:nil];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation { // 类似UIWebView的 -webViewDidStartLoad:
    NSLog(@"didStartProvisionalNavigation");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    NSString *currentURL = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([currentURL containsString:@"login.html"]) {
        
        LoginController *controller = (LoginController *)[Utils getControllerFromStoryboard:@"LoginVC"];
        [self presentViewController:controller animated:NO completion:nil];
        
    }else if ([currentURL containsString:@"back.html"]){
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        
    }else if ([currentURL containsString:@"accountment.html"]) {
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_BACK_MYACCOUNT object:nil userInfo:nil];
        }];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)dismissSelf:(NSNotification*)notify
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
