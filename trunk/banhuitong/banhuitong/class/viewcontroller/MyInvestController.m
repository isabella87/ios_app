//
//  MyInvestController.m
//  banhuitong
//
//  Created by user on 16-1-6.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "MyInvestController.h"

@interface MyInvestController ()

@end

@implementation MyInvestController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showHeader2:@"出借管理"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.layerZhuan setHidden:YES];
    
    self.moveView = [[MoveView alloc]initWithFrame:CGRectMake(0, self.layerGong.frame.origin.y + self.layerGong.frame.size.height + 6, SCREEN_WIDTH
                                                              , SCREEN_HEIGHT - self.layerGong.frame.origin.y - self.layerGong.frame.size.height)];

    [self.view addSubview:self.moveView];
    
    self.layerGong.tag = 1;
    self.layerBao.tag = 2;
    self.layerZhuan.tag =3;
    self.moveView.tag =4;
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap2.delegate = self;
    singleTap2.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap3.delegate = self;
    singleTap3.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap4.delegate = self;
    singleTap4.cancelsTouchesInView = NO;


    [self.layerGong addGestureRecognizer:singleTap];
    [self.layerBao addGestureRecognizer:singleTap2];
    [self.layerZhuan addGestureRecognizer:singleTap3];
    [self.moveView addGestureRecognizer:singleTap4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc{
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    
    UIView *singleTapView = [sender view];
    long tag = singleTapView.tag;
    
    if (tag==1) {
        MyGongController *controller = (MyGongController *)[Utils getControllerFromStoryboard:@"MyGongVC"];
        [self presentViewController:controller animated:NO completion:nil];
        
    }else if (tag==2) {
        MyBaoController *controller = (MyBaoController *)[Utils getControllerFromStoryboard:@"MyBaoVC"];
        [self presentViewController:controller animated:NO completion:nil];
        
    }else if (tag==3) {
        MyZhuanController *controller = (MyZhuanController *)[Utils getControllerFromStoryboard:@"MyZhuanVC"];
        [self presentViewController:controller animated:NO completion:nil];
    }else if (tag==4) {
        if([self.moveView isClickZhuan]){
            MyZhuanController *controller = (MyZhuanController *)[Utils getControllerFromStoryboard:@"MyZhuanVC"];
            [self presentViewController:controller animated:NO completion:nil];
        }
    }
}

@end
