//
//  LoginOperation.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/27.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "LoginOperation.h"

@implementation LoginOperation

-(id)initWithUsername:(NSString *) username andWithPassword:(NSString *)password andWithDelegate:(id<HttpResponseDelegate>) del{
    self.username = username;
    self.password = password;
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization  JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        
        id rst = [[dict objectForKey:@"signResult"] objectForKey:@"valid"];
        
        if ([[NSString stringWithFormat:@"%@",rst] isEqualToString:@"1"]) {
            [self.httpResponseDelegate callbackWithCode:RESP_LOGIN_SUCCESS andWithData:nil];
        }else{
            [self.httpResponseDelegate callbackWithCode:RESP_LOGIN_FAILED andWithData:nil];
        }
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"%@",self.username],@"login-name-or-mobile", [NSString stringWithFormat:@"%@",self.password],@"pwd",
                                   nil];
    
//    NSString *server = SERVER_ADDRESS_ACC;
//    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"account/sign-in"]withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_POST];
    
    NSString *url = URL_4;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_POST];
}

@end
