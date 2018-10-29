//
//  GetCaptchaOperation.m
//  banhuitong
//
//  Created by user on 16-1-18.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "GetCaptchaOperation.h"

@implementation GetCaptchaOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        UIImage *image = [UIImage imageWithData: self.requestData];
        [self.httpResponseDelegate callbackWithCode:GET_CAPTCHA_SUCCESS  andWithData:image];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil];
    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil];
    
//    NSString *server = SERVER_ADDRESS_ACC;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"reg/captcha-image"]withHeader:headers withParamters:params withMethod:HTTP_METHOD_GET];
    
    NSString *url = URL_1;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
