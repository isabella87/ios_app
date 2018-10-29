//
//  GetPersonalInfoOperation.m
//  banhuitong
//
//  Created by user on 16-1-4.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "GetPersonalInfoOperation.h"

@implementation GetPersonalInfoOperation
-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization  JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        
        [CacheObject sharedInstance].personalInfo = dict;
        
        [self.httpResponseDelegate callbackWithCode:GET_PERSONAL_INFO_SUCCESS andWithData:dict];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil];
    
//    NSString *server = SERVER_ADDRESS_ACC;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"account/user-info"]withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
    
    NSString *url = URL_3;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
