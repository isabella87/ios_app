//
//  IncomeListController.m
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "IncomeListController.h"

@implementation IncomeListController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showHeader2:@"资金明细"];
    [self myInit];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UILabel *lblNotice = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.view.frame.size.width - 60, 60)];
    lblNotice.font = [UIFont boldSystemFontOfSize:14];
    lblNotice.numberOfLines = 0;
    lblNotice.textColor = MYCOLOR_DARK_RED;
//    lblNotice.textAlignment = NSTextAlignmentCenter;
    [lblNotice setText:MSG_UNABLE_RECHARGE];
    [self.layerNotice addSubview:lblNotice];
    
    self.layerRecharge.tag = 1;
    self.layerWithdraw.tag = 2;
    self.layerInvest.tag =3;
    self.layerRepay.tag = 4;
    self.layerBonus.tag =5;
    self.layerPay.tag = 6;
    
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.singleTap .delegate = self;
    self.singleTap .cancelsTouchesInView = NO;
    
    self.singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.singleTap2 .delegate = self;
    self.singleTap2 .cancelsTouchesInView = NO;
    
    self.singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.singleTap3.delegate = self;
    self.singleTap3.cancelsTouchesInView = NO;
    
    self.singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.singleTap4.delegate = self;
    self.singleTap4.cancelsTouchesInView = NO;
    
    self.singleTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.singleTap5.delegate = self;
    self.singleTap5.cancelsTouchesInView = NO;
    
    self.singleTap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.singleTap6 .delegate = self;
    self.singleTap6 .cancelsTouchesInView = NO;

    
    [self.layerRecharge addGestureRecognizer:self.singleTap];
    [self.layerWithdraw addGestureRecognizer:self.singleTap2];
    [self.layerInvest addGestureRecognizer:self.singleTap3];
    [self.layerRepay addGestureRecognizer:self.singleTap4];
    [self.layerBonus addGestureRecognizer:self.singleTap5];
    [self.layerPay addGestureRecognizer:self.singleTap6];
}

- (void) dealloc{
    self.singleTap.delegate = nil;
    self.singleTap2.delegate = nil;
    self.singleTap3.delegate = nil;
    self.singleTap4.delegate = nil;
    self.singleTap5.delegate = nil;
    self.singleTap6.delegate = nil;
}

-(void) myInit{
    [self showActiveLoading];
    
    BaseOperation *op = [[GetIncomeTotalOperation alloc] initWithType:RECHARGE andWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    
    BaseOperation *op2 = [[GetIncomeTotalOperation alloc] initWithType:WITHDRAW andWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op2];
    
    BaseOperation *op3 = [[GetIncomeTotalOperation alloc] initWithType:TENDER andWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op3];
    
    BaseOperation *op4 = [[GetIncomeTotalOperation alloc] initWithType:REPAY andWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op4];
    
    BaseOperation *op5 = [[GetIncomeTotalOperation alloc] initWithType:REWARD andWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op5];
    
    BaseOperation *op6 = [[GetIncomeTotalOperation alloc] initWithType:FEE andWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op6];
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code == GET_ACC_INCOME_TOTAL_OF_RECHARGE) {
        self.lblRecharge.text = [[[Utils nf2] stringFromNumber:[((NSMutableDictionary*)data) objectForKey:@"totalAmt"]] stringByAppendingString:@"元"];
    }else  if (code==GET_ACC_INCOME_TOTAL_OF_WITHDRAW) {
        self.lblWithdraw.text = [[[Utils nf2] stringFromNumber:[((NSMutableDictionary*)data) objectForKey:@"totalAmt"]] stringByAppendingString:@"元"];
    }else  if (code==GET_ACC_INCOME_TOTAL_OF_INVEST) {
        self.lblInvest.text = [[[Utils nf2] stringFromNumber:[((NSMutableDictionary*)data) objectForKey:@"totalAmt"]] stringByAppendingString:@"元"];
    }else  if (code==GET_ACC_INCOME_TOTAL_OF_REPAY) {
        self.lblRepay.text = [[[Utils nf2] stringFromNumber:[((NSMutableDictionary*)data) objectForKey:@"totalAmt"]] stringByAppendingString:@"元"];
    }else  if (code==GET_ACC_INCOME_TOTAL_OF_BONUS) {
        self.lblBonus.text = [[[Utils nf2] stringFromNumber:[((NSMutableDictionary*)data) objectForKey:@"totalAmt"]] stringByAppendingString:@"元"];
    }else  if (code==GET_ACC_INCOME_TOTAL_OF_EXPENDITURE) {
        self.lblPay.text = [[[Utils nf2] stringFromNumber:[((NSMutableDictionary*)data) objectForKey:@"totalAmt"]] stringByAppendingString:@"元"];
    }
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    UIView *singleTapView = [sender view];
    
    IncomeController *controller = (IncomeController *)[Utils getControllerFromStoryboard:@"IncomeVC"];
    incomeType = singleTapView.tag;
    [self presentViewController:controller animated:NO completion:nil];
}

@end
