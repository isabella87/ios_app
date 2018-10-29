//
//  PrjBhbOperation.m
//  banhuitong
//
//  Created by user on 15-12-31.
//  Copyright (c) 2015年 banhuitong. All rights reserved.
//

#import "PrjBhbOperation.h"

@implementation PrjBhbOperation

-(id)initWithPage:(int *) page andWithDelegate:(id<HttpResponseDelegate>)del{
    self.page = *(page);
    return [super initWithDelegate:del];
    
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization  JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        id items = [dict objectForKey:@"items"];
        
        PrjBhbItem *item = [[PrjBhbItem alloc] init];
        item.items = items;
        
        [self.httpResponseDelegate callbackWithCode:GET_PRJ_BHB_SUCCESS andWithData:item];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
    
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"%d",self.page],@"pn",
                                   nil];
    
//    NSString *server = SERVER_ADDRESS_P2P;
    NSString *server = @"";
    
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"bhb/all"]withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
