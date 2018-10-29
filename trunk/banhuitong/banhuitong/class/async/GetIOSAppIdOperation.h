//
//  GetIOSAppIdOperation.h
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"

@interface GetIOSAppIdOperation : BaseOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>) del;

@end
