//
//  GetCaptchaOperation.h
//  banhuitong
//
//  Created by user on 16-1-18.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import <UIKit/UIKit.h>
#import "HttpService.h"

@interface GetStreamOperation : BaseOperation

@property(nonatomic) NSString* url;
@property(nonatomic) int callbackCode;

-(id)initWithDelegate:(id<HttpResponseDelegate>) del andWithUrl:(NSString*) url andWithCallbackCode:(int) callbackCode;

@end
