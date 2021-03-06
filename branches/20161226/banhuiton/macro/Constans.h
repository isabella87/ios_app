//
//  Constants.h
//  banhuiton
//
//  Created by ym.sun on 16/12/7.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import <Foundation/Foundation.h>

//屏幕尺寸
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height * 8/9

//URL地址
//#define ROOT_URL    @"http://www.banbank.com/m/"
#define ROOT_URL    @"http://192.168.11.11/m/"
#define LOGIN_URL   [ROOT_URL stringByAppendingString:@"login.html"]
#define INDEX_URL   [ROOT_URL stringByAppendingString:@"index.html"]
#define PROJECT_URL [ROOT_URL stringByAppendingString:@"project/project-list.html"]
#define ACCOUNT_URL [ROOT_URL stringByAppendingString:@"account/accountment.html"]
#define MORE_URL    [ROOT_URL stringByAppendingString:@"info/more-info.html"]

@interface Constans : NSObject


@end
