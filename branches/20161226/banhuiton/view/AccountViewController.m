//
//  AccountViewController.m
//  Navigation
//
//  Created by ym.sun on 16/12/14.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import "AccountViewController.h"

#import "DLPanableWebView.h"

@interface AccountViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet DLPanableWebView *accountWebView;

@end

@implementation AccountViewController

{
    __weak id<UIWebViewDelegate> originDelegate_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.accountWebView = [[DLPanableWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    _accountWebView.delegate = self ;
    
    [self restoreCookieIfNeeded] ;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",ACCOUNT_URL]]];
    
    //iPhone浏览网页时自适应大小
    //_accountWebView.scalesPageToFit =YES ;
    [self.view addSubview: self.accountWebView];
    [self.accountWebView loadRequest:request];
    
}

- (void)saveSessionIDCookie
{
    NSArray *nCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSHTTPCookie *cookie = nil;
    for (id cObj in nCookies) {
        if ([cObj isKindOfClass:[NSHTTPCookie class]]){
            cookie = (NSHTTPCookie *)cObj;
            if (!!cookie && [cookie.name isEqualToString: @"PHPSESSID"]) {
                NSString *savePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                NSString *saveFile = [savePath stringByAppendingPathComponent:@"PHPSESSID"];
                [NSKeyedArchiver archiveRootObject:cookie toFile:saveFile];
            }
            NSLog(@"cookie properties: %@", cookie.properties);
        }
    }
}

- (void)restoreCookieIfNeeded {
    NSString *savePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *saveFile = [savePath stringByAppendingPathComponent:@"PHPSESSID"];
    NSHTTPCookie *sessionIDCookie = [NSKeyedUnarchiver unarchiveObjectWithFile:saveFile];
    if (!!sessionIDCookie) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:sessionIDCookie];
    }
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
    
    [self saveSessionIDCookie];
}

@end
