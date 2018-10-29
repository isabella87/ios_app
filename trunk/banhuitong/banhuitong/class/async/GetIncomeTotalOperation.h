//
//  GetIncomeTotalOperation.h
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseOperation.h"
#import "HttpService.h"
#import "MyEnum.h"

@interface GetIncomeTotalOperation : BaseOperation

-(id)initWithType:(int) type andWithDelegate:(id<HttpResponseDelegate>) del;

@property(nonatomic) int type;

@end
