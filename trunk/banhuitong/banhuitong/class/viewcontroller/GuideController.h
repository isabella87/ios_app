//
//  GuideController.h
//  banhuitong
//
//  Created by 陈鲁 on 16/1/23.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "WelcomeController.h"

@interface GuideController : BaseViewController<UIScrollViewDelegate>

@property UIScrollView* scrView;
@property UIPageControl* pageCtrl;

@end
