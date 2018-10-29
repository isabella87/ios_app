//
//  BhbDetailController.m
//  banhuitong
//
//  Created by user on 15-12-31.
//  Copyright (c) 2015年 banhuitong. All rights reserved.
//

#import "BhbDetailController.h"

@interface BhbDetailController ()

@property WebViewJavascriptBridge* bridge;

@end

@implementation BhbDetailController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.hasFooter==YES) {
        [self showFooter];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startActivityIndicator];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissSelf:) name:NOTIFY_BACK_INDEX_FROM_DETAIL object:nil];

    self.wvDetail.delegate = self;
    
    int x = arc4random();
    
    NSString *address = [NSString stringWithFormat:@"%@app/bhb-view.html?id=%d&hash=%@&random=%d", MOBILE_ADDRESS, self.pId, self.myHash, x];
    
    NSURL *url =[[NSURL alloc] initWithString:address];
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
    [self.wvDetail loadRequest:request];
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.wvDetail webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        [self.wvDetail goBack];
        
        if ([data containsString:@"余额不足"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:MSG_BALANCE_NOT_ENOUGH delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:data delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alert show];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void) dealloc{
    self.wvDetail.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_BACK_INDEX_FROM_DETAIL object:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self stopActivityIndicator];
    
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    
    if ([currentURL containsString:@"login.html"]) {
        
        LoginController *controller = (LoginController *)[Utils getControllerFromStoryboard:@"LoginVC"];
        [self presentViewController:controller animated:NO completion:nil];
        
    }else if ([currentURL containsString:@"back.html"]){
        _bridge = nil;
        self.wvDetail.delegate = nil;
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else if ([currentURL containsString:@"accountment.html"]) {
        _bridge = nil;
        self.wvDetail.delegate = nil;
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_BACK_MYACCOUNT object:nil userInfo:nil];
        }];
    }
}

-(void)dismissSelf:(NSNotification*)notify
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
