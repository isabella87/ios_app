//
//  ShowWebViewController.m
//  banhuitong
//
//  Created by 陈鲁 on 16/1/3.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "ShowWebViewController.h"

@interface ShowWebViewController ()

@property WebViewJavascriptBridge* bridge;

@end

@implementation ShowWebViewController

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
    
    self.wv.delegate = self;
    self.wv.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.wv.scalesPageToFit=YES;
    self.wv.multipleTouchEnabled=YES;
    self.wv.userInteractionEnabled=YES;
    
    [self startActivityIndicator];
    
    NSLog(@"===================================================", nil);
    NSLog(@"ResquestUrl = %@", self.myUrl);
    NSLog(@"===================================================", nil);
    
    NSURL *url =[[NSURL alloc] initWithString:self.myUrl];
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
    [self.wv loadRequest:request];
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.wv webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        
        if ([data containsString:@"充值失败"]) {
            _bridge = nil;
            self.wv.delegate = nil;
            [self dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_BACK_MYACCOUNT object:nil userInfo:nil];
            }];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void) dealloc{
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self stopActivityIndicator];
    
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    
    if ([currentURL containsString:@"back.html"]){
        self.wv.delegate = nil;
       [self dismissViewControllerAnimated:YES completion:nil];
        
    }else if ([currentURL containsString:@"account/recharge-cb.html"] || [currentURL containsString:@"account/recharge.html"] || [currentURL containsString:@"accountment.html"] || [currentURL containsString:@"jxpay-info.html"]) {
        
        NSRange range = [currentURL rangeOfString:@"?"];
        if (range.length>0) {
            currentURL = [currentURL substringWithRange:NSMakeRange(0, range.location)];
        }
        
        if ([currentURL containsString:@"account/recharge-cb.html"] || [currentURL containsString:@"account/recharge.html"] || [currentURL containsString:@"accountment.html"] || [currentURL containsString:@"jxpay-info.html"]){
            [self dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_BACK_MYACCOUNT object:nil userInfo:nil];
            }];
        }
    }else if ([currentURL containsString:@"login.html"]) {
        LoginController *controller = (LoginController *)[Utils getControllerFromStoryboard:@"LoginVC"];
        [self presentViewController:controller animated:NO completion:nil];
    }else if ([currentURL containsString:@"to-jx.html"]){
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TO_JX object:nil userInfo:nil];
        }];
    }
}

- (void) onBackAction {
    if (self.wv.canGoBack){
        [self.wv goBack];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_BACK_MYACCOUNT object:nil userInfo:nil];
        }];
    }
}

@end
