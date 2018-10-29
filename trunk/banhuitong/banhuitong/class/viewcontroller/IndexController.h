//
//  IndexController.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/29.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomTabBarViewController.h"
#import "MainViewController.h"
#import "ShowWKWebViewController.h"
#import "baseUtils.h"

@interface IndexController : BaseViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *srvMain;

@property (strong, nonatomic) IBOutlet UIView *layerGong;
@property (strong, nonatomic) IBOutlet UIView *layerZhuan;
@property (strong, nonatomic) IBOutlet UIView *layerBorrow;
@property (strong, nonatomic) IBOutlet UIView *layerShare;
@property (strong, nonatomic) IBOutlet UIView *layerActivity;
@property (strong, nonatomic) IBOutlet UIView *layerRepayNotice;

@property UIScrollView* scrView;
@property UIPageControl* pageCtrl;
@property UIImageView *banner1, *banner2, *banner3;

@property NSTimer *bannerTimer;
@property int bannerWidth, bannerHeight;
@property int bannerCount;

@end
