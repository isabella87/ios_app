//
//  AboutController.m
//  banhuitong
//
//  Created by user on 16-1-13.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "AboutController.h"
#import "TestController.h"

@interface AboutController ()

@end

@implementation AboutController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader2:@"关于"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblVersion.text = [Utils getAppVersion];
    
    self.imgLocation.tag = 1;
    self.imgLocation.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    
    [self.imgLocation addGestureRecognizer:singleTap];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc{
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    
    UIView *singleTapView = [sender view];
    int tag = singleTapView.tag;
    
    if (tag==1) {
//        MapController* controller = [[MapController alloc] initWithNibName:@"MapController" bundle:nil];
//        [self presentViewController:controller animated:NO completion:nil];
    }
}

- (IBAction)doTest:(id)sender {
        TestController* controller = [[TestController alloc] initWithNibName:@"TestController" bundle:nil];
        [self presentViewController:controller animated:NO completion:nil];
}

@end
