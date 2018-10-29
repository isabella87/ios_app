//
//  ColumnChartView.m
//  banhuitong
//
//  Created by user on 16/6/20.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "ColumnChartView.h"

const int COLUMN_UNIT_WIDTH = 120;
const int COORDINATE_X_HEIGHT = 110;
const int SCROLL_VIEW_HEIGHT = 130;
const int CHART_MARGIN = 100;

int COLUMN_LINE_WIDTH = 60;

@implementation ColumnChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    self.backgroundColor = [UIColor whiteColor];
    
    self.dicSumMonthly = [[NSMutableDictionary alloc] init];

    return self;
}

-(void) setSumOfMonth:(NSMutableDictionary*) dic{
    self.dicSumMonthly = dic;
    self.keysSorted = [[self.dicSumMonthly allKeys] mutableCopy];
    [self.keysSorted sortUsingComparator: ^NSComparisonResult (NSString *str1, NSString *str2) {
        return [str1 compare:str2];
    }];
    
    self.maxAmt = 0;
    for(int i=0;i<self.dicSumMonthly.count;i++){
        double curAmt =  [(NSDecimalNumber*)[self.dicSumMonthly objectForKey:[self.keysSorted objectAtIndex:i]] doubleValue];
        if(curAmt>self.maxAmt){
            self.maxAmt = curAmt;
        }
    }
    self.ratio = SCROLL_VIEW_HEIGHT*0.666666/self.maxAmt;
}

- (void)drawRect:(CGRect)rect {

    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIFont  *font = [UIFont boldSystemFontOfSize:14.0];
    
    //柱状
    CGContextSetRGBStrokeColor(ctx, 0xB2/255.0, 0x22/255.0, 0x22/255.0, 1);
    for(int i=0;i<self.keysSorted.count;i++){
        CGContextSetLineWidth(ctx, COLUMN_LINE_WIDTH);  //线宽
        CGContextMoveToPoint(ctx, CHART_MARGIN + i*COLUMN_UNIT_WIDTH , COORDINATE_X_HEIGHT);  //起点坐标
        CGContextAddLineToPoint(ctx, CHART_MARGIN + i*COLUMN_UNIT_WIDTH, COORDINATE_X_HEIGHT - [(NSDecimalNumber*)[self.dicSumMonthly objectForKey:[self.keysSorted objectAtIndex:i]] doubleValue]*self.ratio);   //终点坐标
        CGContextStrokePath(ctx);
    }
    
    //X轴
    CGContextSetLineWidth(ctx, 3);  //线宽
    CGContextSetRGBStrokeColor(ctx, 0x00/255.0, 0x00/255.0, 0x00/255.0, 1);  //线的颜色
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, COORDINATE_X_HEIGHT);  //起点坐标
    CGContextAddLineToPoint(ctx, CHART_MARGIN +COLUMN_UNIT_WIDTH*(self.dicSumMonthly.count), COORDINATE_X_HEIGHT);   //终点坐标
    CGContextStrokePath(ctx);
    
    //月份
    for(int i=0;i<self.keysSorted.count;i++){
        [(NSString*)[self.keysSorted objectAtIndex:i] drawInRect:CGRectMake(CHART_MARGIN + i*COLUMN_UNIT_WIDTH - COLUMN_LINE_WIDTH*0.5, COORDINATE_X_HEIGHT, 100, 30) withFont:font];
    }
    
    CGContextSetRGBFillColor(ctx, 0x00/255.0, 0x64/255.0, 0x00/255.0, 1);
    [@"单位(元)" drawInRect:CGRectMake(0, 0, 100, 30) withFont:font];
    
    //每月金额
    for(int i=0;i<self.keysSorted.count;i++){
        [[[Utils nf2] stringFromNumber:(NSDecimalNumber*)[self.dicSumMonthly objectForKey:[self.keysSorted objectAtIndex:i]] ]  drawInRect:CGRectMake(CHART_MARGIN + i*COLUMN_UNIT_WIDTH - COLUMN_LINE_WIDTH*0.5, COORDINATE_X_HEIGHT - [(NSDecimalNumber*)[self.dicSumMonthly objectForKey:[self.keysSorted objectAtIndex:i]] doubleValue]*self.ratio - 20, COLUMN_UNIT_WIDTH, 30) withFont:font];
    }
}

@end
