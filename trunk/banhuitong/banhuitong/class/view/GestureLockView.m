//
//  GestureLockView.m
//  banhuitong
//
//  Created by user on 16/6/8.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "GestureLockView.h"

@implementation GestureLockView

//界面搭建
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    
    self.buttons = [[NSMutableArray alloc] init];
    
    if (self) {
        [self setup];
    }
    return self;
}

//在界面上创建9个按钮
-(void)setup
{
    //1.创建9个按钮
    for (int i=0; i<9; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+1;
        //2.设置按钮的状态背景
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        //3.把按钮添加到视图中
        [self  addSubview:btn];
        //4.禁止按钮的点击事件
        btn.userInteractionEnabled=NO;
    }
}

//4.设置按钮的frame
-(void)layoutSubviews{
    //4.1需要先调用父类的方法
    [super layoutSubviews];
    
    for (int i=0; i<self.subviews.count; i++) {
        //4.2取出按钮
        UIButton *btn=self.subviews[i];
        
        //4.3九宫格法计算每个按钮的frame
        CGFloat row = i/3;
        CGFloat loc   = i%3;
        CGFloat btnW=44;
        CGFloat btnH=44;
        CGFloat padding=(self.frame.size.width-3*btnW)/4;
        CGFloat btnX=padding+(btnW+padding)*loc;
        CGFloat btnY=padding+(btnW+padding)*row;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
    }
}

//5.监听手指的移动
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self clean];
    CGPoint startPoint=[self getCurrentPoint:touches];
    UIButton *btn=[self getCurrentBtnWithPoint:startPoint];
    self.lastX = startPoint.x;
    self.lastY = startPoint.y;
    self.lock = @"";
    
    if (btn && btn.selected != YES) {
        btn.selected=YES;
        [self.buttons addObject:btn];
        self.lock = [NSString stringWithFormat:@"%ld", (long)btn.tag];
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint movePoint=[self getCurrentPoint:touches];
    UIButton *btn=[self getCurrentBtnWithPoint:movePoint];
    self.curX = movePoint.x;
    self.curY = movePoint.y;
    
    //存储按钮
    //已经连过的按钮，不可再连
    if (btn && btn.selected != YES) {
        //设置按钮的选中状态
        btn.selected=YES;
        //把按钮添加到数组中
        [self.buttons addObject:btn];
        
        self.lock = [self.lock stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)btn.tag]];
        
        self.lastX = btn.center.x;
        self.lastY = btn.center.y;
    }
    //通知view重新绘制
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.gestureListenDelegate onMoveEnd:_lock];
}

//对功能点进行封装
-(CGPoint)getCurrentPoint:(NSSet *)touches
{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:touch.view];
    return point;
}

-(UIButton *)getCurrentBtnWithPoint:(CGPoint)point
{
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return Nil;
}

//重写drawrect:方法
-(void)drawRect:(CGRect)rect{
    //获取上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //绘图（线段）
    for (int i=0; i<self.buttons.count; i++) {
        UIButton *btn=self.buttons[i];
        if (0==i) {
            //设置起点（注意连接的是中点）
            CGContextMoveToPoint(ctx, btn.center.x, btn.center.y);
        }else{
            CGContextAddLineToPoint(ctx, btn.center.x, btn.center.y);
        }
    }
    
    if(self.buttons.count > 0){
        CGContextMoveToPoint(ctx, self.lastX, self.lastY);
        CGContextAddLineToPoint(ctx, self.curX, self.curY);
    }
    
    //渲染
    //设置线条的属性
    CGContextSetLineWidth(ctx, 10);
    CGContextSetRGBStrokeColor(ctx, 0xFF/255.0, 0xFF/255.0, 0x00/255.0, 1);
    CGContextStrokePath(ctx);
}

- (void)clean{
    [self.buttons removeAllObjects];
    
    for (int i=0; i<self.subviews.count; i++) {
        UIButton *btn=self.subviews[i];
        btn.selected = NO;
    }
    
    [self setNeedsDisplay];
}

@end
