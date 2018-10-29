//
//  IsRegisterOperation.h
//  banhuitong
//
//  Created by user on 16-1-19.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"

@interface IsRegisterOperation : BaseOperation

@property(nonatomic)NSString *mobile;

-(id)initWithDelegate:(id<HttpResponseDelegate>) del;

@end
