//
//  MyBaoOperation.h
//  banhuitong
//
//  Created by user on 16-1-7.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"
#import "PrjEntItem.h"

@interface MyBaoOperation : BaseOperation

-(id)initWithPage:(int) page andWithStatus:(int) status andWithDelegate:(id<HttpResponseDelegate>) del;

@property(nonatomic) int page;
@property(nonatomic) int status;

@end
