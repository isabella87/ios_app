//
//  GetIncomeOperation.h
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"

@interface JxGetIncomeOperation : BaseOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>) del;

@property(nonatomic) int type;
@property(nonatomic) NSString *lastNxReld, *lastNxTrnn, *lastDatepoint;
@property(nonatomic) int pn;
//@property(nonatomic)BOOL isCheckCache;

-(BOOL) checkCache:(BOOL) isCheck;

@end
