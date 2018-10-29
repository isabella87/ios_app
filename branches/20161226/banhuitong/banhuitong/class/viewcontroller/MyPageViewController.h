//
//  MyPageViewController.h
//  banhuitong
//
//  Created by 陈鲁 on 16/2/6.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "IndexController2.h"
#import "MainViewController2.h"
#import "MyAccountController2.h"
#import "MoreController2.h"
#import "BaseViewController.h"

@interface MyPageViewController : BaseViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSArray *pageContent;
@property (strong, nonatomic) NSArray *viewControllers;
@property (nonatomic) int index;

@end
