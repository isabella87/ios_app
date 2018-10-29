//
//  AboutusController.m
//  banhuitong
//
//  Created by user on 16-1-13.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "AboutusController.h"

@interface AboutusController ()

@end

@implementation AboutusController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader2:@"了解我们"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.layer1.tag = 1;
    self.layer2.tag = 2;
    self.layer3.tag =3;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap2.delegate = self;
    singleTap2.cancelsTouchesInView = NO;

    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap3.delegate = self;
    singleTap3.cancelsTouchesInView = NO;

    [self.layer1 addGestureRecognizer:singleTap];
    [self.layer2 addGestureRecognizer:singleTap2];
    [self.layer3 addGestureRecognizer:singleTap3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc{
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender{
    
    UIView *singleTapView = [sender view];
    int tag = singleTapView.tag;
    
    if (tag==1) {
        if ([Utils getIOSVersion]>=8.0) {
            ShowWKWebViewController *controller = (ShowWKWebViewController *)[Utils getControllerFromStoryboard:@"WKWebViewVC"];
            controller.myTitle = @"公司简介";
            controller.myUrl = [NSString stringWithFormat:@"%@app/aboutUs.html", MOBILE_ADDRESS];
            controller.hasFooter = YES;
            [self presentViewController:controller animated:NO completion:nil];
        }else{
            ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebViewVC"];
            controller.myTitle = @"公司简介";
            controller.myUrl = [NSString stringWithFormat:@"%@app/aboutUs.html", MOBILE_ADDRESS];
            controller.hasFooter = YES;
            [self presentViewController:controller animated:NO completion:nil];
        }
        
    }else if (tag==2) {
        if ([Utils getIOSVersion]>=8.0) {
            ShowWKWebViewController *controller = (ShowWKWebViewController *)[Utils getControllerFromStoryboard:@"WKWebViewVC"];
            controller.myTitle = @"管理团队";
            controller.myUrl = [NSString stringWithFormat:@"%@app/manager-team.html", MOBILE_ADDRESS];
            controller.hasFooter = YES;
            [self presentViewController:controller animated:NO completion:nil];
        }else{
            ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebViewVC"];
            controller.myTitle = @"管理团队";
            controller.myUrl = [NSString stringWithFormat:@"%@app/manager-team.html", MOBILE_ADDRESS];
            controller.hasFooter = YES;
            [self presentViewController:controller animated:NO completion:nil];
        }
        
    }else if (tag==3) {
        if ([Utils getIOSVersion]>=8.0) {
            ShowWKWebViewController *controller = (ShowWKWebViewController *)[Utils getControllerFromStoryboard:@"WKWebViewVC"];
            controller.myTitle = @"平台价值";
            controller.myUrl = [NSString stringWithFormat:@"%@", @"http://mp.weixin.qq.com/s?__biz=MzA5NTQ2NDc4Mw==&mid=2650324799&idx=2&sn=f95cf0d5f6a44e4a7116a6191a693ba0#rd"];
            controller.hasFooter = YES;
            [self presentViewController:controller animated:NO completion:nil];
        }else{
            ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebViewVC"];
            controller.myTitle = @"平台价值";
            controller.myUrl = [NSString stringWithFormat:@"%@", @"http://mp.weixin.qq.com/s?__biz=MzA5NTQ2NDc4Mw==&mid=2650324799&idx=2&sn=f95cf0d5f6a44e4a7116a6191a693ba0#rd"];
            controller.hasFooter = YES;
            [self presentViewController:controller animated:NO completion:nil];
        }
    }
}

@end
