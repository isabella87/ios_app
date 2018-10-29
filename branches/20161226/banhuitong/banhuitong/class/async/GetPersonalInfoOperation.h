//
//  GetPersonalInfoOperation.h
//  banhuitong
//
//  Created by user on 16-1-4.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseOperation.h"
#import "HttpService.h"
#import "CacheObject.h"

@interface GetPersonalInfoOperation : BaseOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>) del;

@end
