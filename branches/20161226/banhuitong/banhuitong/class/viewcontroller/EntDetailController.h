//
//  EntDetailController.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/29.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginController.h"

@interface EntDetailController : BaseViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *wvDetail;
@property(nonatomic) int pId;
@property(nonatomic) NSString *myHash;

@end
