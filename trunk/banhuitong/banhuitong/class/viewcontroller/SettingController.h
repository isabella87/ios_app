//
//  SettingController.h
//  banhuitong
//
//  Created by user on 16/6/8.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "GestureLockController.h"

@interface SettingController : BaseViewController

@property (strong, nonatomic) IBOutlet UIView *vGestureLock;
@property (strong, nonatomic) IBOutlet UIView *vGestureLockEdit;
@property (strong, nonatomic) IBOutlet UIImageView *imgGesture;

@end
