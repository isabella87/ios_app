//
//  Constants.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/23.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    HTTP_RESPONSE_CODE_OK           = 200,
    HTTP_RESPONSE_CODE_REDIRECT     = 301,
    HTTP_RESPONSE_CODE_BAD_REQUEST  = 400,
    HTTP_RESPONSE_CODE_UNAUTHORISED = 401,
    HTTP_RESPONSE_CODE_NOT_FOUND    = 404,
    HTTP_RESPONSE_CODE_SERVER_ERROR = 500
}HTTP_RESPONSE_CODE;

typedef enum{
    HTTP_METHOD_POST,
    HTTP_METHOD_GET,
    HTTP_METHOD_PUT
} HTTP_METHOD;

@interface Constants : NSObject
{
}

#define defaultTimeoutSeconds       30
#define NETWORK_ERROR               500

//屏幕尺寸
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height * 8/9
//启动引导页的key值
#define HAS_ACCESS @"HAS_ACCESS"
//设置引导页page controller控件的颜色
#define MYCOLOR_LIGHT_BLUE [UIColor colorWithRed:0x64/255.0 green:0x95/255.0 blue:0xED/255.0 alpha:1]

//URL地址
//#define ROOT_URL            @"https://www.banbank.com/"  /*线上URL地址*/
#define ROOT_URL            @"http://192.168.11.30/"    /*线下URL地址*/

//#define SERVER_ADDRESS_ACC  [ROOT_URL stringByAppendingString:@"accsrv/"]
//#define SERVER_ADDRESS_P2P  [ROOT_URL stringByAppendingString:@"p2psrv/"]

#define LOGIN_URL           [ROOT_URL stringByAppendingString:@"m/login.html"]
#define INDEX_URL           [ROOT_URL stringByAppendingString:@"m/index.html"]
#define PROJECT_URL         [ROOT_URL stringByAppendingString:@"m/project/project-list.html"]
#define ACCOUNT_URL         [ROOT_URL stringByAppendingString:@"m/account/accountment.html"]
#define MORE_URL            [ROOT_URL stringByAppendingString:@"m/info/more-info.html"]
#define CREDIT_URL          [ROOT_URL stringByAppendingString:@"m/creditassign/credit-assign-list.html"]

//友盟分享key配置
#define UMENG_APPKEY @"56b54fd667e58eac05000281"
#define WECHAT_AppID @"wx1c370b31e3b58bbf"
#define WECHAT_AppSecret @"f00857b427013ea249ff70bddc7cee9a"
#define QQ_APPID @"1105114255"
#define QQ_APPKEY @"kMS12qvSR27Za5Yz"

//保存登录信息username、password
#define SAVE_USERNAME @"USERNAME"
#define SAVE_PASSWORD @"PASSWORD"
//一段时间内用户无操作
#define CLEAR_CACHE @"CLEAR_CACHE"
//定时时间
#define TIMER 35 * 60

#define GET_RCODE_URL (1038)

@end
