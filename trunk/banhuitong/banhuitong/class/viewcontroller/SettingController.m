//
//  SettingController.m
//  banhuitong
//
//  Created by user on 16/6/8.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "SettingController.h"

@interface SettingController ()

@end

@implementation SettingController

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    [self showHeader2:@"设置"];
    
    if ([AppDelegate hasGestureLock]) {
        [self.vGestureLockEdit setHidden:NO];
        [self.imgGesture setImage:[UIImage imageNamed:@"switch_on.png"]];
    }else{
        [self.vGestureLockEdit setHidden:YES];
        [self.imgGesture setImage:[UIImage imageNamed:@"switch_off.png"]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createGesture) name:NOTIFY_CREATE_GESTURE_LOCK object:nil];
    
    self.vGestureLock.tag = 1;
    self.vGestureLockEdit.tag = 2;
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap2.delegate = self;
    singleTap2.cancelsTouchesInView = NO;
    
    [self.vGestureLock addGestureRecognizer:singleTap];
    [self.vGestureLockEdit addGestureRecognizer:singleTap2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    
    UIView *singleTapView = [sender view];
    int tag = singleTapView.tag;
    
    if (tag==1) {
        if ([AppDelegate hasGestureLock]) {
            GestureLockController *controller = (GestureLockController *)[Utils getControllerFromStoryboard:@"GestureLockVC"];
            controller.opt = GESTURE_LOCK_OPT_DELETE;
            [self presentViewController:controller animated:NO completion:nil];
        }else{
            GestureLockController *controller = (GestureLockController *)[Utils getControllerFromStoryboard:@"GestureLockVC"];
            controller.opt = GESTURE_LOCK_OPT_CREATE;
            [self presentViewController:controller animated:NO completion:nil];
        }
    }else if (tag==2) {
        GestureLockController *controller = (GestureLockController *)[Utils getControllerFromStoryboard:@"GestureLockVC"];
        controller.opt = GESTURE_LOCK_OPT_UPDATE;
        [self presentViewController:controller animated:NO completion:nil];
    }
}

-(void)createGesture
{
    GestureLockController *controller = (GestureLockController *)[Utils getControllerFromStoryboard:@"GestureLockVC"];
    controller.opt = GESTURE_LOCK_OPT_CREATE;
    [self presentViewController:controller animated:NO completion:nil];
}

@end
