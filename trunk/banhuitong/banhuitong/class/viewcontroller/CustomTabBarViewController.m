//
//  CustomTabBarViewController.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/26.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "CustomTabBarViewController.h"

NSString *trackViewUrl;

@interface CustomTabBarViewController ()

@end

@implementation CustomTabBarViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([AppDelegate hasGestureLock] && ![AppDelegate isGesturePassed]) {
        [self performSelector:@selector(toGestureCheck) withObject:nil afterDelay:0.0f];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    
//    [[AsyncCenter sharedInstance].operationQueue addOperation:[[GetIOSAppIdOperation alloc] initWithDelegate:self]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backMyAccount) name:NOTIFY_BACK_MYACCOUNT object:nil];
    
    for (UITabBarItem *item in self.tabBar.items) {
        
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
        
        switch (item.tag) {
            case 0:
                item.image=[[UIImage imageNamed:@"footer_home.png" ] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                item.selectedImage=[[UIImage imageNamed:@"footer_home_highlight.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                break;
            case 1:
                item.image=[[UIImage imageNamed:@"footer_product.png" ] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                item.selectedImage=[[UIImage imageNamed:@"footer_product_highlight.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                break;
            case 2:
                item.image=[[UIImage imageNamed:@"footer_myaccount.png" ] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                item.selectedImage=[[UIImage imageNamed:@"footer_myaccount_highlight.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                break;
            case 3:
                item.image=[[UIImage imageNamed:@"footer_more.png" ] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                item.selectedImage=[[UIImage imageNamed:@"footer_more_highlight.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                break;
            default:
                break;
        }
    }
    
    [MainViewController setTab:1];
    
    [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(getUnreadMsgCount:) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(getUnreadMsg:) userInfo:nil repeats:YES];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_BACK_MYACCOUNT object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger tag = item.tag;
    
    if (tag==2 || tag==1) {
        if(![AppDelegate isLogin]) {
            self.selectedIndex = 0;
            LoginController *controller = (LoginController *)[Utils getControllerFromStoryboard:@"LoginVC"];
            [self presentViewController:controller animated:NO completion:nil];
            
            return;
        }
    }
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    if (code == RESP_LOGIN_SUCCESS) {
        NSLog(@"登录成功",nil);
    }else if (code == RESP_LOGIN_FAILED) {
        NSLog(@"登录失败",nil);
    }else if (code == GET_IOS_APP_ID) {
        id dic = (NSMutableDictionary*)data;
        
        if (dic != [NSNull null]) {
            GetAppVersionOperation *op = [[GetAppVersionOperation alloc] initWithDelegate:self];
            op.appId = [dic objectForKey:@"iosAppId"];
            [[AsyncCenter sharedInstance].operationQueue addOperation:op];
        }
    }else if (code == GET_APP_VERSION) {
        NSArray *infoArray = [(NSMutableDictionary*)data objectForKey:@"results"];
        if ([infoArray count]>0) {
            NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
            if ([releaseInfo count]>0) {
                NSString *latestVersion = [releaseInfo objectForKey:@"version"];
                trackViewUrl = [releaseInfo objectForKey:@"trackViewUrl"];
                NSString *curVersion = [Utils getAppVersion];
                
                if (![curVersion isEqualToString:latestVersion]) {
                    NSLog(@"有新版本",nil);
                    UIAlertView* alertview =[[UIAlertView alloc] initWithTitle:@"版本升级" message:[NSString stringWithFormat:@"发现有新版本，是否升级？"] delegate:self cancelButtonTitle:@"暂不升级" otherButtonTitles:@"马上升级", nil];
                    alertview.tag = 1;
                    [alertview show];
                }
            }
        }
    }else  if (code==GET_UNREAD_MSG_COUNT_SUCCESS) {
        NSLog(@"获取未读条数",nil);
        int unreadCount = [((NSString *)data) intValue];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:unreadCount];
    }else  if (code==GET_UNREAD_MSG_SUCCESS) {
        NSLog(@"获取未读消息",nil);
        id dic = [((NSMutableDictionary*)data) objectForKey:@"item"];
        
        if (dic != [NSNull null]) {
            
            int amId = nil;
            if ([dic objectForKey:@"amId"]!=nil) {
                amId = [((NSString *)[dic objectForKey:@"amId"]) intValue];
            }
            
            int amId_saved = nil;
            if ([[NSUserDefaults standardUserDefaults] objectForKey:SAVE_AM_ID]!=nil) {
                amId_saved = [[[NSUserDefaults standardUserDefaults] objectForKey:SAVE_AM_ID] intValue];
            }
            
            if (amId>amId_saved || amId_saved==nil) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", amId] forKey:SAVE_AM_ID];
                [self performSelector:@selector(doNotify:) withObject:dic afterDelay:3.0f];
            }
        }
    }
}

-(void)backMyAccount{
    NSArray *vc = self.viewControllers;
    [self setSelectedViewController:[vc objectAtIndex:2]];
}

- (void)getUnreadMsgCount:(NSTimer *)theTimer
{
    BaseOperation *op = [[GetUnreadMsgCountOperation alloc] initWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
}

- (void)getUnreadMsg:(NSTimer *)theTimer
{
    BaseOperation *op = [[GetUnreadMsgOperation alloc] initWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
}

-(void) doNotify:(NSDictionary*) dic{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    if (noti) {
        //设置推送时间
        noti.fireDate = date;
        //设置时区
        noti.timeZone = [NSTimeZone defaultTimeZone];
        //设置重复间隔
        noti.repeatInterval = NSWeekCalendarUnit;
        //推送声音
        noti.soundName = UILocalNotificationDefaultSoundName;
        //内容
        noti.alertBody = [dic objectForKey:@"brief"];
        //设置userinfo 方便在之后需要撤销的时候使用
        noti.userInfo = dic;
        
        noti.alertTitle = [dic objectForKey:@"title"];
        
        //添加推送到uiapplication
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:noti];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 1:
            if (buttonIndex == 1){
                UIApplication *application = [UIApplication sharedApplication];
                [application openURL:[NSURL URLWithString:trackViewUrl]];
            }
            break;
        default:
            break;
    }
}

-(void) toGestureCheck{
    GestureLockController *controller = (GestureLockController *)[Utils getControllerFromStoryboard:@"GestureLockVC"];
    controller.opt = GESTURE_LOCK_OPT_CHECK;
    [self presentViewController:controller animated:NO completion:nil];
}

@end
