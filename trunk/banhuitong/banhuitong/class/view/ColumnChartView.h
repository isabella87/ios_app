//
//  ColumnChartView.h
//  banhuitong
//
//  Created by user on 16/6/20.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"

extern const int COLUMN_UNIT_WIDTH;
extern const int COORDINATE_X_HEIGHT;
extern const int SCROLL_VIEW_HEIGHT;
extern const int CHART_MARGIN;

@interface ColumnChartView : UIView

@property NSMutableArray *selectedList, *keysSorted;
@property NSMutableDictionary *dicSumMonthly;
@property double ratio;
@property double maxAmt;

-(void) setSumOfMonth:(NSMutableDictionary*) dic;

@end
