//
//  CaCancelOperation.h
//  banhuitong
//
//  Created by user on 16-1-18.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"

@interface CaCancelOperation : BaseOperation

@property(nonatomic)NSString *pid;

-(id)initWithDelegate:(id<HttpResponseDelegate>) del;

@end
