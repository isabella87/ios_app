//
//  CustomTabBarViewController.h
//  Navigation
//
//  Created by ym.sun on 16/12/14.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountViewController.h"

@interface CustomTabBarViewController : UITabBarController <UITabBarControllerDelegate>
@property (nonatomic) BOOL isDataFromCache;
@end
