//
//  CaApplyOperation.m
//  banhuitong
//
//  Created by user on 16-1-18.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "CaApplyOperation.h"

@implementation CaApplyOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        [self.httpResponseDelegate callbackWithCode:CA_APPLY_SUCCESS  andWithData:nil];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
    
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.mobileCode forKey:@"mobileCode"];
    [params setObject:self.pwd forKey:@"pwd"];
    [params setObject:self.assignDays forKey:@"assignDays"];
    [params setObject:self.assignAmount forKey:@"assignAmount"];
    [params setObject:self.isRateLocked forKey:@"isRateLocked"];
    [params setObject:self.assignRate forKey:@"assignRate"];
    
//    NSString *server = SERVER_ADDRESS_P2P;
//    NSString *url = [NSString stringWithFormat:@"%@%@%@", server, @"account/create-credit-assign/", self.tiid];
    
    NSString *baseUrl = URL_12;
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUrl, self.tiid];
    
    [[[HttpService alloc] initWithDelegate:self] requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_PUT];
}

@end
