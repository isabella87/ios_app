//
//  PrjEntOperation.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/23.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "PrjEntOperation.h"

@implementation PrjEntOperation

-(id)initWithPage:(int *) page andWithDelegate:(id<HttpResponseDelegate>)del{
    self.page = page;
    return [super initWithDelegate:del];
    
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization  JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        id items = [dict objectForKey:@"items"];
        
        PrjEntItem *item = [[PrjEntItem alloc] init];
        item.items = items;
        
        [self.httpResponseDelegate callbackWithCode:GET_PRJ_ENTS_SUCCESS  andWithData:item];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"%d",self.page],@"pn",
                                   nil];
    
//    NSString *server = SERVER_ADDRESS_P2P;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"project/all"]withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
    
    NSString *url = URL_24;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
