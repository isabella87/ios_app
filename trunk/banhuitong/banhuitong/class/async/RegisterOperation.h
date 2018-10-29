//
//  RegisterOperation.h
//  banhuitong
//
//  Created by user on 16-1-19.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"

@interface RegisterOperation : BaseOperation

@property(nonatomic)NSString *mobile;
@property(nonatomic)NSString *realname;
@property(nonatomic)NSString *idNo;
@property(nonatomic)NSString *username;
@property(nonatomic)NSString *password;
@property(nonatomic)NSString *recommenderNo;
@property(nonatomic)NSString *orgCode;

-(id)initWithDelegate:(id<HttpResponseDelegate>) del;

@end
