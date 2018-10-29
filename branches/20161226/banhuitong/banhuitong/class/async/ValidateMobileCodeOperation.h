//
//  ValidateMobileCodeOperation.h
//  banhuitong
//
//  Created by user on 16-1-18.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"

@interface ValidateMobileCodeOperation : BaseOperation

@property(nonatomic)NSString *mobile;
@property(nonatomic)NSString *captcha;
@property(nonatomic)NSString *mobileCode;

-(id)initWithDelegate:(id<HttpResponseDelegate>) del;

@end
