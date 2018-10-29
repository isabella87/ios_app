//
//  EntDetailController2.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/29.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginController.h"
#import <WebKit/WebKit.h>

@interface EntDetailController2 : BaseViewController <WKNavigationDelegate, WKUIDelegate>

@property(nonatomic) WKWebView *wvDetail;
@property(nonatomic) int pId;
@property(nonatomic) NSString *myHash;

@end
