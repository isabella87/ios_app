//
//  GetBalanceOperation.m
//  banhuitong
//
//  Created by user on 16-1-4.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "GetBalanceOperation.h"

@implementation GetBalanceOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization  JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        
        [self.httpResponseDelegate callbackWithCode:GET_BALANCE_SUCCESS  andWithData:dict];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
    
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil];
    [params setObject:[NSString stringWithFormat:@"%@",self.savedUsername] forKey:@"login-name-or-mobile"];
    [params setObject:[NSString stringWithFormat:@"%@",self.savedPassword] forKey:@"pwd"];
    
//    NSString *server = SERVER_ADDRESS_P2P;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"trans/account-balance"]withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
    
    NSString *url = URL_32;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
