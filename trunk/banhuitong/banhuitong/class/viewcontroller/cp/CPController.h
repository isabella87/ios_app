//
//  CPController.h
//  banhuitong
//
//  Created by user on 16/6/13.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "CPApi.h"
#import "Utils.h"
#import "BaseOperation.h"
#import "GetCPDataOperation.h"
#import "AsyncCenter.h"

@interface CPController : BaseViewController<CPApiDelegate>

@property(nonatomic) bool isFirst;

@end
