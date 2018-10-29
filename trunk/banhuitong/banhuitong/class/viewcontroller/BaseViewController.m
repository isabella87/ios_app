//
//  BaseViewController.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/22.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseOperation.h"
#import "GetJxPayInfoOperation.h"
#import "AsyncCenter.h"
#import "JxOpenAccountController.h"
#import "JxBindCardController.h"
#import "JxSetTradePwdController.h"

int angle = 0;

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setClipsToBounds:YES];
    
    //设置旋转图案
    self.rotateImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-20, SCREEN_HEIGHT/2, 40, 40)];
    self.rotateImage.image = [UIImage imageNamed:@"loding.png"];
    self.rotateImage.hidden = YES;
    [self.view addSubview:self.rotateImage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isDataFromCache = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoJx:) name:NOTIFY_TO_JX object:nil];
    
    [UMSocialData setAppKey:UMENG_APPKEY];
    [UMSocialWechatHandler setWXAppId:WECHAT_AppID appSecret:WECHAT_AppSecret url:@"http://www.banbank.com"];
    [UMSocialQQHandler setQQWithAppId:QQ_APPID appKey:QQ_APPKEY url:@"http://www.banbank.com"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void) dealloc{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

#pragma mark -Actions

- (void) onBackAction
{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

-(void)showActiveLoading
{
    if (isRequesting) {
        return;
    }
    
    self.rotateImage.hidden = NO;
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100;
    
    [self.rotateImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    isRequesting = YES;
}

-(void)hideActiveLoading
{
    [self.rotateImage.layer removeAnimationForKey:@"rotationAnimation"];
    self.rotateImage.hidden = YES;
    isRequesting = NO;
}

-(void)showAlertWithText:(NSString *)text
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:text delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void) showHeader1 {
    
    //设置背景图片
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 50)];
    [self.headerView setBackgroundColor:MYCOLOR_BLUE];
    [self.view addSubview:self.headerView];
    
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head_bg.png"]];
    [self.headerView setBackgroundColor:bgColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doAction:)];
    [self.headerView addGestureRecognizer:tapGesture];
    
    //设置背景文字
    self.topTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, 9, 220, 30)];
    self.topTitle.text = @" | 建筑业金融信息服务专家";
    self.topTitle.font = [UIFont systemFontOfSize:16];
//    [self.topTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    self.topTitle.textColor = [UIColor whiteColor];
    self.topTitle.hidden = NO;
    [self.headerView addSubview:self.topTitle];
    
    //设置背景logo
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 130, 10, 80, 30)];
    self.logoImageView.image = [UIImage imageNamed:@"ban_logo.png"];
    self.logoImageView.hidden = NO;
    [self.headerView addSubview:self.logoImageView];
    
}

- (void) showHeader2:(NSString*) title {
    
    //设置背景图片
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 50)];
    [self.headerView setBackgroundColor:MYCOLOR_BLUE];
    [self.view addSubview:self.headerView];
    
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head_bg.png"]];
    [self.headerView setBackgroundColor:bgColor];
    
    //设置标题文字
    self.topTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - [title length]*8, 10, 200, 30)];
    self.topTitle.text = title;
    self.topTitle.font = [UIFont systemFontOfSize:16];
    self.topTitle.textColor = [UIColor whiteColor];
    self.topTitle.hidden = NO;
    [self.headerView addSubview:self.topTitle];
    
    //设置回退按钮
    self.btnBack = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.btnBack setBackgroundImage:[UIImage imageNamed:@"back.png"]forState:UIControlStateNormal];
    self.btnBack.hidden = NO;
    [self.headerView addSubview:self.btnBack];
    [self.btnBack addTarget:self action:@selector(onBackAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void) showFooter {
    
    //设置背景图片
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60)];
    [self.view addSubview:self.footerView];
    
    //设置回退按钮
    self.btnBack2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [self.btnBack2 setBackgroundImage:[UIImage imageNamed:@"back2.png"]forState:UIControlStateNormal];
    self.btnBack2.hidden = NO;
    [self.footerView addSubview:self.btnBack2];
    [self.btnBack2 addTarget:self action:@selector(onBackAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
     [self hideActiveLoading];
    
    if (code==NETWORK_ERROR){
//        [Utils showMessage:@"网络异常！" view:self.view];
    }else if (code==GET_JXPAY_INFO_SUCCESS) {
        
        if ([data isEqual:[NSNull null]]) {
            self.jxUserInfo = nil;
        }else{
            self.jxUserInfo = (NSMutableDictionary*)data;
        }
        [self gotoJx];
    }
}

-(void)doAction:(id)sender{
    [self.tabBarController setSelectedIndex:0];
}

-(void)refreshFooter:(int) index{
    self.footerImage1.image = [UIImage imageNamed:@"footer_home.png"];
    self.footerImage2.image = [UIImage imageNamed:@"footer_product.png"];
    self.footerImage3.image = [UIImage imageNamed:@"footer_myaccount.png"];
    self.footerImage4.image = [UIImage imageNamed:@"footer_more.png"];
    
    switch (index) {
        case 0:
           self.footerImage1.image = [UIImage imageNamed:@"footer_home_highlight.png"];
            break;
        case 1:
            self.footerImage2.image = [UIImage imageNamed:@"footer_product_highlight.png"];
            break;
        case 2:
            self.footerImage3.image = [UIImage imageNamed:@"footer_myaccount_highlight.png"];
            break;
        case 3:
            self.footerImage4.image = [UIImage imageNamed:@"footer_more_highlight.png"];
            break;
        default:
            break;
    }

}

- (void)swipe:(UISwipeGestureRecognizer *)gesture {

    NSInteger currentIndex = self.tabBarController.selectedIndex;
    
    CATransition *transaction = [CATransition animation];
    transaction.type = kCATransitionPush;
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        [transaction setSubtype:kCATransitionFromRight];
        self.tabBarController.selectedIndex = currentIndex + 1;
        
    } else {
        [transaction setSubtype:kCATransitionFromLeft];
        self.tabBarController.selectedIndex = currentIndex - 1;
    }
    
    if (currentIndex-1 < 0 || currentIndex+1 >= self.tabBarController.childViewControllers.count) {
        return;
    }
    
    transaction.duration = 0.5;
    transaction.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [[self.tabBarController.view layer] addAnimation:transaction forKey:@"switchView"];
}

- (void)exitApplication {
    [UIView beginAnimations:@"exitApplication" context:nil];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    [UIView commitAnimations];
}

- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        exit(0);
    }
}

-(void) startActivityIndicator{
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityIndicator.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);//只能设置中心，不能设置大小
    [self.view addSubview:self.activityIndicator ];
    self.activityIndicator.color = [UIColor redColor];
    [self.activityIndicator startAnimating]; // 开始旋转
}

-(void) stopActivityIndicator{
    if (self.activityIndicator!=nil) {
        [self.activityIndicator stopAnimating]; // 结束旋转
        [self.activityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void) getJxUserInfo{
    [self showActiveLoading];
    BaseOperation *op = [[GetJxPayInfoOperation alloc] initWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
}

-(int) getJxStatus{
    if (self.jxUserInfo!=nil) {
        if([self.jxUserInfo objectForKey:@"userId"]==nil || [[self.jxUserInfo objectForKey:@"userId"] isEqualToString:@""]){
            return JX_STATUS_NOT_OPEN;
        }else if([self.jxUserInfo objectForKey:@"recard"]==nil || [[self.jxUserInfo objectForKey:@"recard"] isEqualToString:@""]){
            return JX_STATUS_NOT_BIND_CARD;
        }else if([self.jxUserInfo objectForKey:@"isPwdSet"]==nil || ![(NSString*)[self.jxUserInfo objectForKey:@"isPwdSet"] boolValue]){
            return JX_STATUS_NO_PWD;
        }
         return JX_STATUS_PASS;
    }
    return -999;
}

-(void) gotoJx{
    BaseViewController *controller;

    switch ([self getJxStatus]) {
        case JX_STATUS_NOT_OPEN:
            controller = (BaseViewController *)[Utils getControllerFromStoryboard:@"JxOpenAccountVC"];
            [self presentViewController:controller animated:NO completion:nil];
            break;
        case JX_STATUS_NOT_BIND_CARD:
            controller = (BaseViewController *)[Utils getControllerFromStoryboard:@"JxBindCardVC"];
            [self presentViewController:controller animated:NO completion:nil];
            break;
        case JX_STATUS_NO_PWD:
            controller = (BaseViewController *)[Utils getControllerFromStoryboard:@"JxSetTradePwdVC"];
            [self presentViewController:controller animated:NO completion:nil];
            break;
        case JX_STATUS_PASS:
            [self showAlertWithText:[NSString stringWithFormat:@"您已开户成功。"]];
            break;
        default:
            break;
    }
}

-(void)gotoJx:(NSNotification*)notify{
    [self getJxUserInfo];
}

-(void) makeShare {
    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"%@app/share.html?rcode=%@", MOBILE_ADDRESS, self.rcode ];
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"%@app/share.html?rcode=%@", MOBILE_ADDRESS, self.rcode ];
    [UMSocialData defaultData].extConfig.qqData.url = [NSString stringWithFormat:@"%@app/share.html?rcode=%@", MOBILE_ADDRESS, self.rcode ];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"%@app/share.html?rcode=%@", MOBILE_ADDRESS, self.rcode];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMENG_APPKEY
                                      shareText:@"班汇通|领航建筑业互联网金融\n符合银监会规定的互联网金融平台"
                                     shareImage:[UIImage imageNamed:@"ic_launcher2.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,nil]
                                       delegate:nil];
}

@end
