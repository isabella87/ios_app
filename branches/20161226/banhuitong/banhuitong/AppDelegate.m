//
//  AppDelegate.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/21.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import <AVFoundation/AVFoundation.h>
#import "IFlyFlowerCollector.h"

static BOOL booShareHiden;
static bool booGesturePassed = NO;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    
    NSError *setCategoryErr = nil;
    NSError *activationErr  = nil;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &setCategoryErr];
    [[AVAudioSession sharedInstance] setActive: YES error: &activationErr];
    
    //第三方统计
    [IFlyFlowerCollector SetDebugMode:NO];
    [IFlyFlowerCollector SetCaptureUncaughtException:NO];
    [IFlyFlowerCollector SetAppid:@"577cac71"];
    [IFlyFlowerCollector SetAutoLocation:YES];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    UIApplication*   app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [UMSocialSnsService  applicationDidBecomeActive];
    
    [UMSocialData defaultData].extConfig.qqData.title = @" ";
//    [UMSocialData defaultData].extConfig.qzoneData.title = @"Qzonetitle";
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"";
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"朋友圈title";
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"接收本地消息",nil);
    NSDictionary *userInfo = notification.userInfo;
    
    //判断应用程序当前的运行状态，如果是激活状态，则进行提醒，否则不提醒
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[userInfo objectForKey:@"title"] message:notification.alertBody delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:notification.alertAction, nil];
        [alert show];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_BACK_MYACCOUNT object:nil userInfo:nil];
    }
}

+(BOOL) isLogin{
    NSString *saveUsername = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_USERNAME];
    NSString *savePassword = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_PASSWORD];
    
    return saveUsername!=nil && savePassword!=nil;
}

+ (BOOL) hasGestureLock{
    return [[NSUserDefaults standardUserDefaults] objectForKey:GESTURE_LOCK]!=nil;
}

+(BOOL) hasAccess{
    NSString *hasAccess = [[NSUserDefaults standardUserDefaults] objectForKey:HAS_ACCESS];
    
    return [hasAccess isEqualToString:@"Y"];
}

+ (void) setShareHiden:(BOOL)shareHidden{
    booShareHiden = shareHidden;
}

+ (BOOL) isShareHiden{
    return booShareHiden;
}

+ (void) setGesturePassed:(BOOL)isGesturePassed{
    booGesturePassed = isGesturePassed;
}

+ (BOOL) isGesturePassed{
    return booGesturePassed;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

@end
