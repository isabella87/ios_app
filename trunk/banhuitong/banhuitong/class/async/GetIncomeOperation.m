//
//  GetIncomeOperation.m
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "GetIncomeOperation.h"

@implementation GetIncomeOperation

-(id)initWithPage:(int) page andWithType:(int) type andWithDelegate:(id<HttpResponseDelegate>)del{
    self.page = page;
    self.type = type;
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        id items = [dict objectForKey:@"list"];
        [self.httpResponseDelegate callbackWithCode:GET_ACC_INCOME  andWithData:items];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
    
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%d",self.page] forKey:@"pn"];
    [params setObject:[NSString stringWithFormat:@"%d",self.type] forKey:@"type"];
    
//    NSString *server = SERVER_ADDRESS_P2P;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"account/income"]withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
    
    NSString *url = URL_18;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
