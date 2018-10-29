//
//  AppDelegate.h
//  banhuiton
//
//  Created by ym.sun on 16/12/7.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (BOOL) isLogin ;
+ (BOOL) hasAccess;

@end

