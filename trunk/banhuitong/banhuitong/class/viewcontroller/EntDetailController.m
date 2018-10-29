//
//  EntDetailController.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/29.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "EntDetailController.h"

@interface EntDetailController ()

@property WebViewJavascriptBridge* bridge;

@end

@implementation EntDetailController

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
    
    NSString *address = [NSString stringWithFormat:@"%@app/project-view.html?id=%d&hash=%@&random=%d", MOBILE_ADDRESS, self.pId, self.myHash, x];
    
    NSLog(@"===================================================", nil);
    NSLog(@"ResquestUrl = %@", address);
    NSLog(@"===================================================", nil);
    
    NSURL *url =[[NSURL alloc] initWithString:address];
    NSMutableURLRequest  *request =  [[NSMutableURLRequest  alloc] initWithURL:url];
    
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
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        
    }else if ([currentURL containsString:@"accountment.html"] || [currentURL containsString:@"project-list.html"]) {
        
        NSRange range = [currentURL rangeOfString:@"?"];
        if (range.length>0) {
            currentURL = [currentURL substringWithRange:NSMakeRange(0, range.location)];
        }
        
        if ([currentURL containsString:@"accountment.html"] || [currentURL containsString:@"project-list.html"]){
            _bridge = nil;
            self.wvDetail.delegate = nil;
            [self dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_BACK_MYACCOUNT object:nil userInfo:nil];
            }];
        }
    }else if ([currentURL containsString:@"to-recharge.html"]){
        _bridge = nil;
        self.wvDetail.delegate = nil;
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TO_RECHARGE object:nil userInfo:nil];
        }];
    }else if ([currentURL containsString:@"to-jx.html"]){
        _bridge = nil;
        self.wvDetail.delegate = nil;
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TO_JX object:nil userInfo:nil];
        }];
    }
}

-(void)dismissSelf:(NSNotification*)notify
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
