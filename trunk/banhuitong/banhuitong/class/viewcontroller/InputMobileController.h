//
//  InputMobileController.h
//  banhuitong
//
//  Created by 陈鲁 on 16/1/17.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "RegisterStep1Controller.h"
#import "IsRegisterOperation.h"

@interface InputMobileController : BaseViewController

@property (strong, nonatomic) IBOutlet UITextField *txtMobile;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;

@property(nonatomic)NSString* mobile;

- (IBAction)next:(id)sender;

@end
