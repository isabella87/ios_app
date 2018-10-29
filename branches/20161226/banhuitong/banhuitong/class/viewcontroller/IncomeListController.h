//
//  IncomeListController.h
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
#import "IncomeController.h"

@interface IncomeListController : BaseViewController

@property (strong, nonatomic) IBOutlet UIView *layerInvest;
@property (strong, nonatomic) IBOutlet UIView *layerRepay;
@property (strong, nonatomic) IBOutlet UIView *layerPay;
@property (strong, nonatomic) IBOutlet UIView *layerBonus;
@property (strong, nonatomic) IBOutlet UIView *layerRecharge;
@property (strong, nonatomic) IBOutlet UIView *layerWithdraw;
@property (strong, nonatomic) IBOutlet UIView *layerNotice;

@property (strong, nonatomic) IBOutlet UILabel *lblInvest;
@property (strong, nonatomic) IBOutlet UILabel *lblRepay;
@property (strong, nonatomic) IBOutlet UILabel *lblPay;
@property (strong, nonatomic) IBOutlet UILabel *lblBonus;
@property (strong, nonatomic) IBOutlet UILabel *lblRecharge;
@property (strong, nonatomic) IBOutlet UILabel *lblWithdraw;

@property (strong, nonatomic) UITapGestureRecognizer *singleTap, *singleTap2, *singleTap3, *singleTap4, *singleTap5, *singleTap6;

@end
