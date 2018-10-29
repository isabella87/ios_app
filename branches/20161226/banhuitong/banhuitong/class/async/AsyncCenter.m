//
//  AsyncCenter.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/23.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "AsyncCenter.h"

@implementation AsyncCenter
static AsyncCenter * sharedNC = nil;

- (void) dealloc{
    self.operationQueue = nil;
}

+ (AsyncCenter *)sharedInstance
{
    @synchronized(self)
    {
        if (!sharedNC)
            sharedNC = [[AsyncCenter alloc] init];
    }
    
    return(sharedNC);
}

-(id) init{
    //initialise a shared operation que
    NSOperationQueue * q = [[NSOperationQueue alloc]init];
    [q setMaxConcurrentOperationCount:-1];
    self.operationQueue = q;
    return [super init];
}

@end
