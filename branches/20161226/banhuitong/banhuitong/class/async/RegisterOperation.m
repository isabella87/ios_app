//
//  RegisterOperation.m
//  banhuitong
//
//  Created by user on 16-1-19.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "RegisterOperation.h"

@implementation RegisterOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        [self.httpResponseDelegate callbackWithCode:REGISTER_SUCCESS  andWithData:nil];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.mobile forKey:@"mobile"];
    [params setObject:self.realname forKey:@"real-name"];
    [params setObject:self.idNo forKey:@"id-card"];
    [params setObject:self.username forKey:@"login-name"];
    [params setObject:self.password forKey:@"pwd"];
    [params setObject:self.recommenderNo forKey:@"recommend-mobile"];
    [params setObject:self.orgCode forKey:@"org-code"];
    
//    NSString *server = SERVER_ADDRESS_ACC;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"reg/register-person"] withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_PUT];
    
    NSString *url = URL_6;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_PUT];
}

@end
