//
//  DLPanableWebView.h
//  banhuiton
//
//  Created by ym.sun on 16/12/7.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@class DLPanableWebView;

@protocol DLPanableWebViewHandler <NSObject>
@optional
- (void)DLPanableWebView:(DLPanableWebView *)webView panPopGesture:(UIPanGestureRecognizer *)pan;
@end

@interface DLPanableWebView : UIWebView
@property(nonatomic, weak) IBOutlet id<DLPanableWebViewHandler> panDelegate;
@property(nonatomic, assign) BOOL enablePanGesture;
@end
