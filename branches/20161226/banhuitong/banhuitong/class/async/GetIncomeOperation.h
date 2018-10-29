//
//  GetIncomeOperation.h
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"

@interface GetIncomeOperation : BaseOperation

-(id)initWithPage:(int) page andWithType:(int) type andWithDelegate:(id<HttpResponseDelegate>) del;

@property(nonatomic) int page;
@property(nonatomic) int type;

@end
