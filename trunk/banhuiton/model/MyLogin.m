//
//  MyLogin.m
//  Navigation
//
//  Created by ym.sun on 16/12/23.
//  Copyright © 2016年 banbank. All rights reserved.
//
#import "MyLogin.h"
#import "Constants.h"

#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "AppDelegate.h"

@implementation MyLogin

- (NSString *)getVersionName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey: @"CFBundleShortVersionString"] ;
}

- (void)webView:(id)unuse didCreateJavaScriptContext:(JSContext *)ctx forFrame:(id)frame {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidCreateContextNotification" object:ctx];
}

//采用友盟第三方集成，进行分享
-(void)showShares:(NSString *)rcodeUrl
{
    [UMSocialData setAppKey:UMENG_APPKEY];
    [UMSocialWechatHandler setWXAppId:WECHAT_AppID appSecret:WECHAT_AppSecret url:@"http://www.banbank.com"];
    [UMSocialQQHandler setQQWithAppId:QQ_APPID appKey:QQ_APPKEY url:@"http://www.banbank.com"];
    
    NSLog(@"mylogin分享对象中的rcode：%@", rcodeUrl) ;
    
    //友盟分享：微信设置URL、title
    [UMSocialData defaultData].extConfig.wechatSessionData.url = rcodeUrl;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"班汇通" ;
    //友盟分享：朋友圈设置URL、title
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = rcodeUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"班汇通" ;
    //友盟分享：QQ设置URL、title
    [UMSocialData defaultData].extConfig.qqData.url = rcodeUrl;
    [UMSocialData defaultData].extConfig.qqData.title = @"班汇通" ;
    //友盟分享：QQ空间设置URL、title
    [UMSocialData defaultData].extConfig.qzoneData.url = rcodeUrl;
    [UMSocialData defaultData].extConfig.qzoneData.title = @"班汇通" ;
    
    //友盟
    [UMSocialSnsService presentSnsIconSheetView: _vc
                                         appKey:UMENG_APPKEY
                                      shareText:@"班汇通 | 建筑业金融信息服务专家\n符合银监会规定的互联网金融平台"
                                     shareImage:[UIImage imageNamed:@"ic_launcher2"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,nil]
                                       delegate:nil];
}

//获取login.html登录页面的表单信息：用户名和密码
- (void)logins:(NSString *)username :(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey: SAVE_USERNAME] ;
    [[NSUserDefaults standardUserDefaults] setObject:password forKey: SAVE_PASSWORD] ;
}

//登出
- (void)logouts
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey: SAVE_USERNAME] ;
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey: SAVE_PASSWORD] ;
}

@end
