//
//  CacheObject.m
//  banhuitong
//
//  Created by user on 16-1-4.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "CacheObject.h"

@implementation CacheObject

static CacheObject * sharedNC = nil;

- (void) dealloc{

}

+ (CacheObject *)sharedInstance
{
    @synchronized(self)
    {
        if (!sharedNC)
            sharedNC = [[CacheObject alloc] init];
    }
    
    return(sharedNC);
}

@end
