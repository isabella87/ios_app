//
//  BaseViewController.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/22.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpResponseDelegate.h"
#import "Constants.h"
#import "Utils.h"
#import "MyEnum.h"
#import "AppDelegate.h"
#import "WebViewJavascriptBridge.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocial.h"

@interface BaseViewController : UIViewController <HttpResponseDelegate,UIGestureRecognizerDelegate, UIAlertViewDelegate>
{
    BOOL isRequesting;
}

@property(nonatomic) NSMutableArray *dataArray;

@property (assign) BOOL didLoad;
@property (nonatomic) BOOL hasFooter;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *topTitle;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIButton *btnBack, *btnBack2;
@property (nonatomic, strong) UIImageView *rotateImage;
@property (nonatomic, retain) id dataObject;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIImageView *footerImage1;
@property (nonatomic, strong) UIImageView *footerImage2;
@property (nonatomic, strong) UIImageView *footerImage3;
@property (nonatomic, strong) UIImageView *footerImage4;
@property (nonatomic) UIActivityIndicatorView *activityIndicator;
@property (nonatomic) NSMutableDictionary *jxUserInfo;

@property(strong,nonatomic) NSString *rcode;
@property (nonatomic) BOOL isDataFromCache;

-(void)showAlertWithText:(NSString *)text;

-(void)showActiveLoading;

-(void)hideActiveLoading;

-(void)showHeader1;
-(void)showHeader2:(NSString*) title;
-(void)showFooter;
-(void)refreshFooter:(int) index;

- (void) onBackAction;
- (void) exitApplication;
-(void) startActivityIndicator;
-(void) stopActivityIndicator;

-(int) getJxStatus;
-(void) getJxUserInfo;
-(void) gotoJx;

-(void) makeShare;

@end


