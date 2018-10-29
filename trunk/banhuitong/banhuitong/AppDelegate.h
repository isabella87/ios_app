//
//  AppDelegate.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/21.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface AppDelegate : UIResponder <
UIApplicationDelegate,
UIActionSheetDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) BOOL isLaunchedByNotification;

+ (BOOL) isLogin;

+ (BOOL) hasAccess;

+ (void) setShareHiden:(BOOL)shareHidden;
+ (BOOL) isShareHiden;
+ (BOOL) hasGestureLock;
+ (void) setGesturePassed:(BOOL)isGesturePassed;
+ (BOOL) isGesturePassed;

@end

