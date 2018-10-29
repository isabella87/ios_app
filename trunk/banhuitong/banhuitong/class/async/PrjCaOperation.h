//
//  PrjCaOperation.h
//  banhuitong
//
//  Created by user on 15-12-30.
//  Copyright (c) 2015年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "PrjCaItem.h"
#import "HttpService.h"

@interface PrjCaOperation : BaseOperation

-(id)initWithPage:(int *) page andWithDelegate:(id<HttpResponseDelegate>) del;

@property(nonatomic) int page;

@end
