//
//  IsRegisterOperation.m
//  banhuitong
//
//  Created by user on 16-1-19.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "IsRegisterOperation.h"

@implementation IsRegisterOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSString *result  =[[ NSString alloc] initWithData:self.requestData encoding:NSUTF8StringEncoding];
        if ([result containsString:@"true"]) {
            [self.httpResponseDelegate callbackWithCode:REGISTER_ALREADY  andWithData:nil];
        }else if ([result containsString:@"false"]){
            [self.httpResponseDelegate callbackWithCode:REGISTER_NOT_YET  andWithData:nil];
        }
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
    
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   self.mobile, @"mobile", nil];
    
//    NSString *server = SERVER_ADDRESS_P2P;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"app/exist-user-with-mobile"] withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
    
    NSString *url = URL_28;
    
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
