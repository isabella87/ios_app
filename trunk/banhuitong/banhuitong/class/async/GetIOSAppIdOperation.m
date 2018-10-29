//
//  GetIOSAppIdOperation.m
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "GetIOSAppIdOperation.h"

@implementation GetIOSAppIdOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        [self.httpResponseDelegate callbackWithCode:GET_IOS_APP_ID  andWithData:dict];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
//    NSString *server = SERVER_ADDRESS_P2P;
//    NSString *url = [NSString stringWithFormat:@"%@app/ios-app-id", server];
    
    NSString *url = URL_37;
    
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end