//
//  JxGetMobileCodeWhenSetTradePwdOperation.h
//  banhuitong
//
//  Created by user on 16/7/1.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"

@interface JxGetMobileCodeWhenSetTradePwdOperation : BaseOperation

@property(nonatomic)NSString *mobile;
@property(nonatomic) NSString * type;

-(id)initWithDelegate:(id<HttpResponseDelegate>) del;

@end
