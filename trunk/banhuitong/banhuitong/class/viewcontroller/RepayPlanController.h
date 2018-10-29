//
//  RepayPlanController.h
//  banhuitong
//
//  Created by 陈鲁 on 16/1/9.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import "JTCalendar.h"
#import "CacheObject.h"
#import "MyView.h"
#import "RepayPlanTableViewCell.h"
#import "ColumnChartView.h"

@interface RepayPlanController : BaseViewController<JTCalendarDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *srvMain;

@property (strong, nonatomic) IBOutlet UIView *vCalendar;

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTCalendarWeekDayView *weekDayView;
@property (weak, nonatomic) IBOutlet JTVerticalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (strong, nonatomic) IBOutlet UIView *layer1;
@property (strong, nonatomic) IBOutlet UILabel *lblThisDayUnpaid;
@property (strong, nonatomic) IBOutlet UILabel *lblByThisDayUnpaid;
@property (strong, nonatomic) IBOutlet UIButton *btnShift;
@property NSMutableArray *unpaidList;
@property NSMutableArray *unpaidListSelected;
@property (strong, nonatomic) IBOutlet UIScrollView *srvColumnChart;
@property(nonatomic) NSMutableDictionary *dicSumOfMonth;

- (IBAction)showUnpaidList:(id)sender;

@end
