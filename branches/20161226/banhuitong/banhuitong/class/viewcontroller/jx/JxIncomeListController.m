//
//  IncomeListController.m
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "JxIncomeListController.h"

@implementation JxIncomeListController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showHeader2:@"收支明细"];
    [self myInit];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.layerIn.tag =1;
    self.layerOut.tag = 2;
    
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.singleTap .delegate = self;
    self.singleTap .cancelsTouchesInView = NO;
    
    self.singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.singleTap2 .delegate = self;
    self.singleTap2 .cancelsTouchesInView = NO;
    
    [self.layerIn addGestureRecognizer:self.singleTap];
    [self.layerOut addGestureRecognizer:self.singleTap2];
}

- (void) dealloc{
    self.singleTap.delegate = nil;
    self.singleTap2.delegate = nil;
}

-(void) myInit{
//    [self showActiveLoading];
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    UIView *singleTapView = [sender view];
    
    JxIncomeController *controller = (JxIncomeController *)[Utils getControllerFromStoryboard:@"IncomeVC"];
    controller.jxIncomeType = singleTapView.tag;
    [self presentViewController:controller animated:NO completion:nil];
}

@end
