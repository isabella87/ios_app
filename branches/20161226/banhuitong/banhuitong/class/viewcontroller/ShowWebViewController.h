//
//  ShowWebViewController.h
//  banhuitong
//
//  Created by 陈鲁 on 16/1/3.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginController.h"

@interface ShowWebViewController : BaseViewController <UIWebViewDelegate>

@property (nonatomic) NSString *myUrl;
@property (nonatomic) NSString *myTitle;
@property (nonatomic) BOOL noHeader;

@property (weak, nonatomic) IBOutlet UIWebView *wv;

@end
