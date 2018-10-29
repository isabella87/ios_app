//
//  IndexController.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/29.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "IndexController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocial.h"
#import "GetStreamOperation.h"
#import "GetCryptMobileOperation.h"

@implementation IndexController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showHeader1];
    [AppDelegate setShareHiden:NO];
    [self getBanners];
    
    if ([AppDelegate isLogin] ) {
        BaseOperation *op = [[GetCryptMobileOperation alloc] initWithDelegate:self];
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    }
    
    //    sayhello();
}

- (void)viewDidLoad{
    self.tabBarController.tabBarItem.tag = 0;
    
    self.bannerCount = 4;
    
    self.bannerWidth = SCREEN_WIDTH;
    
    if (SCREEN_HEIGHT<IPHONE_6_HEIGHT) {
        self.bannerHeight = 220;
    }else{
        self.bannerHeight = 300;
    }
    
    self.layerGong.tag = 1;
    self.layerZhuan.tag =3;
    self.layerBorrow.tag = 4;
    self.layerShare.tag = 5;
    self.layerActivity.tag = 6;
    self.layerRepayNotice.tag = 7;
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap2.delegate = self;
    singleTap2.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap3.delegate = self;
    singleTap3.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap4.delegate = self;
    singleTap4.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap5.delegate = self;
    singleTap5.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap6.delegate = self;
    singleTap6.cancelsTouchesInView = NO;
    
    [self.layerGong addGestureRecognizer:singleTap];
    [self.layerZhuan addGestureRecognizer:singleTap2];
    [self.layerBorrow addGestureRecognizer:singleTap3];
    [self.layerShare addGestureRecognizer:singleTap4];
    [self.layerActivity addGestureRecognizer:singleTap5];
    [self.layerRepayNotice addGestureRecognizer:singleTap6];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
    CGRect bounds = CGRectMake(0, 70, SCREEN_WIDTH,  self.bannerHeight);  //获取界面区域
    
    //创建UIScrollView
    self.scrView = [[UIScrollView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height)];
    [self.scrView setContentSize:CGSizeMake(bounds.size.width * self.bannerCount, bounds.size.height)];
    self.scrView.pagingEnabled = YES;
    self.scrView.bounces = NO;
    [self.scrView setDelegate:self];
    self.scrView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrView];
    
    //创建UIPageControl
    self.pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, bounds.size.height, bounds.size.width, 120)];
    self.pageCtrl.numberOfPages = self.bannerCount;
    self.pageCtrl.currentPage = 0;
    self.pageCtrl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageCtrl.currentPageIndicatorTintColor = MYCOLOR_LIGHT_BLUE;
    [self.pageCtrl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageCtrl];
    
    [self.srvMain setContentSize:CGSizeMake(SCREEN_WIDTH, 280)];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.scrView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.srvMain
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
    
    [self performSelector:@selector(scrollBanners) withObject:nil afterDelay:0.0f];
    [super viewDidLoad];
}

- (void) dealloc{
    
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    UIView *singleTapView = [sender view];
    int tag = singleTapView.tag;
    if (tag==1) {
        
        if(![AppDelegate isLogin]) {
            self.tabBarController.selectedIndex = 0;
            LoginController *controller = (LoginController *)[Utils getControllerFromStoryboard:@"LoginVC"];
            [self presentViewController:controller animated:NO completion:nil];
            
            return;
        }
        
        MainViewController *controller = (MainViewController *)self.tabBarController.viewControllers[1];
        [MainViewController setTab:tag];
        controller.didLoad = NO;
        
        self.tabBarController.selectedIndex = 1;
        
    }else if (tag==2) {
        
        MainViewController *controller = (MainViewController *)self.tabBarController.viewControllers[1];
        [MainViewController setTab:tag];
        controller.didLoad = NO;
        
        self.tabBarController.selectedIndex = 1;
        
    }else if (tag==3) {
        
        if(![AppDelegate isLogin]) {
            self.tabBarController.selectedIndex = 0;
            LoginController *controller = (LoginController *)[Utils getControllerFromStoryboard:@"LoginVC"];
            [self presentViewController:controller animated:NO completion:nil];
            
            return;
        }
        
        MainViewController *controller = (MainViewController *)self.tabBarController.viewControllers[1];
        [MainViewController setTab:tag];
        controller.didLoad = NO;
        
        self.tabBarController.selectedIndex = 1;
        
    }else if (tag==4) {
        
        if ([Utils getIOSVersion]>=8.0) {
            ShowWKWebViewController *controller = (ShowWKWebViewController *)[Utils getControllerFromStoryboard:@"WKWebViewVC"];
            controller.myTitle = @"我要借款";
            controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"app/wyjk.html"];
            [self presentViewController:controller animated:YES completion:nil];
        }else{
            ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebViewVC"];
            controller.myTitle = @"我要借款";
            controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"app/wyjk.html"];
            [self presentViewController:controller animated:YES completion:nil];
        }
        
    }else if (tag==5) {
        
        [self makeShare];
        
    }else if (tag==6) {
        
        if ([Utils getIOSVersion]>=8.0) {
            ShowWKWebViewController *controller = (ShowWKWebViewController *)[Utils getControllerFromStoryboard:@"WKWebViewVC"];
            controller.myTitle = @"平台动态";
            controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"app/info-list.html?type=4&p=1"];
            [self presentViewController:controller animated:YES completion:nil];
        }else{
            ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebViewVC"];
            controller.myTitle = @"平台动态";
            controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"app/info-list.html?type=4&p=1"];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }else if (tag==7) {
        
        if ([Utils getIOSVersion]>=8.0) {
            ShowWKWebViewController *controller = (ShowWKWebViewController *)[Utils getControllerFromStoryboard:@"WKWebViewVC"];
            controller.myTitle = @"还款公告";
            controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"app/info-list.html?type=1&p=1"];
            [self presentViewController:controller animated:YES completion:nil];
        }else{
            ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebViewVC"];
            controller.myTitle = @"还款公告";
            controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"app/info-list.html?type=1&p=1"];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }else if (tag==8) {
        if ([Utils getIOSVersion]>=8.0) {
            ShowWKWebViewController *controller = (ShowWKWebViewController *)[Utils getControllerFromStoryboard:@"WKWebViewVC"];
            controller.noHeader = YES;
            controller.hasFooter = YES;
            controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"app/banner.html?pn=1"];
            [self presentViewController:controller animated:YES completion:nil];
        }else{
            ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebViewVC2"];
            controller.noHeader = YES;
            controller.hasFooter = YES;
            controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"app/banner.html?pn=1"];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }else if (tag==9) {
        if ([Utils getIOSVersion]>=8.0) {
            ShowWKWebViewController *controller = (ShowWKWebViewController *)[Utils getControllerFromStoryboard:@"WKWebViewVC"];
            controller.noHeader = YES;
            controller.hasFooter = YES;
            controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"app/banner.html?pn=2"];
            [self presentViewController:controller animated:YES completion:nil];
        }else{
            ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebViewVC2"];
            controller.noHeader = YES;
            controller.hasFooter = YES;
            controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"app/banner.html?pn=2"];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }else if (tag==10) {
        if ([Utils getIOSVersion]>=8.0) {
            ShowWKWebViewController *controller = (ShowWKWebViewController *)[Utils getControllerFromStoryboard:@"WKWebViewVC"];
            controller.noHeader = YES;
            controller.hasFooter = YES;
            controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"app/banner.html?pn=3"];
            [self presentViewController:controller animated:YES completion:nil];
        }else{
            ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebViewVC2"];
            controller.noHeader = YES;
            controller.hasFooter = YES;
            controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"app/banner.html?pn=3"];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }else if (tag==11) {
        if ([Utils getIOSVersion]>=8.0) {
            ShowWKWebViewController *controller = (ShowWKWebViewController *)[Utils getControllerFromStoryboard:@"WKWebViewVC"];
            controller.noHeader = YES;
            controller.hasFooter = YES;
            controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"app/banner.html?pn=4"];
            [self presentViewController:controller animated:YES completion:nil];
        }else{
            ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebViewVC2"];
            controller.noHeader = YES;
            controller.hasFooter = YES;
            controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"app/banner.html?pn=4"];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }
}

- (void)swipe:(UISwipeGestureRecognizer *)gesture {
    
    NSInteger currentIndex = self.tabBarController.selectedIndex;
    
    CATransition *transaction = [CATransition animation];
    transaction.type = kCATransitionPush;
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        if(![AppDelegate isLogin]) {
            self.tabBarController.selectedIndex = 0;
            LoginController *controller = (LoginController *)[Utils getControllerFromStoryboard:@"LoginVC"];
            [self presentViewController:controller animated:NO completion:nil];
            
            return;
        }
        
        [transaction setSubtype:kCATransitionFromRight];
        self.tabBarController.selectedIndex = currentIndex + 1;
        
    } else {
        return;
    }
    
    transaction.duration = 0.5;
    transaction.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [[self.tabBarController.view layer] addAnimation:transaction forKey:@"switchView"];
}

-(void) getBanners{
    NSString *url = [NSString stringWithFormat:@"%@web/themes/default/images/banner/ban_banner1.jpg", MOBILE_ADDRESS];
    BaseOperation *op = [[GetStreamOperation alloc] initWithDelegate:self andWithUrl:url andWithCallbackCode:GET_BANNER1_SUCCESS];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    
    NSString *url2 = [NSString stringWithFormat:@"%@web/themes/default/images/banner/ban_banner2.jpg", MOBILE_ADDRESS];
    BaseOperation *op2 = [[GetStreamOperation alloc] initWithDelegate:self andWithUrl:url2 andWithCallbackCode:GET_BANNER2_SUCCESS];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op2];
    
    NSString *url3 = [NSString stringWithFormat:@"%@web/themes/default/images/banner/ban_banner3.jpg", MOBILE_ADDRESS];
    BaseOperation *op3 = [[GetStreamOperation alloc] initWithDelegate:self andWithUrl:url3 andWithCallbackCode:GET_BANNER3_SUCCESS];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op3];
    
    NSString *url4 = [NSString stringWithFormat:@"%@web/themes/default/images/banner/ban_banner4.jpg", MOBILE_ADDRESS];
    BaseOperation *op4 = [[GetStreamOperation alloc] initWithDelegate:self andWithUrl:url4 andWithCallbackCode:GET_BANNER4_SUCCESS];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op4];
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code==GET_BANNER1_SUCCESS) {
        UIImage *img = [UIImage imageWithData: (NSData *)data];
        
        CGRect bounds = CGRectMake(0, 0, SCREEN_WIDTH,  self.bannerHeight);  //获取界面区域
        UIImageView* imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, bounds.origin.y, bounds.size.width, bounds.size.height)];
        imageView1.contentMode = UIViewContentModeScaleToFill;
        imageView1.image = [Utils scaleImage:img toScale:1];
        imageView1.tag = 8;
        imageView1.userInteractionEnabled = YES;
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delegate = self;
        singleTap.cancelsTouchesInView = NO;
        [imageView1 addGestureRecognizer:singleTap];
        
        [self.scrView addSubview:imageView1];
    }else if (code==GET_BANNER2_SUCCESS) {
        UIImage *img = [UIImage imageWithData: (NSData *)data];
        
        CGRect bounds = CGRectMake(0, 0, SCREEN_WIDTH,  self.bannerHeight);  //获取界面区域
        UIImageView* imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(bounds.size.width, bounds.origin.y, bounds.size.width, bounds.size.height)];
        imageView2.contentMode = UIViewContentModeScaleToFill;
        imageView2.image = [Utils scaleImage:img toScale:1];
        imageView2.tag = 9;
        imageView2.userInteractionEnabled = YES;
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delegate = self;
        singleTap.cancelsTouchesInView = NO;
        [imageView2 addGestureRecognizer:singleTap];
        
        [self.scrView addSubview:imageView2];
        
    }else if (code==GET_BANNER3_SUCCESS) {
        UIImage *img = [UIImage imageWithData: (NSData *)data];
        
        CGRect bounds = CGRectMake(0, 0, SCREEN_WIDTH,  self.bannerHeight);  //获取界面区域
        UIImageView* imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(bounds.size.width*2, bounds.origin.y, bounds.size.width, bounds.size.height)];
        imageView3.contentMode = UIViewContentModeScaleToFill;
        imageView3.image = [Utils scaleImage:img toScale:1];
        imageView3.tag = 10;
        imageView3.userInteractionEnabled = YES;
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delegate = self;
        singleTap.cancelsTouchesInView = NO;
        [imageView3 addGestureRecognizer:singleTap];
        
        [self.scrView addSubview:imageView3];
        
    }else if (code==GET_BANNER4_SUCCESS) {
        UIImage *img = [UIImage imageWithData: (NSData *)data];
        
        CGRect bounds = CGRectMake(0, 0, SCREEN_WIDTH,  self.bannerHeight);  //获取界面区域
        UIImageView* imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(bounds.size.width*3, bounds.origin.y, bounds.size.width, bounds.size.height)];
        imageView4.contentMode = UIViewContentModeScaleToFill;
        imageView4.image = [Utils scaleImage:img toScale:1];
        imageView4.tag = 11;
        imageView4.userInteractionEnabled = YES;
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delegate = self;
        singleTap.cancelsTouchesInView = NO;
        [imageView4 addGestureRecognizer:singleTap];
        
        [self.scrView addSubview:imageView4];
        
    }else if (code==GET_CRYPT_MOBILE_SUCCESS) {
        if (![data isMemberOfClass:[NSNull class]]) {
            self.rcode = [((NSMutableDictionary *)data) objectForKey:@"rcode"];
        }
    }
}

- (void) scrollBanners
{
    if (self.bannerTimer==nil) {
        [self.bannerTimer invalidate];
        self.bannerTimer = nil;
    }
    
    //time duration
    NSTimeInterval timeInterval = 3;
    //timer
    self.bannerTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self
                                                      selector:@selector(handleScroll:)
                                                      userInfo: nil
                                                       repeats:YES];
}

- (void)handleScroll:(NSTimer*)theTimer
{
    CGPoint pt = self.scrView.contentOffset;
    if(pt.x == SCREEN_WIDTH * (self.bannerCount-1)){
        [self.scrView scrollRectToVisible:CGRectMake(0,0,self.bannerWidth,self.bannerHeight) animated:YES];
        [self.pageCtrl setCurrentPage:0];
    }else{
        [self.scrView scrollRectToVisible:CGRectMake(pt.x+self.bannerWidth,0,self.bannerWidth,self.bannerHeight) animated:YES];
        [self.pageCtrl setCurrentPage:pt.x/SCREEN_WIDTH + 1];
    }
}

- (void)pageTurn:(UIPageControl*)sender
{
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = self.pageCtrl.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.scrView scrollRectToVisible:rect animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [self.pageCtrl setCurrentPage:offset.x / bounds.size.width];
}

@end
