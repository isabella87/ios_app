//
//  SendMobileCodeOperation.m
//  banhuitong
//
//  Created by user on 16-1-18.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "SendMobileCodeLostPwdOperation.h"

@implementation SendMobileCodeLostPwdOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        NSString *data = (NSString *)dict;
        [self.httpResponseDelegate callbackWithCode:SEND_MOBILE_CODE_SUCCESS  andWithData:data];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.usernameOrMobile, @"login-name-or-mobile", self.captcha, @"captcha-code", nil];
    
//    NSString *server = SERVER_ADDRESS_ACC;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"account/send-lost-pwd-active-code"] withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_PUT];
    
    NSString *url = URL_9;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_PUT];
}

@end
