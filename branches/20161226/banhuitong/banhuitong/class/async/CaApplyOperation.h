//
//  CaApplyOperation.h
//  banhuitong
//
//  Created by user on 16-1-18.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"

@interface CaApplyOperation : BaseOperation

@property(nonatomic)NSString *tiid;
@property(nonatomic)NSString *mobileCode;
@property(nonatomic)NSString *pwd;
@property(nonatomic)NSString *assignDays;
@property(nonatomic)NSString *assignAmount;
@property(nonatomic)NSString *isRateLocked;
@property(nonatomic)NSString *assignRate;

-(id)initWithDelegate:(id<HttpResponseDelegate>) del;

@end
