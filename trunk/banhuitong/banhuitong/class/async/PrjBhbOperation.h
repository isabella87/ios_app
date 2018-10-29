//
//  PrjBhbOperation.h
//  banhuitong
//
//  Created by user on 15-12-31.
//  Copyright (c) 2015年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"
#import "PrjBhbItem.h"

@interface PrjBhbOperation : BaseOperation

-(id)initWithPage:(int *) page andWithDelegate:(id<HttpResponseDelegate>) del;

@property(nonatomic) int page;

@end
