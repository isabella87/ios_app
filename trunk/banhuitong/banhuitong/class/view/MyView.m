//
//  MyView.m
//  banhuitong
//
//  Created by 陈鲁 on 16/1/10.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置颜色
    CGContextSetRGBStrokeColor(ctx, 0x00/255.0, 0x64/255.0, 0x00/255.0, 1);
    // 2.画圆
    CGContextAddEllipseInRect(ctx, CGRectMake(5, 8, 10, 10));
    CGContextSetLineWidth(ctx, 10);
    
    // 3.显示所绘制的东西
    CGContextStrokePath(ctx);
    
    CGContextSetLineWidth(ctx, 1.0);
    CGContextSetRGBFillColor (ctx, 0x00/255.0, 0x00/255.0, 0x00/255.0, 1);
    UIFont  *font = [UIFont boldSystemFontOfSize:14.0];
    [@"还款日" drawInRect:CGRectMake(22, 4, 100, 30) withFont:font];
}

@end
