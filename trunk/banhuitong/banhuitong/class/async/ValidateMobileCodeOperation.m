//
//  ValidateMobileCodeOperation.m
//  banhuitong
//
//  Created by user on 16-1-18.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "ValidateMobileCodeOperation.h"

@implementation ValidateMobileCodeOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        [self.httpResponseDelegate callbackWithCode:MOBILE_CODE_VALID  andWithData:nil];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.mobile, @"mobile", self.captcha, @"captcha-code", self.mobileCode, @"mobile-code", nil];
    
    NSString *url = URL_8;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_POST];
}


@end
