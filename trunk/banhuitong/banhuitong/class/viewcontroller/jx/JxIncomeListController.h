//
//  JxIncomeListController.h
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "BaseOperation.h"
#import "GetIncomeTotalOperation.h"
#import "MyEnum.h"
#import "AsyncCenter.h"
#import "JxIncomeController.h"

@interface JxIncomeListController : BaseViewController

@property (strong, nonatomic) IBOutlet UIView *layerIn;
@property (strong, nonatomic) IBOutlet UIView *layerOut;

@property (strong, nonatomic) UITapGestureRecognizer *singleTap, *singleTap2;

@end
