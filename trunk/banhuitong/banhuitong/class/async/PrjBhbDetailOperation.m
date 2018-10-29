//
//  PrjBhbDetailOperation.m
//  banhuitong
//
//  Created by user on 16-1-19.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "PrjBhbDetailOperation.h"

@implementation PrjBhbDetailOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization  JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        
        [self.httpResponseDelegate callbackWithCode:GET_PRJ_BHB_DETAIL_SUCCESS  andWithData:dict];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil];
    
//    NSString *server = SERVER_ADDRESS_P2P;
    NSString *server = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@", server, @"account/bhb-apply-detail/", [NSString stringWithFormat:@"%d",self.tiId]];
    
    [[[HttpService alloc] initWithDelegate:self] requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
