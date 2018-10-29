//
//  NetworkRequest.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/23.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface NetworkRequest : NSObject{
}

@property(nonatomic,retain)NSString * url;

@property(nonatomic)HTTP_METHOD method;
@property(nonatomic,retain)NSMutableDictionary * params;
@property(nonatomic,retain)NSMutableDictionary * header;

- (void)setParamWithKey:(NSString *)key AndValue:(id)value;
- (id)initWithUrl:(NSString * )uri;

@end
