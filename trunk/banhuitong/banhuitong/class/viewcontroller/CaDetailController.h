//
//  CaDetailController.h
//  banhuitong
//
//  Created by user on 15-12-31.
//  Copyright (c) 2015年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginController.h"

@interface CaDetailController : BaseViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *wvDetail;
@property(nonatomic) int pId;
@property(nonatomic) NSString *myHash;

@end
