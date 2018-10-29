//
//  PersonalInfoController.h
//  banhuitong
//
//  Created by user on 16-1-6.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "CacheObject.h"
#import "BaseOperation.h"
#import "LogoutOperation.h"
#import "AsyncCenter.h"

@interface PersonalInfoController : BaseViewController

@property (strong, nonatomic) IBOutlet UILabel *lblLoginName;
@property (strong, nonatomic) IBOutlet UILabel *lblRealName;
@property (strong, nonatomic) IBOutlet UILabel *lblIdNo;
@property (strong, nonatomic) IBOutlet UILabel *lblMobile;
@property (strong, nonatomic) IBOutlet UIButton *logout;

@end
