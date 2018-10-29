//
//  TimerApplication.m
//  banhuiton
//
//  Created by ym.sun on 17/2/14.
//  Copyright © 2017年 banbank. All rights reserved.
//

#import "TimerApplication.h"
#import "Constants.h"

@implementation TimerApplication

- (void) sendEvent:(UIEvent *)event {
    [super sendEvent:event] ;
    
    if (!self.Timer) {
        [self resetTimer] ;
    }
    
    NSSet *allTouches = [event allTouches] ;
    
    if ([allTouches count] > 0) {
        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase ;
        if (phase == UITouchPhaseBegan) {
            [self resetTimer] ;
        }
    }
}

- (void)resetTimer {
    if (self.Timer) {
        [self.Timer invalidate] ;
    }
    self.Timer = [NSTimer scheduledTimerWithTimeInterval: TIMER target:self selector:@selector(notifyToAction) userInfo:nil repeats:NO] ;
}

- (void)notifyToAction {
    NSLog(@"==***=notifyToAction=***==") ;
    [[NSNotificationCenter defaultCenter] postNotificationName: CLEAR_CACHE object:nil] ;
}

@end
