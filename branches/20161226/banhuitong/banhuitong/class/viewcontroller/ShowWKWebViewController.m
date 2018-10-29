//
//  ShowWKWebViewController.m
//  banhuitong
//
//  Created by 陈鲁 on 16/4/9.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "ShowWKWebViewController.h"

@interface ShowWKWebViewController ()

@end

@implementation ShowWKWebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.noHeader!=YES) {
        [self showHeader2:self.myTitle];
    }
    
    if (self.hasFooter==YES) {
        [self showFooter];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.noHeader!=YES) {
        self.wv = [[WKWebView alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT-70)];
    }else{
        self.wv = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    
    [self.view addSubview:self.wv];
    self.wv.allowsBackForwardNavigationGestures =YES;
    [self.wv setNavigationDelegate:self];
    [self.wv setUIDelegate:self];
    
    [self startActivityIndicator];
    
    NSURL *url =[[NSURL alloc] initWithString:self.myUrl];
    NSMutableURLRequest  *request =  [[NSMutableURLRequest  alloc] initWithURL:url];
    [self.wv loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void) dealloc{
    self.wv = nil;
    self.myUrl = nil;
    self.myTitle = nil;
    self.noHeader = nil;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation { // 类似UIWebView的 -webViewDidStartLoad:
    NSLog(@"didStartProvisionalNavigation");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
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

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self stopActivityIndicator];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [self stopActivityIndicator];
}

- (void) onBackAction {
    if (self.wv.canGoBack){
        [self.wv goBack];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

@end
