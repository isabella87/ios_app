//
//  SendMobileCodeOperation2.m
//  banhuitong
//
//  Created by user on 16-1-18.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "SendMobileCodeOperation2.h"

@implementation SendMobileCodeOperation2

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        [self.httpResponseDelegate callbackWithCode:SEND_MOBILE_CODE_SUCCESS  andWithData:nil];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.mobile, @"mobile", nil];
    
//    NSString *server = SERVER_ADDRESS_P2P;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"account/send-mobile-assign-code"] withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_PUT];
    
    NSString *url = URL_29;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_PUT];
}

@end
