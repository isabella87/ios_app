//
//  ShowWKWebViewController.h
//  banhuitong
//
//  Created by 陈鲁 on 16/4/9.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginController.h"
#import <WebKit/WebKit.h>

@interface ShowWKWebViewController : BaseViewController <WKNavigationDelegate, WKUIDelegate>

@property(nonatomic) WKWebView *wv;
@property (nonatomic) NSString *myUrl;
@property (nonatomic) NSString *myTitle;
@property (nonatomic) BOOL noHeader;

@end
