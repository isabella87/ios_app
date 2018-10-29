//
//  BhbCaApplyOperation.m
//  banhuitong
//
//  Created by user on 16-1-18.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BhbCaApplyOperation.h"

@implementation BhbCaApplyOperation

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
    
//    NSString *server = SERVER_ADDRESS_P2P;
    NSString *server = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@", server, @"account/create-bhb-credit-assign/", self.tiid];
    
    [[[HttpService alloc] initWithDelegate:self] requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_PUT];
}

@end
