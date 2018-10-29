//
//  MyInvestController.h
//  banhuitong
//
//  Created by user on 16-1-6.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "MyGongController.h"
#import "MyBaoController.h"
#import "MyZhuanController.h"
#import "MoveView.h"

@interface MyInvestController : BaseViewController

@property (strong, nonatomic) IBOutlet UIView *layerGong;
@property (strong, nonatomic) IBOutlet UIView *layerBao;
@property (strong, nonatomic) IBOutlet UIView *layerZhuan;
@property(nonatomic) MoveView *moveView;

@end
