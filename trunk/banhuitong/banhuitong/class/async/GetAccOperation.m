//
//  GetAccOperation.m
//  banhuitong
//
//  Created by user on 16-1-4.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "GetAccOperation.h"

@implementation GetAccOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization  JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        
        [self.httpResponseDelegate callbackWithCode:GET_ACC_SUCCESS  andWithData:dict];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil];
    
//    NSString *server = SERVER_ADDRESS_ACC;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"account"]withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
    
    NSString *url = URL_2;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
