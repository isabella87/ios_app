//
//  MyLogin.h
//  Navigation
//
//  Created by ym.sun on 16/12/23.
//  Copyright © 2016年 banbank. All rights reserved.

//创建与js交互模型
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <JavaScriptCore/JavaScriptCore.h>

@protocol NativeApiProtocol <JSExport>

//方法名与js中一样
- (NSString *) getVersionName ;
- (void) showShares:(NSString *) rcodeUrl;
- (void) logins: (NSString *)username : (NSString *) password ;
- (void) logouts ;
@end

@interface MyLogin : NSObject <NativeApiProtocol>

@property(weak, nonatomic) JSContext *jsContext ;
@property(strong, nonatomic)UIViewController *vc ;

@end
