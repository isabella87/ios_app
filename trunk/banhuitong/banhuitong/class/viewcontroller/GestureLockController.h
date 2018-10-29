//
//  GestureLockController.h
//  banhuitong
//
//  Created by user on 16/6/8.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "GestureLockView.h"
#import "GestureListenDelegate.h"
#import "CustomTabBarViewController.h"
#import "Utils.h"

@interface GestureLockController : BaseViewController<GestureListenDelegate>

@property(nonatomic) GestureLockView *gestureLockView;
@property (strong, nonatomic) IBOutlet UIImageView *imgLogo;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property(nonatomic)NSString *inputFirst;
@property(nonatomic)int opt;

@end
