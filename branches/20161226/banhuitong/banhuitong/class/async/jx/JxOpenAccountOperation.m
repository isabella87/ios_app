//
//  JxOpenAccountOperation.m
//  banhuitong
//
//  Created by user on 16/7/1.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "JxOpenAccountOperation.h"

@implementation JxOpenAccountOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization  JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        
        [self.httpResponseDelegate callbackWithCode:JX_OPEN_ACCOUNT_SUCCESS  andWithData:dict];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil];
    [params setObject:self.idNo forKey:@"id-no"];
    [params setObject:self.bankCard forKey:@"recard"];
    [params setObject:self.mobileCode forKey:@"mobile-code"];
    [params setObject:[NSString stringWithFormat:@"%@",self.savedUsername] forKey:@"login-name-or-mobile"];
    [params setObject:[NSString stringWithFormat:@"%@",self.savedPassword] forKey:@"pwd"];
    
//    NSString *server = SERVER_ADDRESS_P2P;
//    NSString *url = [NSString stringWithFormat:@"%@trans/third-account-register", server];
    
    NSString *url = URL_35;
    
    [[[HttpService alloc] initWithDelegate:self] requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_POST];
}

@end
