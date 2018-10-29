//
//  GestureLockView.h
//  banhuitong
//
//  Created by user on 16/6/8.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestureListenDelegate.h"

@interface GestureLockView : UIView

@property(nonatomic,strong)NSMutableArray *buttons;
@property(nonatomic,strong)NSString *lock;
@property(nonatomic)id<GestureListenDelegate> gestureListenDelegate;
@property(nonatomic)int lastX, lastY, curX, curY;

- (void)clean;

@end
