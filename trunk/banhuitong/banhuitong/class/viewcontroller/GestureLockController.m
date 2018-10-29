//
//  GestureLockController.m
//  banhuitong
//
//  Created by user on 16/6/8.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "GestureLockController.h"

@interface GestureLockController ()

@end

@implementation GestureLockController

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    
    switch (self.opt) {
        case GESTURE_LOCK_OPT_CREATE:
            [self showHeader2:@"创建手势密码"];
            break;
        case GESTURE_LOCK_OPT_DELETE:
            [self showHeader2:@"取消手势密码"];
            break;
        case GESTURE_LOCK_OPT_UPDATE:
            [self showHeader2:@"修改手势密码"];
            break;
        case GESTURE_LOCK_OPT_CHECK:
            [self showHeader2:@"验证手势密码"];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gesture.png"]];
    
    self.gestureLockView = [[GestureLockView alloc]initWithFrame:CGRectMake(0, self.imgLogo.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - self.headerView.frame.size.height - self.imgLogo.frame.size.height)];
    [self.mainView addSubview:self.gestureLockView];
    
    self.gestureLockView.gestureListenDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onMoveEnd:(NSString*)lock{
    NSString *lockSaved;
    
    switch (self.opt) {
        case GESTURE_LOCK_OPT_CREATE:
            if ([@"" isEqualToString:self.inputFirst] || self.inputFirst==nil) {
                if(lock.length<4){
                    [Utils showMessage:@"长度不能小于4！"];
                }else{
                    self.inputFirst = lock;
                    [Utils showMessage:@"请再输入一次"];
                }
            }else{
                if (![self.inputFirst isEqualToString:lock]) {
                    [Utils showMessage:@"输入错误！"];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:lock forKey:GESTURE_LOCK];
                    [Utils showMessage:@"输入正确"];
                    [self onBackAction];
                }
            }
            break;
        case GESTURE_LOCK_OPT_DELETE:
            lockSaved = [[NSUserDefaults standardUserDefaults] objectForKey:GESTURE_LOCK];
            if ([lockSaved isEqualToString:lock]) {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:GESTURE_LOCK];
                [Utils showMessage:@"输入正确"];
                [self onBackAction];
            }else{
                [Utils showMessage:@"输入错误！"];
            }

            break;
        case GESTURE_LOCK_OPT_UPDATE:
            lockSaved = [[NSUserDefaults standardUserDefaults] objectForKey:GESTURE_LOCK];
            if (![lockSaved isEqualToString:lock]) {
                [Utils showMessage:@"输入错误！"];
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:lock forKey:GESTURE_LOCK];
                [Utils showMessage:@"输入正确"];
                [self dismissViewControllerAnimated:YES completion:^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_CREATE_GESTURE_LOCK object:nil userInfo:nil];
                }];
            }
            break;
        case GESTURE_LOCK_OPT_CHECK:
            [self showHeader2:@"验证手势密码"];
            lockSaved = [[NSUserDefaults standardUserDefaults] objectForKey:GESTURE_LOCK];
            if (![lockSaved isEqualToString:lock]) {
                [Utils showMessage:@"输入错误！"];
            }else{
                [Utils showMessage:@"输入正确"];
                [AppDelegate setGesturePassed:YES];
                [self dismissViewControllerAnimated:NO completion:^{
                    
                }];
            }
            break;
        default:
            break;
    }
    [self.gestureLockView clean];
}

- (void) onBackAction
{
    switch (self.opt) {
        case GESTURE_LOCK_OPT_CHECK:
            [self exitApplication];
            break;
        default:
            [super onBackAction];
            break;
    }
}

@end
