//
//  HttpService.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/23.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "NetworkRequest.h"
#import "BaseOperation.h"

@interface HttpService : NSObject

@property(nonatomic,strong)NetworkRequest *request;

@property(nonatomic) BaseOperation *del;

-(id)initWithDelegate:(id<NSURLConnectionDelegate>) del;

-(void)makeRequest;

-(void)requestWithUrl:(NSString *)url
           withHeader:(NSMutableDictionary *)headers
        withParamters:(NSMutableDictionary *)argument
           withMethod:(HTTP_METHOD)method;

@end
