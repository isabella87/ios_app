//
//  mainViewController.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/22.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()

@end

static int myTab;

@implementation MainViewController

+ (void) setTab:(int)tab{
    myTab = tab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backIndex:) name:NOTIFY_BACK_INDEX object:nil];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
    [self.segmentedControl removeSegmentAtIndex:1 animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc{
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader1];
    
    if (self.didLoad!=YES) {
        self.currentPage = 1;
        self.dataArray = [[NSMutableArray alloc] init];

        [self.segmentedControl setSelectedSegmentIndex:myTab==3?myTab-2:myTab-1];
        [self indexChanged:self.segmentedControl];
        self.didLoad = YES;
    }
    
    [AppDelegate setShareHiden:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma Mark - TableView DataSource Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (myTab) {
        case 1:
            return 170;
            break;
        default:
            return 150;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PrjEntTableViewCell *cell;
    PrjBhbTableViewCell *cell2;
    PrjCaTableViewCell *cell3;
    NSString *IdentifierCell;
    
    switch (myTab) {
        case 1:
            IdentifierCell = @"PrjEntTableViewCell";
            cell = (PrjEntTableViewCell *)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrjEntTableViewCell" owner:self options:nil];
                cell = [nib lastObject];
            }
            break;
        case 2:
            IdentifierCell = @"PrjBhbTableViewCell";
            cell2 = (PrjBhbTableViewCell *)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
            if (cell2 == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrjBhbTableViewCell" owner:self options:nil];
                cell2 = [nib lastObject];
            }
            break;
        case 3:
            IdentifierCell = @"PrjCaTableViewCell";
            cell3 = (PrjCaTableViewCell *)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrjCaTableViewCell" owner:self options:nil];
                cell3 = [nib lastObject];
            }
            break;
        default:
            break;
    }
    
    NSMutableDictionary *info = [self.dataArray objectAtIndex:indexPath.row];
    
    if (myTab==1) {
            cell.lblItemNo.text = [info objectForKey:@"itemNo"];
            cell.lblItemShowName.text = [info objectForKey:@"itemShowName"];
            cell.lblMoneyRate.text = [NSString stringWithFormat:@"%@%%", [info objectForKey:@"moneyRate"]];
            cell.lblBorrowDays.text = [NSString stringWithFormat:@"%@天", [info objectForKey:@"borrowDays"]];
            
            if ([[info objectForKey:@"flags"] intValue]==1) {
                cell.lblType.text = @"新";
                cell.lblType.backgroundColor = MYCOLOR_GREEN;
                [cell.imgSeal setImage:[UIImage imageNamed:@"seal.png"]];
                cell.imgSeal.contentMode = UIViewContentModeScaleAspectFit;
                [cell.imgSeal setHidden:NO];
            }else if([[info objectForKey:@"flags"] intValue]==32){
                cell.lblType.text = @"员";
                cell.lblType.backgroundColor = MYCOLOR_ORANGE;
            }else{
                if ([[info objectForKey:@"type"] intValue]==1) {
                    cell.lblType.text = @"工";
                    cell.lblType.backgroundColor = MYCOLOR_BLUE;
                }
                
                if ([[info objectForKey:@"flags"] intValue]==16) {
                    [cell.imgSeal setImage:[UIImage imageNamed:@"seal_prior.png"]];
                    cell.imgSeal.contentMode = UIViewContentModeScaleAspectFit;
                    [cell.imgSeal setHidden:NO];
                }else if([[info objectForKey:@"waterMark"] isEqualToString:@"guoqing_biao"]){
                    [cell.imgSeal setImage:[UIImage imageNamed:@"seal_guoqing.png"]];
                    cell.imgSeal.contentMode = UIViewContentModeScaleAspectFit;
                    [cell.imgSeal setHidden:NO];
                }
            }
            
            long status = [[info objectForKey:@"status"] intValue];
            
            if(status>=1 && status<=30){
                cell.btnToInvest.text = @"即将发布";
                cell.btnToInvest.backgroundColor = MYCOLOR_LIGHT_BLUE;
            }else if(status==40){
                cell.btnToInvest.text = @"我要出借";
                cell.btnToInvest.backgroundColor = MYCOLOR_DARK_RED;
            }else if(status==50 || status==60 || status==70){
                cell.btnToInvest.text = @"满标";
                cell.btnToInvest.backgroundColor = MYCOLOR_GRAY;
            }else if(status==80||status==90){
                cell.btnToInvest.text = @"还款中";;
                cell.btnToInvest.backgroundColor = MYCOLOR_GRAY;
            }else if(status==999){
                cell.btnToInvest.text = @"已结清";
                cell.btnToInvest.backgroundColor = MYCOLOR_GRAY;
            }else if(status==-1){
                cell.btnToInvest.text = @"流标";
                cell.btnToInvest.backgroundColor = MYCOLOR_GRAY;
            }
            
            cell.lbldaysLeft.textColor = MYCOLOR_GREEN;

            if(status==RAISING){
                
                NSTimeInterval financingEndTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"financingEndTime"]] longLongValue]/1000;
                
                NSDate *financingEndTimeDate = [NSDate dateWithTimeIntervalSince1970: financingEndTimeInterval];
                
                long financingEndTime = [financingEndTimeDate timeIntervalSince1970];
                long today = [[NSDate date] timeIntervalSince1970];
                
                long dayDiff = (financingEndTime - today) / (24 * 60 * 60);
                
                if(dayDiff<0){
                    cell.lbldaysLeft.text = @"已截止";
                    cell.lbldaysLeft.textColor = MYCOLOR_DARK_RED;
                }else{
                    long daysRemaining = dayDiff>0?dayDiff:1;
                    cell.lbldaysLeft.text = [NSString stringWithFormat:@"%ld%@", daysRemaining, @"天"];
                    cell.lbldaysLeft.textColor = MYCOLOR_DARK_GREEN;
                }
            }else{
                cell.lbldaysLeft.text = @"";
            }
        
            NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
               scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
        
            if ([NSString stringWithFormat:@"%@", [info objectForKey:@"investedMoney"]]==nil || [NSString stringWithFormat:@"%@", [info objectForKey:@"amt"]]==nil) {
                cell.pv.percent = 0;
            }else{
                NSDecimalNumber *investedMoney = [NSDecimalNumber decimalNumberWithString:  [NSString stringWithFormat:@"%@", [info objectForKey:@"investedMoney"]]];
                NSDecimalNumber *amt = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", [info objectForKey:@"amt"]]];
                float progress = [[investedMoney decimalNumberByDividingBy:amt withBehavior:roundDown] floatValue];
                cell.pv.percent = progress;
            }
        
    }else if (myTab==2){
            cell2.lblNameOfTargetRate.lineBreakMode =UILineBreakModeWordWrap;
            cell2.lblNameOfTargetRate.numberOfLines = 0;
            cell2.lblNameOfTargetRate.text = @"整体目标\r年化收益";
            
            cell2.lblItemNo.text = [info objectForKey:@"itemNo"];
            cell2.lblItemShowName.text = [info objectForKey:@"itemShowName"];
            cell2.lblTargetRate.text = [NSString stringWithFormat:@"%@%%", [info objectForKey:@"targetRate"]];
            cell2.lblBorrowDays.text = [NSString stringWithFormat:@"%@天",[info objectForKey:@"borrowDays"]];
            cell2.lblType.text = @"宝";
            cell2.lblType.backgroundColor = MYCOLOR_BLUE;
            
            switch ([[info objectForKey:@"status"] intValue]) {
                case 1:
                    cell2.btnToInvest.text = @"了解详情";
                    cell2.btnToInvest.backgroundColor = MYCOLOR_DARK_GREEN;
                    cell2.lblStatus.text = @"预告";
                    cell2.lblStatus.backgroundColor = MYCOLOR_DARK_GREEN;
                    break;
                case 2:
                    cell2.btnToInvest.text = @"我要加入";
                    cell2.btnToInvest.backgroundColor = MYCOLOR_DARK_RED;
                    cell2.lblStatus.text = @"开放";
                    cell2.lblStatus.backgroundColor = MYCOLOR_DARK_RED;
                    break;
                case 3:
                    cell2.btnToInvest.text = @"了解详情";
                    cell2.btnToInvest.backgroundColor = MYCOLOR_LIGHT_BLUE;
                    cell2.lblStatus.text = @"存续";
                    cell2.lblStatus.backgroundColor = MYCOLOR_LIGHT_BLUE;
                    break;
                case 4:
                    cell2.btnToInvest.text = @"了解详情";
                    cell2.btnToInvest.backgroundColor = MYCOLOR_GRAY;
                    cell2.lblStatus.text = @"完结";
                    cell2.lblStatus.backgroundColor = MYCOLOR_GRAY;
                    break;
                default:
                    break;
            }
            
            if([[info objectForKey:@"status"] intValue]==2){
                
                NSTimeInterval outTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"outTime"]] longLongValue]/1000;
                
                NSDate *outTimeDate = [NSDate dateWithTimeIntervalSince1970: outTimeInterval];
                
                long financingDays = [[info objectForKey:@"financingDays"] longValue];
                long outTime = [outTimeDate timeIntervalSince1970];
                long today = [[NSDate date] timeIntervalSince1970];
                
                long dayDiff = (outTime + financingDays * 24 * 60 * 60 - today) / (24 * 60 * 60);
                
                if(dayDiff<0){
                    cell2.lblDaysLeft.text = @"已截止";
                    cell2.lblDaysLeft.textColor = MYCOLOR_DARK_RED;
                }else{
                    long daysRemaining = dayDiff>0?dayDiff:1;
                    cell2.lblDaysLeft.text = [NSString stringWithFormat:@"%ld%@", daysRemaining, @"天"];
                    cell2.lblDaysLeft.textColor = MYCOLOR_DARK_GREEN;
                }

            }else{
                cell2.lblDaysLeft.text = @"";
            }
        
            NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                                   scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
        
            if ([info objectForKey:@"priorAmt"]==nil || [info objectForKey:@"riskAmt"]==nil
                || [info objectForKey:@"priorInvestedAmt"]==nil || [info objectForKey:@"riskInvestedAmt"]==nil) {
                cell2.pv.percent = 0;
            }else{
                NSDecimalNumber *investedMoney = [[NSDecimalNumber decimalNumberWithString:  [NSString stringWithFormat:@"%@", [info objectForKey:@"priorInvestedAmt"]]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:  [NSString stringWithFormat:@"%@", [info objectForKey:@"riskInvestedAmt"]]]];
                
                NSDecimalNumber *amt = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", [info objectForKey:@"priorAmt"]]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:  [NSString stringWithFormat:@"%@", [info objectForKey:@"riskAmt"]]]];
                
                float progress = [[investedMoney decimalNumberByDividingBy:amt withBehavior:roundDown] floatValue];
                cell2.pv.percent = progress;
            }
        
    }else if(myTab==3){
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            NSNumber * assignAmmount = [f numberFromString:[((NSMutableDictionary*)info) objectForKey:@"assignAmmount"]];

            cell3.lblItemNo.text = [info objectForKey:@"itemNo"];
            cell3.lblItemShowName.text = [info objectForKey:@"itemShowName"];
            cell3.lblAssignAmt.text = [NSString stringWithFormat:@"%@元", [[Utils nf2] stringFromNumber:assignAmmount]];
            cell3.lblAssignAmt.textColor = MYCOLOR_DARK_RED;
            
            if(1==[[info objectForKey:@"type"] intValue]){
                cell3.lblType.text = @"工";
                cell3.lblType.backgroundColor = MYCOLOR_BLUE;
                
                NSDecimalNumber *creditAmount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", [info objectForKey:@"creditAmount"]]];
                NSDecimalNumber *assignAmount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", [info objectForKey:@"assignAmmount"]]];
                NSDecimalNumber *unpaidAmt = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", [info objectForKey:@"unpaidAmt"]]];
                NSDecimalNumber *daysRemaining = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", [info objectForKey:@"daysRemaining"]]];
                    
                NSDecimalNumber *assignRate = [Utils getAssignRate:creditAmount assignAmount:assignAmount  notReceiveLilv:[unpaidAmt decimalNumberBySubtracting:creditAmount] days:daysRemaining];
                
                cell3.lblAssignRate.text = [[[Utils nf2] stringFromNumber: assignRate] stringByAppendingString:@"%"];
            }else if(8==[[info objectForKey:@"type"] intValue]){
                cell3.lblType.text = @"员";
                cell3.lblType.backgroundColor = MYCOLOR_ORANGE;
                
                NSDecimalNumber *creditAmount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", [info objectForKey:@"creditAmount"]]];
                NSDecimalNumber *assignAmount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", [info objectForKey:@"assignAmmount"]]];
                NSDecimalNumber *unpaidAmt = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", [info objectForKey:@"unpaidAmt"]]];
                NSDecimalNumber *daysRemaining = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", [info objectForKey:@"daysRemaining"]]];
                
                NSDecimalNumber *assignRate = [Utils getAssignRate:creditAmount assignAmount:assignAmount  notReceiveLilv:[unpaidAmt decimalNumberBySubtracting:creditAmount] days:daysRemaining];
                
                cell3.lblAssignRate.text = [[[Utils nf2] stringFromNumber: assignRate] stringByAppendingString:@"%"];
            }else if(6==[[info objectForKey:@"type"] intValue]){
                cell3.lblType.text = @"宝";
                cell3.lblType.backgroundColor = MYCOLOR_DARK_RED;
                
                id p1 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"curRate"]]];
                id p2 = [[NSDecimalNumber alloc] initWithString:@"24"];
                
                if ([p1 compare:p2]==1) {
                    cell3.lblAssignRate.text = @"大于24%";
                }else{
                    cell3.lblAssignRate.text = [NSString stringWithFormat:@"%@%%" , [[NSDecimalNumber decimalNumberWithString:[[info objectForKey:@"curRate"] stringValue]] decimalNumberByRoundingAccordingToBehavior:[Utils roundingBehavior3]]];
                }
            }
            
            cell3.btnToInvest.text = @"认购";
            cell3.btnToInvest.backgroundColor = MYCOLOR_DARK_RED;
        
            NSTimeInterval createTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"createTime"]] longLongValue]/1000;
        
            NSDate *createTimeDate = [NSDate dateWithTimeIntervalSince1970: createTimeInterval];
        
            long assignDays = [[info objectForKey:@"assignDays"] longValue];
            long createTime = [createTimeDate timeIntervalSince1970];
            long today = [[NSDate date] timeIntervalSince1970];
        
            long dayDiff = (createTime + assignDays * 24 * 60 * 60 - today) / (24 * 60 * 60);
        
            if(dayDiff<0){
                cell3.lblDaysLeft.text = @"已截止";
                cell3.lblDaysLeft.textColor = MYCOLOR_DARK_RED;
            }else{
                long daysRemaining = dayDiff>0?dayDiff:1;
                cell3.lblDaysLeft.text = [NSString stringWithFormat:@"%ld%@", daysRemaining, @"天"];
                cell3.lblDaysLeft.textColor = MYCOLOR_DARK_GREEN;
            }
    }
    
    switch (myTab) {
        case 1:
            return cell;
            break;
        case 2:
            return cell2;
            break;
        case 3:
            return cell3;
            break;
        default:
            break;
    }
    return nil;
}

#pragma - TableView Delegate Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *info = [self.dataArray objectAtIndex:indexPath.row];
    if (myTab == 1) {
        EntDetailController *controller = (EntDetailController *)[Utils getControllerFromStoryboard:@"EntDetailVC"];
        controller.pId = [[info objectForKey:@"pId"] intValue];
        controller.myHash = [info objectForKey:@"hash"];
        controller.hasFooter = YES;
        
        [self presentViewController:controller animated:NO completion:^{
            //
        }];
    }else if (myTab == 2) {
        BhbDetailController *controller = (BhbDetailController *)[Utils getControllerFromStoryboard:@"BhbDetailVC"];
        controller.pId = [[info objectForKey:@"pId"] intValue];
        controller.myHash = [info objectForKey:@"hash"];
        controller.hasFooter = YES;
        
        [self presentViewController:controller animated:NO completion:nil];
    }else if (myTab == 3) {
        CaDetailController *controller = (CaDetailController *)[Utils getControllerFromStoryboard:@"CaDetailVC"];
        controller.pId = [[info objectForKey:@"pId"] intValue];
        controller.myHash = [info objectForKey:@"hash"];
        controller.hasFooter = YES;
        
        [self presentViewController:controller animated:NO completion:nil];
    }else{
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)loadDataSource
{
    [self showActiveLoading];
    
    BaseOperation *op;
    
    switch (myTab) {
        case 1:
            op = [[PrjEntOperation alloc] initWithDelegate:self];
            ((PrjEntOperation *)op).page = self.currentPage;
            NSLog(@"page = %d", self.currentPage);
            break;
        case 2:
            op = [[PrjBhbOperation alloc] initWithDelegate:self];
            ((PrjBhbOperation *)op).page = self.currentPage;
            NSLog(@"page = %d", self.currentPage);
            break;
        case 3:
            op = [[PrjCaOperation alloc] initWithDelegate:self];
            ((PrjCaOperation *)op).page = self.currentPage;
            NSLog(@"page = %d", self.currentPage);
            break;
        default:
            break;
    }
    
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    switch (myTab) {
        case 1:
            if (code==GET_PRJ_ENTS_SUCCESS) {
                if (self.dataArray != nil && self.dataArray.count>0) {
                    NSMutableArray *newArray=[[NSMutableArray alloc]init];
                    [newArray addObjectsFromArray:self.dataArray];
                    [newArray addObjectsFromArray:((PrjEntItem *)data).items];
                    
                    self.dataArray = newArray;
                }else {
                    self.dataArray = ((PrjEntItem *)data).items;
                }
            }
            break;
        case 2:
            if (code==GET_PRJ_BHB_SUCCESS) {
                if (self.dataArray != nil && self.dataArray.count>0) {
                    NSMutableArray *newArray=[[NSMutableArray alloc]init];
                    [newArray addObjectsFromArray:self.dataArray];
                    [newArray addObjectsFromArray:((PrjBhbItem *)data).items];
                    
                    self.dataArray = newArray;
                }else {
                    self.dataArray = ((PrjBhbItem *)data).items;
                }
            }
            break;
        case 3:
            if (code==GET_PRJ_CAS_SUCCESS) {
                if (self.dataArray != nil && self.dataArray.count>0) {
                    NSMutableArray *newArray=[[NSMutableArray alloc]init];
                    [newArray addObjectsFromArray:self.dataArray];
                    [newArray addObjectsFromArray:((PrjCaItem *)data).items];
                    
                    self.dataArray = newArray;
                }else {
                    self.dataArray = ((PrjCaItem *)data).items;
                }
            }

            break;
        default:
            break;
    }

    [self reloadDataAndResetHeaderFooter];
}

- (IBAction)indexChanged:(UISegmentedControl *)sender {

   self.dataArray = [[NSMutableArray alloc]init];
    
    [self.tv reloadData];
    self.currentPage = 1;
    //**************
    myTab = sender.selectedSegmentIndex==1?sender.selectedSegmentIndex + 2:sender.selectedSegmentIndex + 1 ;
    [self loadDataSource];
}

- (void)swipe:(UISwipeGestureRecognizer *)gesture {
    
    NSInteger currentIndex = self.tabBarController.selectedIndex;
    
    CATransition *transaction = [CATransition animation];
    transaction.type = kCATransitionPush;
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        if (currentIndex==1) {
            if(![AppDelegate isLogin]) {
                LoginController *controller = (LoginController *)[Utils getControllerFromStoryboard:@"LoginVC"];
                [self presentViewController:controller animated:NO completion:nil];
                
                return;
            }
        }
        
        [transaction setSubtype:kCATransitionFromRight];
        self.tabBarController.selectedIndex = currentIndex + 1;
        
    } else {
        [transaction setSubtype:kCATransitionFromLeft];
        self.tabBarController.selectedIndex = currentIndex - 1;
    }
    
    transaction.duration = 0.5;
    transaction.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [[self.tabBarController.view layer] addAnimation:transaction forKey:@"switchView"];
}

-(void)backIndex:(NSNotification*)notify
{
    self.tabBarController.selectedIndex = 0;
}

@end
