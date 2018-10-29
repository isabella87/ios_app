//
//  PrjEntOperation.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/23.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseOperation.h"
#import "PrjEntItem.h"
#import "HttpService.h"

@interface PrjEntOperation : BaseOperation

-(id)initWithPage:(int *) page andWithDelegate:(id<HttpResponseDelegate>) del;

@property(nonatomic) int page;

@end
