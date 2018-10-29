//
//  MyGongOperation.m
//  banhuitong
//
//  Created by user on 16-1-7.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "MyGongOperation.h"

@implementation MyGongOperation

-(id)initWithPage:(int) page andWithStatus:(int)status andWithDelegate:(id<HttpResponseDelegate>)del{
    self.page = page;
    self.status = status;
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization  JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        id items = [dict objectForKey:@"items"];
        
        PrjEntItem *item = [[PrjEntItem alloc] init];
        item.items = items;
        
        [self.httpResponseDelegate callbackWithCode:GET_MY_GONG_SUCCESS  andWithData:item];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"%d",self.page],@"pn",
                                   [NSString stringWithFormat:@"%d",self.status],@"status",
                                   nil];
    
//    NSString *server = SERVER_ADDRESS_P2P;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"account/investment"]withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
    
    NSString *url = URL_21;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
