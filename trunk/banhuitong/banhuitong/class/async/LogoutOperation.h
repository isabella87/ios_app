//
//  LogoutOperation.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/27.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"
#import "HttpService.h"

@interface LogoutOperation : BaseOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>) del;

@end
