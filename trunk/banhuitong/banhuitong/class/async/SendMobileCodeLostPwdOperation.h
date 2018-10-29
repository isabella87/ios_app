//
//  SendMobileCodeOperation.h
//  banhuitong
//
//  Created by user on 16-1-18.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"

@interface SendMobileCodeLostPwdOperation : BaseOperation

@property(nonatomic)NSString *usernameOrMobile;
@property(nonatomic)NSString *captcha;

-(id)initWithDelegate:(id<HttpResponseDelegate>) del;

@end
