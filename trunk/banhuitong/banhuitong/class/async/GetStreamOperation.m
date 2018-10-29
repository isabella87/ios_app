//
//  GetCaptchaOperation.m
//  banhuitong
//
//  Created by user on 16-1-18.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "GetStreamOperation.h"

@implementation GetStreamOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>) del andWithUrl:(NSString*) url andWithCallbackCode:(int) callbackCode{
    self.url = url;
    self.callbackCode = callbackCode;
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        [self.httpResponseDelegate callbackWithCode:self.callbackCode  andWithData:self.requestData];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
    
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil];
    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil];
    
    [[[HttpService alloc] initWithDelegate:self] requestWithUrl:self.url withHeader:headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
