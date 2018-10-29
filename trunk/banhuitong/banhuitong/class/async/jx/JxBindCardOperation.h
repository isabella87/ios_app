//
//  JxBindCardOperation.h
//  banhuitong
//
//  Created by user on 16/7/1.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"

@interface JxBindCardOperation : BaseOperation

@property(nonatomic) NSString *bankCard, *mobileCode;

-(id)initWithDelegate:(id<HttpResponseDelegate>) del;

@end
