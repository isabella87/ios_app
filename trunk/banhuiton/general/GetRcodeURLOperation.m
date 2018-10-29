//
//  GetRcodeURLOperation.m
//  banhuitong
//
//  Created by ym.sun on 2017/7/13.
//  Copyright © 2017年 banbank. All rights reserved.
//

#import "GetRcodeURLOperation.h"
#import "HttpService.h"
#import "Constants.h"
#import "Urls.h"

@implementation GetRcodeURLOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        [self.httpResponseDelegate callbackWithCode:GET_RCODE_URL andWithData:dict];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *url = URL_36;
    
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
