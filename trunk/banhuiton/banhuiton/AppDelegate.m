//
//  AppDelegate.m
//  banhuiton
//
//  Created by ym.sun on 16/12/7.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import "AppDelegate.h"
#import "TimerApplication.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //启动页隐藏状态栏，内容不隐藏
    [UIApplication sharedApplication].statusBarHidden = NO ;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey: SAVE_USERNAME] ;
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey: SAVE_PASSWORD] ;
}

//本地是否存在登录信息：1、如果登录过且没执行登出服务，则返回YES；否则返回NO
+ (BOOL)isLogin
{
    NSString *saveUsername = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_USERNAME];
    NSString *savePassword = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_PASSWORD];
    
    return saveUsername!=nil && savePassword!=nil;
}

//验证是否第一次打开app，第一次打开返回NO
+ (BOOL) hasAccess {
    NSString *hasAccess = [[NSUserDefaults standardUserDefaults] objectForKey:HAS_ACCESS];
    return [hasAccess isEqualToString:@"Y"];
}

@end
