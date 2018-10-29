//
//  MoveView.m
//  banhuitong
//
//  Created by user on 16/5/20.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "MoveView.h"

@implementation MoveView

int moveY = 0, downY = 0;
bool clickZhuan = false;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    [self addGestureRecognizer:longPressGr];
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat leftMargin = 10;
    CGFloat rightMargin = 10;
    CGFloat topMargin = 10;
    
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //白色背景
    CGContextSetRGBFillColor (ctx, 0xff/255.0, 0xff/255.0, 0xff/255.0, 1);
    CGContextFillRect(ctx, CGRectMake(0, moveY, SCREEN_WIDTH, 50));
    CGContextStrokePath(ctx);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"icon_invest_zhuan@2x" ofType:@"png"];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    
    UIGraphicsPushContext(ctx);
    [img drawInRect:CGRectMake(leftMargin, topMargin + moveY, img.size.width, img.size.height)];
    UIGraphicsPopContext();
    
    path = [[NSBundle mainBundle] pathForResource:@"arrow" ofType:@"png"];
    img = [UIImage imageWithContentsOfFile:path];
    CGImageRef image = img.CGImage;
    CGContextSaveGState(ctx);
    CGRect touchRect = CGRectMake(SCREEN_WIDTH - rightMargin - img.size.width, topMargin + moveY + 5, img.size.width, img.size.height);
    CGContextDrawImage(ctx, touchRect, image);
    CGContextRestoreGState(ctx);
    
    CGContextSetLineWidth(ctx, 1.0);
    CGContextSetRGBFillColor (ctx, 0x00/255.0, 0x00/255.0, 0x00/255.0, 1);
    UIFont  *font = [UIFont boldSystemFontOfSize:14.0];
    [@"债权转让" drawInRect:CGRectMake(leftMargin + 35, topMargin + moveY + 5, 100, 30) withFont:font];
}

#pragma mark - touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    downY = point.y;
    if(downY >= moveY && downY <= moveY + 50){
        clickZhuan = YES;
    }else{
        clickZhuan = NO;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch  locationInView:self];
//    moveY = point.y;
    [self setNeedsDisplay];
}

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {

    }
}

-(bool) isClickZhuan{
    return clickZhuan;
}

@end
