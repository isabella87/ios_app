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

#define UMENG_APPKEY @"56b54fd667e58eac05000281"
#define WECHAT_AppID @"wx1c370b31e3b58bbf"
#define WECHAT_AppSecret @"f00857b427013ea249ff70bddc7cee9a"
#define QQ_APPID @"1105114255"
#define QQ_APPKEY @"kMS12qvSR27Za5Yz"

#define IPHONE_5_HEIGHT 568
#define IPHONE_6_HEIGHT 667
#define IPHONE_6PLUS_HEIGHT 736

#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width

#define COOKIE_KEY_FORMAT           @"Cookie"

#define defaultTimeoutSeconds       30
#define NETWORK_TIMEOUT_AND_HIDE_SECONDS        20
#define NETWORK_ERROR        500

#define PATTERN_MOBILE  @"0?1[3|4|5|7|8][0-9]\\d{8}"
#define PATTERN_LETTER_NUMBER  @"[a-zA-Z0-9]*"

#define APP_INFO_URL @"http://itunes.apple.com/lookup"

#define SERVER_ADDRESS_APP              @"http://www.banbank.com/new-appsrv/"
#define MOBILE_ADDRESS              @"http://www.banbank.com/new-m/"

//#define SERVER_ADDRESS_APP              @"http://www.banbank.com/appsrv/"
//#define MOBILE_ADDRESS              @"http://www.banbank.com/m/"
//#define SERVER_ADDRESS_ACC              @"http://www.banbank.com/accsrv/"
//#define SERVER_ADDRESS_P2P              @"http://www.banbank.com/p2psrv/"
//#define SERVER_DOMAIN              @"http://www.banbank.com"

//#define SERVER_ADDRESS_APP              @"http://192.168.11.11/appsrv/"
//#define MOBILE_ADDRESS              @"http://192.168.11.11/m/"
//#define SERVER_DOMAIN              @"http://192.168.11.11"
//#define SERVER_ADDRESS_ACC              @"http://192.168.11.11/accsrv/"
//#define SERVER_ADDRESS_P2P              @"http://192.168.11.11/p2psrv/"

//#define SERVER_ADDRESS_APP              @"http://192.168.11.125:8082/appsrv/"
//#define MOBILE_ADDRESS              @"http://192.168.11.125:8082/m/"
//#define SERVER_DOMAIN              @"http://192.168.11.125:8082"
//#define SERVER_ADDRESS_ACC              @"http://192.168.11.125:8082/accsrv/"
//#define SERVER_ADDRESS_P2P              @"http://192.168.11.125:8082/p2psrv/"

#define RESP_LOGIN_SUCCESS 1000
#define RESP_LOGOUT_SUCCESS 1001
#define RESP_LOGIN_FAILED 1002
#define GET_PRJ_ENTS_SUCCESS 1003
#define GET_PRJ_CAS_SUCCESS 1004
#define GET_PRJ_BHB_SUCCESS (1005)
#define GET_ACC_SUCCESS (1006)
#define GET_ACC_SURVEY_SUCCESS (1007)
#define GET_PERSONAL_INFO_SUCCESS (1008)
#define GET_ACC_INCOME_TOTAL_OF_RECHARGE (1009)
#define GET_ACC_INCOME_TOTAL_OF_WITHDRAW (1010)
#define GET_ACC_INCOME_TOTAL_OF_INVEST (1011)
#define GET_ACC_INCOME_TOTAL_OF_REPAY (1012)
#define GET_ACC_INCOME_TOTAL_OF_BONUS (1013)
#define GET_ACC_INCOME_TOTAL_OF_EXPENDITURE (1014)
#define GET_ACC_INCOME (1015)
#define GET_MY_GONG_SUCCESS (1016)
#define GET_MY_BAO_SUCCESS (1017)
#define GET_MY_ZHUAN_SUCCESS (1018)
#define GET_CAPTCHA_SUCCESS (1019)
#define SEND_MOBILE_CODE_SUCCESS (1020)
#define SEND_MOBILE_CODE_FAIL (1021)
#define MOBILE_CODE_VALID (1022)
#define MOBILE_CODE_INVALID (1023)
#define REGISTER_SUCCESS (1024)
#define REGISTER_ALREADY (1025)
#define REGISTER_NOT_YET (1026)
#define GET_PRJ_ENT_DETAIL_SUCCESS (1027)
#define CA_APPLY_SUCCESS (1028)
#define CA_CANCEL_SUCCESS (1029)
#define GET_PRJ_BHB_DETAIL_SUCCESS (1030)
#define GET_CRYPT_MOBILE_SUCCESS (1031)
#define GET_QRCODE_SUCCESS (1032)
#define GET_REG_VIDEO_SUCCESS (1033)
#define GET_APP_VERSION (1034)
#define GET_UNREAD_MSG_COUNT_SUCCESS (1035)
#define GET_UNREAD_MSG_SUCCESS (1036)
#define GET_IOS_APP_ID (1037)
#define GET_CPDATA_SUCCESS (1038)
#define GET_JXPAY_INFO_SUCCESS (1039)
#define JX_OPEN_ACCOUNT_SUCCESS (1040)
#define JX_BIND_CARD_SUCCESS (1041)
#define JX_SET_TRADE_PWD_SUCCESS (1042)
#define GET_BALANCE_SUCCESS (1043)
#define GET_BANNER1_SUCCESS (1044)
#define GET_BANNER2_SUCCESS (1045)
#define GET_BANNER3_SUCCESS (1046)
#define GET_BANNER4_SUCCESS (1047)

#define HAS_ACCESS @"HAS_ACCESS"
#define SAVE_USERNAME @"USERNAME"
#define SAVE_PASSWORD @"PASSWORD"
#define REMEMBER_USER @"REMEMBER_USER"
#define SAVE_AM_ID @"AM_ID"
#define ASSET_ID @"ASSET_ID"
#define GESTURE_LOCK @"GESTURE_LOCK"
#define GESTURE_LOCK_OPT_CREATE 1
#define GESTURE_LOCK_OPT_DELETE 2
#define GESTURE_LOCK_OPT_UPDATE 3
#define GESTURE_LOCK_OPT_CHECK 4

#define NOTIFY_BACK_INDEX @"NOTIFY_BACK_INDEX"
#define NOTIFY_BACK_INDEX_FROM_DETAIL @"NOTIFY_BACK_INDEX_FROM_DETAIL"
#define NOTIFY_BACK_INDEX_AFTER_REGISTER @"NOTIFY_BACK_INDEX_AFTER_REGISTER"
#define NOTIFY_BACK_MYACCOUNT @"NOTIFY_BACK_MYACCOUNT"
#define NOTIFY_CREATE_GESTURE_LOCK @"NOTIFY_CREATE_GESTURE_LOCK"
#define NOTIFY_TO_JX @"NOTIFY_TO_JX"
#define NOTIFY_TO_RECHARGE @"NOTIFY_TO_RECHARGE"

#define JX_STATUS_PASS 100
#define JX_STATUS_NOT_OPEN 101
#define JX_STATUS_NOT_BIND_CARD 102
#define JX_STATUS_NO_PWD 103

#define MYCOLOR_LIGHT_BLUE [UIColor colorWithRed:0x64/255.0 green:0x95/255.0 blue:0xED/255.0 alpha:1]
#define MYCOLOR_GREEN [UIColor colorWithRed:0x00/255.0 green:0xEE/255.0 blue:0x00/255.0 alpha:1]
#define MYCOLOR_DARK_GREEN [UIColor colorWithRed:0x00/255.0 green:0x64/255.0 blue:0x00/255.0 alpha:1]

#define MYCOLOR_BLUE [UIColor colorWithRed:0x00/255.0 green:0xC5/255.0 blue:0xCD/255.0 alpha:1]
#define MYCOLOR_DARK_RED [UIColor colorWithRed:0xB2/255.0 green:0x22/255.0 blue:0x22/255.0 alpha:1]
#define MYCOLOR_RED [UIColor colorWithRed:0xFF/255.0 green:0x00/255.0 blue:0x00/255.0 alpha:1]
#define MYCOLOR_GRAY [UIColor colorWithRed:0x83/255.0 green:0x8B/255.0 blue:0x83/255.0 alpha:1]
#define MYCOLOR_DARK_GRAY [UIColor colorWithRed:0x00/255.0 green:0x64/255.0 blue:0x00/255.0 alpha:1]
#define MYCOLOR_ORANGE [UIColor colorWithRed:0xEE/255.0 green:0xB4/255.0 blue:0x22/255.0 alpha:1]

#define MSG_BALANCE_NOT_ENOUGH @"账户余额不足!\n为了您的资金安全，手机暂时不支持充值操作，请在电脑上登录班汇通官网进行充值操作。"
#define MSG_UNABLE_RECHARGE @"为了您的资金安全，手机暂时不支持充值操作，请在电脑上登录班汇通官网进行充值操作。"

@end
