//
//  ValidateMobileCodeOperation.h
//  banhuitong
//
//  Created by user on 16-1-18.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"

@interface FindbackPwdOperation : BaseOperation

@property(nonatomic)NSString *usernameOrMobile;
@property(nonatomic)NSString *activeCode;

-(id)initWithDelegate:(id<HttpResponseDelegate>) del;

@end
