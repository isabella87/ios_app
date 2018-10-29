//
//  AsyncCenter.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/23.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsyncCenter : NSObject

@property(nonatomic,retain) NSOperationQueue * operationQueue;

+ (AsyncCenter *)sharedInstance;

@end
