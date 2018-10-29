//
//  LoginOperation.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/27.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"

@interface LoginOperation : BaseOperation

-(id)initWithUsername:(NSString *) username andWithPassword:(NSString *)password andWithDelegate:(id<HttpResponseDelegate>) del;

@property(nonatomic) NSString* username;
@property(nonatomic) NSString* password;

@end
