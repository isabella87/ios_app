//
//  JxGetMobileCodeWhenOpenAccountOperation.m
//  banhuitong
//
//  Created by user on 16/7/1.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "JxGetMobileCodeWhenOpenAccountOperation.h"
#import "HttpService.h"

@implementation JxGetMobileCodeWhenOpenAccountOperation

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
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.mobile, @"mobile", self.type, @"type",nil];
    
//    NSString *server = SERVER_ADDRESS_P2P;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"base/send-mobile-code"] withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_PUT];
    
    NSString *url = URL_36;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_PUT];
}

@end
