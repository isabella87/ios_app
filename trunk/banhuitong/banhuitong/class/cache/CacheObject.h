//
//  CacheObject.h
//  banhuitong
//
//  Created by user on 16-1-4.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheObject : NSObject

+ (CacheObject *)sharedInstance;

@property(nonatomic) NSMutableDictionary *survey;
@property(nonatomic) NSMutableDictionary *personalInfo;

@end
