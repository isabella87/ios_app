//
//  ValidateMobileCodeOperation.m
//  banhuitong
//
//  Created by user on 16-1-18.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "FindbackPwdOperation.h"

@implementation FindbackPwdOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        [self.httpResponseDelegate callbackWithCode:MOBILE_CODE_VALID  andWithData:nil];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.usernameOrMobile, @"login-name-or-mobile", self.activeCode, @"active-code", nil];
    
//    NSString *server = SERVER_ADDRESS_ACC;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"account/reset-pwd"] withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_POST];
    
    NSString *url = URL_10;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_POST];
}


@end
