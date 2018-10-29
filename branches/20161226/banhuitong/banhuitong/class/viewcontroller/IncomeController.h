//
//  IncomeActivityViewController.h
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "RefreshTableController.h"
#import "AsyncCenter.h"
#import "MyEnum.h"
#import "BaseOperation.h"
#import "IncomeTableViewCell.h"

extern int incomeType;

@interface IncomeController : RefreshTableController

@property(nonatomic)NSInteger selectedIndex;
@property(nonatomic)BOOL isOpen;
@property(nonatomic) NSString *lastNxReld, *lastNxTrnn;

@end
