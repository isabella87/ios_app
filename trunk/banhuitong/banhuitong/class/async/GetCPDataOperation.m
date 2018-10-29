//
//  GetCPDataOperation.m
//  banhuitong
//
//  Created by user on 16-1-4.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "GetCPDataOperation.h"

@implementation GetCPDataOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization  JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        
        NSString *jsonSign = [dict objectForKey:@"sign-content"];
        NSData *jsonData = [jsonSign dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *signContent = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableDictionary *rst = [dict mutableCopy];
        [rst setValue:[signContent objectForKey:@"sign"] forKey:@"sign"];
        [rst setValue:[signContent objectForKey:@"appSysId"] forKey:@"appSysId"];
        
        [self.httpResponseDelegate callbackWithCode:GET_CPDATA_SUCCESS  andWithData:rst];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil];
    
//    NSString *server = SERVER_ADDRESS_P2P;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"app/user-info"]withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
    
    NSString *url = URL_16;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
