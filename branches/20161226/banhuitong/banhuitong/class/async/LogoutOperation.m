//
//  LogoutOperation.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/27.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "LogoutOperation.h"

@implementation LogoutOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>) del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        //    NSMutableDictionary *dict = [NSJSONSerialization  JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        
        [self.httpResponseDelegate callbackWithCode:RESP_LOGOUT_SUCCESS andWithData:nil];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil];
    
//    NSString *server = SERVER_ADDRESS_ACC;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"account/sign-out"]withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_POST];
    
    NSString *url = URL_5;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_POST];
}

@end
