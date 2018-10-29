//
//  GetAppVersionOperation.h
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"

@interface GetAppVersionOperation : BaseOperation

@property(nonatomic)NSString *appId;

-(id)initWithDelegate:(id<HttpResponseDelegate>) del;

@end
