//
//  MyView2.m
//  banhuitong
//
//  Created by user on 16-1-11.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "MyView2.h"

@implementation MyView2

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
    
    //竖线
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 8);  //线宽
    CGContextSetAllowsAntialiasing(ctx, true);
    CGContextSetRGBStrokeColor(ctx, 0xB2/255.0, 0x22/255.0, 0x2/255.0, 1);  //线的颜色
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 10, 0);  //起点坐标
    CGContextAddLineToPoint(ctx, 10, 100);   //终点坐标
    CGContextStrokePath(ctx);

    //大圆
    CGContextSetRGBStrokeColor(ctx, 0xB2/255.0, 0x22/255.0, 0x2/255.0, 1);
    CGContextAddEllipseInRect(ctx, CGRectMake(5, 15, 10, 10));
    CGContextSetLineWidth(ctx, 10);
    CGContextStrokePath(ctx);
    //小圆
    CGContextSetRGBStrokeColor(ctx, 0xFF/255.0, 0xFF/255.0, 0xFF/255.0, 1);
    CGContextAddEllipseInRect(ctx, CGRectMake(7.5, 17.5, 5, 5));
    CGContextSetLineWidth(ctx, 5);
    CGContextStrokePath(ctx);
    
}

@end
