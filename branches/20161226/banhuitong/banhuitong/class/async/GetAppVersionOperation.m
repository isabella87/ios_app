//
//  GetAppVersionOperation.m
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "GetAppVersionOperation.h"

@implementation GetAppVersionOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        [self.httpResponseDelegate callbackWithCode:GET_APP_VERSION  andWithData:dict];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"%@",self.appId],@"id",
                                   nil];
    
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:APP_INFO_URL withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
