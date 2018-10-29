//
//  AboutController.h
//  banhuitong
//
//  Created by user on 16-1-13.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"

@interface AboutController : BaseViewController

@property (strong, nonatomic) IBOutlet UILabel *lblVersion;
@property (strong, nonatomic) IBOutlet UIImageView *imgLocation;
@property (strong, nonatomic) IBOutlet UIButton *btnCP;

- (IBAction)doTest:(id)sender;

@end
