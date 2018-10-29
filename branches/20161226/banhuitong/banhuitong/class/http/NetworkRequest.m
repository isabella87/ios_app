//
//  NetworkRequest.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/23.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "NetworkRequest.h"

@implementation NetworkRequest

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        NSMutableDictionary * pdict = [[NSMutableDictionary alloc]initWithCapacity:20];
        self.params = pdict;
        
        pdict = [[NSMutableDictionary alloc] initWithCapacity:20];
        self.header = pdict;
        
        self.method = HTTP_METHOD_GET;
    }
    
    return self;
}

- (id)initWithUrl:(NSString * )uri
{
    self = [super init];
    if(self){
        self.url = uri;
    }
    return self;
}

- (void)setParamWithKey:(NSString *)key AndValue:(id )value
{
    NSAssert(key, @"the key cannot be null for a http paramater");
    if(value == Nil)
        value = @"";
    if(!self.params){
        NSMutableDictionary * parameters = [[NSMutableDictionary alloc]initWithCapacity:20];
        self.params = parameters;
    }
    
    [self.params setObject:value forKey:key];
}

- (void)dealloc
{
    self.url = nil;
    self.params = nil;
    self.header = nil;
}

@end
