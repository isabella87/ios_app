//
//  MyZhuanControllerViewController.m
//  banhuitong
//
//  Created by user on 16-1-8.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "MyZhuanController.h"

@interface MyZhuanController ()

@end

static int myTab;

@implementation MyZhuanController

+ (void) setTab:(int)tab{
    myTab = tab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc{
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader2:@"债权转让"];
    self.currentPage = 1;
    self.dataArray = [[NSMutableArray alloc] init];
    
    [self.segmentedControl setSelectedSegmentIndex:0];
    [self indexChanged:self.segmentedControl];
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
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyZhuanTableViewCell *cell;
    MyZhuanTableViewCell2 *cell2;
    MyZhuanTableViewCell3 *cell3;
    NSString *IdentifierCell;
    
    switch (myTab) {
        case 1:
            IdentifierCell = @"MyZhuanTableViewCell";
            cell = (MyZhuanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyZhuanTableViewCell" owner:self options:nil];
                cell = [nib lastObject];
            }
            
            break;
        case 2:
            IdentifierCell = @"MyZhuanTableViewCell2";
            cell2 = (MyZhuanTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
            if (cell2 == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyZhuanTableViewCell2" owner:self options:nil];
                cell2 = [nib lastObject];
            }
            
            break;
        case 3:
            IdentifierCell = @"MyZhuanTableViewCell3";
            cell3 = (MyZhuanTableViewCell3 *)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
            if (cell3 == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyZhuanTableViewCell3" owner:self options:nil];
                cell3 = [nib lastObject];
            }
            
            break;
        default:
            break;
    }
    
    if (self.dataArray.count>0) {
        NSMutableDictionary *info = [self.dataArray objectAtIndex:indexPath.row];
        
        switch (myTab) {
            case 1:
            {
                cell.lblItemNo.text = [info objectForKey:@"itemNo"];
                cell.lblItemShowName.text = [info objectForKey:@"itemShowName"];
                
                if([[info objectForKey:@"sType"] intValue]==2 || [[info objectForKey:@"lastSType"] intValue]==2){
                    cell.lblType.text = @"转";
                    cell.lblType.backgroundColor = MYCOLOR_LIGHT_BLUE;
                }else{
                    if([[info objectForKey:@"pType"] intValue]==3 || [[info objectForKey:@"pType"] intValue]==4){
                        cell.lblType.text = @"宝";
                        cell.lblType.backgroundColor = MYCOLOR_DARK_RED;
                    }else if([[info objectForKey:@"pType"] intValue]==1){
                        if ([[info objectForKey:@"flags"] intValue]==32) {
                            cell.lblType.text = @"员";
                            cell.lblType.backgroundColor = MYCOLOR_ORANGE;
                        }else{
                            cell.lblType.text = @"工";
                            cell.lblType.backgroundColor = MYCOLOR_BLUE;
                        }
                    }
                }
                
                id p1 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"amt"]]];
                
                cell.lblAmt.text = [[[Utils nf] stringFromNumber:p1] stringByAppendingString:@"元"];
                
                if([[info objectForKey:@"pType"] intValue]==3 || [[info objectForKey:@"pType"] intValue]==4){
                    
                    id p1 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"curRate"]]];
                    id p2 = [[NSDecimalNumber alloc] initWithString:@"24"];
                    if ([p1 compare:p2]>NSOrderedSame) {
                        cell.lblMoneyRate.text = [NSString stringWithFormat:@"当前大于24%%"];
                    }else{
                        cell.lblMoneyRate.text = [NSString stringWithFormat:@"当前%@%%", [info objectForKey:@"curRate"]];
                    }
                    
                }else if([[info objectForKey:@"pType"] intValue]==1){
                    cell.lblMoneyRate.text = [NSString stringWithFormat:@"%@%%", [info objectForKey:@"moneyRate"]];
                }
                
                NSTimeInterval investTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"investTime"]] longLongValue]/1000;
                NSDate *investTime = [NSDate dateWithTimeIntervalSince1970: investTimeInterval];
                cell.lblInvestDate.text = [[Utils df] stringFromDate:investTime];
                
                NSTimeInterval repayCapitalDateInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"repayCapitalDate"]] longLongValue]/1000;
                NSDate *repayCapitalDate = [NSDate dateWithTimeIntervalSince1970: repayCapitalDateInterval];
                cell.lblRepayCapitalDate.text = [[Utils df] stringFromDate:repayCapitalDate];
                
                break;
            }
            case 2:
            {
                cell2.lblItemNo.text = [info objectForKey:@"itemNo"];
                cell2.lblItemShowName.text = [info objectForKey:@"itemShowName"];
                
                if([[info objectForKey:@"sType"] intValue]==2 || [[info objectForKey:@"lastSType"] intValue]==2){
                    cell2.lblType.text = @"转";
                    cell2.lblType.backgroundColor = MYCOLOR_LIGHT_BLUE;
                }else{
                    if([[info objectForKey:@"pType"] intValue]==3 || [[info objectForKey:@"pType"] intValue]==4){
                        cell2.lblType.text = @"宝";
                        cell2.lblType.backgroundColor = MYCOLOR_DARK_RED;
                    }else if([[info objectForKey:@"pType"] intValue]==1){
                        if ([[info objectForKey:@"flags"] intValue]==32) {
                            cell2.lblType.text = @"员";
                            cell2.lblType.backgroundColor = MYCOLOR_ORANGE;
                        }else{
                            cell2.lblType.text = @"工";
                            cell2.lblType.backgroundColor = MYCOLOR_BLUE;
                        }
                    }
                }
                
                if([[info objectForKey:@"pType"] intValue]==3 || [[info objectForKey:@"pType"] intValue]==4){
                    
                    id p1 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"curRate"]]];
                    id p2 = [[NSDecimalNumber alloc] initWithString:@"24"];
                    if ([p1 compare:p2]>NSOrderedSame) {
                        cell2.lblMoneyRate.text = [NSString stringWithFormat:@"当前大于24%%"];
                    }else{
                        cell2.lblMoneyRate.text = [NSString stringWithFormat:@"当前%@%%", [[NSDecimalNumber decimalNumberWithString:[[info objectForKey:@"curRate"] stringValue]] decimalNumberByRoundingAccordingToBehavior:[Utils roundingBehavior3]]];
                    }
                    
                }else if([[info objectForKey:@"pType"] intValue]==1){
                    cell2.lblMoneyRate.text = [NSString stringWithFormat:@"折算%@%%",  [[NSDecimalNumber decimalNumberWithString:[info objectForKey:@"assignRate"]] decimalNumberByRoundingAccordingToBehavior:[Utils roundingBehavior3]]];
                }
                
                cell2.lblLeftAssignDays.text = [NSString stringWithFormat:@"%@天", [info objectForKey:@"assignDaysLeft"]];
                
                id p1 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"unpaidAmt"]]];
                cell2.lblUnpaid.text = [[[Utils nf2] stringFromNumber:p1] stringByAppendingString:@"元"];
                
                id p3 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"assignAmt"]]];
                cell2.lblAssignAmt.text = [[[Utils nf] stringFromNumber:p3] stringByAppendingString:@"元"];
            
                NSTimeInterval applyTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"applyTime"]] longLongValue]/1000;
                NSDate *applyTime = [NSDate dateWithTimeIntervalSince1970: applyTimeInterval];
                cell2.lblApplyDate.text = [[Utils df] stringFromDate:applyTime];
                
                break;
            }
            case 3:
            {
                cell3.lblItemNo.text = [info objectForKey:@"itemNo"];
                cell3.lblItemShowName.text = [info objectForKey:@"itemShowName"];
                
                if([[info objectForKey:@"sType"] intValue]==2 || [[info objectForKey:@"lastSType"] intValue]==2){
                    cell3.lblType.text = @"转";
                    cell3.lblType.backgroundColor = MYCOLOR_LIGHT_BLUE;
                }else{
                    if([[info objectForKey:@"pType"] intValue]==3 || [[info objectForKey:@"pType"] intValue]==4){
                        cell3.lblType.text = @"宝";
                        cell3.lblType.backgroundColor = MYCOLOR_DARK_RED;
                    }else if([[info objectForKey:@"pType"] intValue]==1){
                        if ([[info objectForKey:@"flags"] intValue]==32) {
                            cell3.lblType.text = @"员";
                            cell3.lblType.backgroundColor = MYCOLOR_ORANGE;
                        }else{
                            cell3.lblType.text = @"工";
                            cell3.lblType.backgroundColor = MYCOLOR_BLUE;
                        }
                    }
                }
                
                if([[info objectForKey:@"pType"] intValue]==3 || [[info objectForKey:@"pType"] intValue]==4){
                    
                    id p1 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"curRate"]]];
                    id p2 = [[NSDecimalNumber alloc] initWithString:@"24"];
                    if ([p1 compare:p2]>NSOrderedSame) {
                        cell3.lblMoneyRate.text = [NSString stringWithFormat:@"大于24%%"];
                    }else{
                        cell3.lblMoneyRate.text = [NSString stringWithFormat:@"%@%%", [[NSDecimalNumber decimalNumberWithString:[[info objectForKey:@"curRate"] stringValue]] decimalNumberByRoundingAccordingToBehavior:[Utils roundingBehavior3]]];
                    }
                    
                }else if([[info objectForKey:@"pType"] intValue]==1){
                    cell3.lblMoneyRate.text = [NSString stringWithFormat:@"%@%%", [info objectForKey:@"assignRate"]];
                }
                
                id p1 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"fee"]]];
                cell3.lblAssignAmt.text = [[[Utils nf] stringFromNumber:p1] stringByAppendingString:@"元"];
                
                id p3 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"assignAmt"]]];
                cell3.lblAssignAmt.text = [[[Utils nf] stringFromNumber:p3] stringByAppendingString:@"元"];
                
                id p5 = [[[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"transactionAmt"]]] decimalNumberBySubtracting:[[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"fee"]]]];
                cell3.lblRealGain.text = [[[Utils nf] stringFromNumber:p5] stringByAppendingString:@"元"];
                
                id p7 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"fee"]]];
                cell3.lblFee.text = [[[Utils nf] stringFromNumber:p7] stringByAppendingString:@"元"];
                
                NSTimeInterval transactionDateInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"transactionDate"]] longLongValue]/1000;
                NSDate *transactionDate = [NSDate dateWithTimeIntervalSince1970: transactionDateInterval];
                cell3.lblTransDate.text = [[Utils df] stringFromDate:transactionDate];
                
                break;
            }
            default:
                break;
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
        
        if ([[NSString stringWithFormat:@"%@",[info objectForKey:@"pType"] ] isEqualToString: @"3"] || [[NSString stringWithFormat:@"%@",[info objectForKey:@"pType"] ] isEqualToString: @"4"]) {
            
            BhbApplyCaController *controller = (BhbApplyCaController *)[Utils getControllerFromStoryboard:@"BhbApplyCaVC"];
            controller.tiId = [[info objectForKey:@"tiId"] intValue];
            
            [self presentViewController:controller animated:NO completion:^{
            }];
            
        }else if ([[NSString stringWithFormat:@"%@",[info objectForKey:@"pType"] ] isEqualToString: @"1"]){
            
            ApplyCaController *controller = (ApplyCaController *)[Utils getControllerFromStoryboard:@"ApplyCaVC"];
                    controller.tiId = [[info objectForKey:@"tiId"] intValue];
        
            [self presentViewController:controller animated:NO completion:^{
            }];
        }
    }else  if (myTab == 2) {
        self.cancelPid = [[info objectForKey:@"pId"] stringValue];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认撤销转让？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 1;
        [alert show];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1) {
        if (buttonIndex==1) {
            [self showActiveLoading];
            
            BaseOperation *op = [[CaCancelOperation alloc] initWithDelegate:self];
            ((CaCancelOperation *)op).pid = self.cancelPid;
            [[AsyncCenter sharedInstance].operationQueue addOperation:op];
            
        }
    }else if (alertView.tag==2) {
        NSMutableArray *newArray=[[NSMutableArray alloc]init];
        [newArray addObjectsFromArray:self.dataArray];
        self.dataArray = newArray;
        [self.dataArray removeAllObjects];
        
        [self.tv reloadData];
        self.currentPage = 1;
        [self loadDataSource];
    }
}

-(void)loadDataSource
{
    [self showActiveLoading];
    
    BaseOperation *op;
    
    switch (myTab) {
        case 1:
            op = [[MyZhuanOperation alloc] initWithPage:self.currentPage andWithStatus:CA_APPLIABLE andWithDelegate:self];
            NSLog(@"page = %d", self.currentPage);
            NSLog(@"status = %d", CA_APPLIABLE);
            break;
        case 2:
            op = [[MyZhuanOperation alloc] initWithPage:self.currentPage andWithStatus:CA_PROCESSING andWithDelegate:self];
            NSLog(@"page = %d", self.currentPage);
            NSLog(@"status = %d", CA_PROCESSING);
            
            break;
        case 3:
            op = [[MyZhuanOperation alloc] initWithPage:self.currentPage andWithStatus:CA_DONE andWithDelegate:self];
            NSLog(@"page = %d", self.currentPage);
            NSLog(@"status = %d", CA_DONE);
            
            break;
        default:
            break;
    }
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code==GET_MY_ZHUAN_SUCCESS) {
        if (self.dataArray != nil && self.dataArray.count>0) {
            NSMutableArray *newArray=[[NSMutableArray alloc]init];
            [newArray addObjectsFromArray:self.dataArray];
            [newArray addObjectsFromArray:((PrjEntItem *)data).items];
            
            self.dataArray = newArray;
        }else {
            self.dataArray = ((PrjEntItem *)data).items;
        }
    }else if (code==CA_CANCEL_SUCCESS) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"撤销成功。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        alert.tag = 2;
        [alert show];
    }else  if (code==NETWORK_ERROR) {
        NSString *msg = ((NSString*)data);
        [self showAlertWithText:msg];
    }

    [self reloadDataAndResetHeaderFooter];
}

- (IBAction)indexChanged:(UISegmentedControl *)sender {
    
    self.dataArray = [[NSMutableArray alloc]init];
    
    [self.tv reloadData];
    self.currentPage = 1;
    myTab = sender.selectedSegmentIndex+1;
    [self loadDataSource];
}

@end
