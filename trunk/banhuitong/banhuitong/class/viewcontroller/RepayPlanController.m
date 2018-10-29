//
//  RepayPlanController.m
//  banhuitong
//
//  Created by 陈鲁 on 16/1/9.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "RepayPlanController.h"

@interface RepayPlanController (){

    NSMutableDictionary *_eventsByDate;
    NSDate *_dateSelected;
    int page;
}
@end

@implementation RepayPlanController

- (void)viewDidAppear:(BOOL)animated;
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    [self showHeader2:@"还款日历"];
    
    [self.srvMain setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*1.2)];
    
    ColumnChartView *ccv = [[ColumnChartView alloc] initWithFrame:CGRectMake(0, 0, CHART_MARGIN + COLUMN_UNIT_WIDTH*(self.dicSumOfMonth.count), SCROLL_VIEW_HEIGHT)];
    [ccv setSumOfMonth:self.dicSumOfMonth];
    [self.srvColumnChart setContentSize:CGSizeMake(CHART_MARGIN + COLUMN_UNIT_WIDTH*(self.dicSumOfMonth.count), SCROLL_VIEW_HEIGHT)];
    self.srvColumnChart.showsVerticalScrollIndicator = NO;
    self.srvColumnChart.showsHorizontalScrollIndicator = NO;
    [self.srvColumnChart addSubview:ccv];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btnShift
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.layer1
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:250]];
}

- (void)viewWillDisappear:(BOOL)animated;
{
    [super viewWillDisappear:animated];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(!self){
        return nil;
    }
    
    self.title = @"Vertical";
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _unpaidList = [[CacheObject sharedInstance].survey objectForKey:@"preReceiveAmtList"];
    
    [self doMyInit];
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    _calendarManager.settings.pageViewHaveWeekDaysView = NO;
    _calendarManager.settings.pageViewNumberOfWeeks = 0;
    _calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
    
    _weekDayView.manager = _calendarManager;
    [_weekDayView reload];
    
    [self createRandomEvents];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    
    _calendarMenuView.scrollView.scrollEnabled = NO;
    
    if (SCREEN_HEIGHT<IPHONE_5_HEIGHT) {
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.vCalendar
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:0.4
                                                               constant:0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.layer1
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:0.08
                                                               constant:0]];
    }
}

- (void) dealloc{
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    dayView.hidden = NO;
    
    // Hide if from another month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
        
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        //        dayView.dotView.hidden = NO;
        
        dayView.dotView.hidden = YES;
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = MYCOLOR_DARK_GREEN;
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    else{
        dayView.dotView.hidden = YES;
    }
    
    // Selected date
    if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        // Today
        if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
            dayView.circleView.hidden = NO;
            dayView.circleView.backgroundColor = [UIColor blueColor];
            dayView.dotView.backgroundColor = [UIColor whiteColor];
            dayView.textLabel.textColor = [UIColor whiteColor];
        }else{
            dayView.circleView.hidden = NO;
            dayView.circleView.backgroundColor = [UIColor redColor];
            dayView.dotView.backgroundColor = [UIColor whiteColor];
            dayView.textLabel.textColor = [UIColor whiteColor];
        }
    }
    
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }

}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    // Load the previous or next page if touch a day from another month
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
    
    self.lblThisDayUnpaid.text = [[[Utils nf2] stringFromNumber:[self getThisDayUnpaid]] stringByAppendingString:@"元"];
    self.lblByThisDayUnpaid.text = [[[Utils nf2] stringFromNumber:[self getByThisDayUnpaid]] stringByAppendingString:@"元"];
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[Utils df] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}

- (void)createRandomEvents
{
    _eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i<_unpaidList.count; ++i){
        
        NSTimeInterval dueTimeInterval = [[NSString stringWithFormat:@"%@",[[_unpaidList objectAtIndex:i] objectForKey:@"dueTime"]] longLongValue]/1000;
        
        NSDate *dueTime = [NSDate dateWithTimeIntervalSince1970: dueTimeInterval];

        // Use the date as key for eventsByDate
        NSString *key = [[Utils df] stringFromDate:dueTime];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:dueTime];
    }
}

- (NSDecimalNumber*) getThisDayUnpaid{
    NSDecimalNumber *thisDayUnpaid = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    if (_dateSelected==nil) {
        _dateSelected = [NSDate date];
    }
    
    for(int i = 0; i<_unpaidList.count; ++i){
        
        NSTimeInterval dueTimeInterval = [[NSString stringWithFormat:@"%@",[[_unpaidList objectAtIndex:i]  objectForKey:@"dueTime"]] longLongValue]/1000;
        
        NSDate *dueTime = [NSDate dateWithTimeIntervalSince1970: dueTimeInterval];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
        
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:_dateSelected];
        NSInteger year = [dateComponent year];
        NSInteger month = [dateComponent month];
        NSInteger day = [dateComponent day];
        
        NSDateComponents *dateComponent2 = [calendar components:unitFlags fromDate:dueTime];
        NSInteger year2 = [dateComponent2 year];
        NSInteger month2 = [dateComponent2 month];
        NSInteger day2 = [dateComponent2 day];
        
        if (year==year2 && month==month2 && day==day2) {
            
            NSDecimalNumber *amt = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[[_unpaidList objectAtIndex:i] objectForKey:@"amt"]]];
            
            thisDayUnpaid = [thisDayUnpaid decimalNumberByAdding:amt];
        }
        
    }
    return thisDayUnpaid;
}

- (NSDecimalNumber*) getByThisDayUnpaid{
    NSDecimalNumber *thisByDayUnpaid = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    if (_dateSelected==nil) {
        _dateSelected = [NSDate date];
    }
    
    _unpaidListSelected = [[NSMutableArray alloc] init];
    
    for(int i = 0; i<_unpaidList.count; ++i){
        
        NSTimeInterval dueTimeInterval = [[NSString stringWithFormat:@"%@",[[_unpaidList objectAtIndex:i]  objectForKey:@"dueTime"]] longLongValue]/1000;
        
        NSDate *dueTime = [NSDate dateWithTimeIntervalSince1970: dueTimeInterval];
        
        unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSCalendar *cal = [NSCalendar currentCalendar];
        
        NSDateComponents *dateComponent = [cal components:unitFlags fromDate:dueTime];
        [dateComponent setHour:0];
        [dateComponent setMinute:0];
        [dateComponent setSecond:0];
        
        NSDate* date= [cal dateFromComponents:dateComponent];
        
        if ([date compare:_dateSelected]<NSOrderedDescending) {
            
            [_unpaidListSelected addObject:[_unpaidList objectAtIndex:i]];
            
            NSDecimalNumber *amt = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[[_unpaidList objectAtIndex:i] objectForKey:@"amt"]]];
            
            thisByDayUnpaid = [thisByDayUnpaid decimalNumberByAdding:amt];
        }
        
    }
    
    UITableView *tableView = (UITableView *)[self.view viewWithTag:123];
    [tableView reloadData];
    
    return thisByDayUnpaid;
}

-(NSMutableDictionary*) getSumOfMonth:(NSMutableArray*) list{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    for(int i = 0; i<list.count; ++i){
        NSTimeInterval dueTimeInterval = [[NSString stringWithFormat:@"%@",[[list objectAtIndex:i]  objectForKey:@"dueTime"]] longLongValue]/1000;
        
        NSDate *dueTime = [NSDate dateWithTimeIntervalSince1970: dueTimeInterval];
        
        unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSCalendar *cal = [NSCalendar currentCalendar];
        
        NSDateComponents *dateComponent = [cal components:unitFlags fromDate:dueTime];
        long year = [dateComponent year];
        long month = [dateComponent month];
        NSString *key = month>9?[NSString stringWithFormat:@"%ld/%ld", year, month]:[NSString stringWithFormat:@"%ld/0%ld", year, month];
        NSString *value = [NSString stringWithFormat:@"%@",[[list objectAtIndex:i] objectForKey:@"amt"]];
        
        if([[dic allKeys] containsObject:key]){
            NSDecimalNumber *amt = [dic objectForKey:key];
            amt = [amt decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:value]];
            [dic setObject:amt forKey:key];
        }else{
            [dic setObject:[NSDecimalNumber decimalNumberWithString:value] forKey:key];
        }
    }
    return dic;
}

-(void) doMyInit{
    NSDecimalNumber *unpaidByThisDay = [NSDecimalNumber decimalNumberWithString:@"0"];
    for(int i = 0; i<_unpaidList.count; ++i){
        NSDecimalNumber *amt = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[[_unpaidList objectAtIndex:i] objectForKey:@"amt"]]];
        unpaidByThisDay = [unpaidByThisDay decimalNumberByAdding:amt];
    }
    
    self.lblThisDayUnpaid.text = [[[Utils nf2] stringFromNumber:[self getThisDayUnpaid]] stringByAppendingString:@"元"];
    self.lblByThisDayUnpaid.text = [[[Utils nf2] stringFromNumber:unpaidByThisDay] stringByAppendingString:@"元"];
    
    _unpaidListSelected = _unpaidList;
    
    MyView *v = [[MyView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, 6, 100, 30)];
    [self.layer1 addSubview:v];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, self.btnShift.frame.origin.y+20)];
    tableView.tag = 123;
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.hidden = YES;
    page = 1;
    [self.view addSubview:tableView];
    
    self.dicSumOfMonth = [self getSumOfMonth:self.unpaidList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _unpaidListSelected.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepayPlanTableViewCell *cell;
    NSString *IdentifierCell = @"RepayPlanTableViewCell";

    cell = (RepayPlanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RepayPlanTableViewCell" owner:self options:nil];
        cell = [nib lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSMutableDictionary *info = [_unpaidListSelected objectAtIndex:indexPath.row];
    
    if (indexPath.row>0) {
        //
        NSTimeInterval dueTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"dueTime"]] longLongValue]/1000;
        
        NSDate *dueTime = [NSDate dateWithTimeIntervalSince1970: dueTimeInterval];
        NSString *strDueTimeCurrent = [[Utils df] stringFromDate:dueTime];
        
        //
        NSMutableDictionary *infoLast = [_unpaidListSelected objectAtIndex:indexPath.row-1];
        
        NSTimeInterval dueTimeInterval2 = [[NSString stringWithFormat:@"%@",[infoLast objectForKey:@"dueTime"]] longLongValue]/1000;
        
        NSDate *dueTime2 = [NSDate dateWithTimeIntervalSince1970: dueTimeInterval2];
        NSString *strDueTimeLast = [[Utils df] stringFromDate:dueTime2];
        
        if ([strDueTimeCurrent isEqualToString:strDueTimeLast]) {
            cell.lblDatepoint.text = @"";
        }else{
            NSTimeInterval dueTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"dueTime"]] longLongValue]/1000;
            NSDate *dueTime = [NSDate dateWithTimeIntervalSince1970: dueTimeInterval];
            NSString *strDueTime = [[Utils df] stringFromDate:dueTime];
            cell.lblDatepoint.text = strDueTime;
        }
    }else{
        
        NSTimeInterval dueTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"dueTime"]] longLongValue]/1000;
        NSDate *dueTime = [NSDate dateWithTimeIntervalSince1970: dueTimeInterval];
        NSString *strDueTime = [[Utils df] stringFromDate:dueTime];
        cell.lblDatepoint.text = strDueTime;
    }

   
    cell.lblItemShowName.text = [NSString stringWithFormat:@"%@",[info objectForKey:@"itemShowName"]];
    
    id p1 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"amt"]]];
    id p2 = [[NSDecimalNumber alloc] initWithString:@"10000"];
    if ([p1 compare:p2]>=NSOrderedSame) {
        cell.lblAmt.text = [[[Utils nf2] stringFromNumber:[p1 decimalNumberByDividingBy:p2]] stringByAppendingString:@"万元"];
    }else{
        cell.lblAmt.text = [[[Utils nf2] stringFromNumber:p1] stringByAppendingString:@"元"];
    }
    
    NSDictionary *bonusType = [Utils getBonusType];
    NSString *str = [bonusType objectForKey:[NSString stringWithFormat:@"%@", [info objectForKey:@"tranType"]]];
    
    NSString *stringToShow = str;
    int lines = 1;
    if ([str containsString:@"\r"]) {
        lines = 2;
        NSRange range = [str rangeOfString:@"\r"];
        stringToShow = [str substringToIndex:NSMaxRange(range)];
    }
    
    cell.lblTranType = [[UILabel alloc] initWithFrame:CGRectMake(cell.lblItemShowName.frame.origin.x, cell.lblItemShowName.frame.origin.y + 25, stringToShow.length*14, 20*lines)];
    cell.lblTranType.font = [UIFont boldSystemFontOfSize:14];
    cell.lblTranType.numberOfLines = 0;
    cell.lblTranType.textColor = [UIColor whiteColor];
    cell.lblTranType.textAlignment = NSTextAlignmentCenter;
    [cell.lblTranType setBackgroundColor:MYCOLOR_DARK_RED];
    cell.lblTranType.layer.cornerRadius = 5;
    cell.lblTranType.clipsToBounds = YES;
    cell.lblTranType.text = str;
    [cell.contentView addSubview:cell.lblTranType];

    return cell;
}

- (IBAction)showUnpaidList:(id)sender {
    UITableView *tableView = (UITableView *)[self.view viewWithTag:123];
    if (page==1) {
        tableView.hidden = NO;
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        animation.fromValue=[NSNumber numberWithFloat:SCREEN_WIDTH*(-1)];
        animation.toValue=0;
        animation.duration=0.5;                    // 动画持续时间
        animation.removedOnCompletion=NO;
        animation.fillMode=kCAFillModeForwards;
        animation.delegate = self;
        page=2;
        [tableView.layer addAnimation:animation forKey:nil];
        [self.btnShift setTitle:@"返回还款日历" forState:UIControlStateNormal];
    }else{
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        animation.fromValue=0;
        animation.toValue=[NSNumber numberWithFloat:SCREEN_WIDTH*(-1)];
        animation.duration=0.5;                    // 动画持续时间
        animation.removedOnCompletion=NO;
        animation.fillMode=kCAFillModeForwards;
        animation.delegate = self;
        [animation setValue:@"backPage1" forKey:@"key1"];
        page=1;
        [tableView.layer addAnimation:animation  forKey:@"key1"];
        [self.btnShift setTitle:@"查看截止当日预计待收" forState:UIControlStateNormal];
    }
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)finished
{
    if (finished)
    {
        NSString *animationName = [animation valueForKey:@"key1"];
        if ([animationName isEqualToString:@"backPage1"])
        {
            UITableView *tableView = (UITableView *)[self.view viewWithTag:123];
            tableView.hidden = YES;
        }  
    }  
}

@end

