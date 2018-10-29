//
//  MyBaoController.m
//  banhuitong
//
//  Created by user on 16-1-7.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "MyBaoController.h"

@interface MyBaoController ()

@end

static int myTab;

@implementation MyBaoController

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
    [self showHeader2:@"班汇宝"];
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
    MyBaoTableViewCell *cell;
    MyBaoTableViewCell2 *cell2;
    MyBaoTableViewCell3 *cell3;
    NSString *IdentifierCell;
    
    switch (myTab) {
        case 1:
            IdentifierCell = @"MyBaoTableViewCell";
            cell = (MyBaoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyBaoTableViewCell" owner:self options:nil];
                cell = [nib lastObject];
            }
            
            break;
        case 2:
            IdentifierCell = @"MyBaoTableViewCell2";
            cell2 = (MyBaoTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
            if (cell2 == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyBaoTableViewCell2" owner:self options:nil];
                cell2 = [nib lastObject];
            }

            break;
        case 3:
            IdentifierCell = @"MyBaoTableViewCell3";
            cell3 = (MyBaoTableViewCell3 *)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
            if (cell3 == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyBaoTableViewCell3" owner:self options:nil];
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
                cell.lblAmt.text = [[[Utils nf] stringFromNumber:[info objectForKey:@"amt"]] stringByAppendingString:@"元"];
                
                NSTimeInterval investTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"tenderTime"]] longLongValue]/1000;
                NSDate *investTime = [NSDate dateWithTimeIntervalSince1970: investTimeInterval];
                cell.lblInvestDate.text = [[Utils df] stringFromDate:investTime];
                
                NSTimeInterval endTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"endTime"]] longLongValue]/1000;
                NSDate *endTime = [NSDate dateWithTimeIntervalSince1970: endTimeInterval];
                cell.lblEndDate.text = [[Utils df] stringFromDate:endTime];
                
                id p1 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"dueRate"]]];
                id p2 = [[NSDecimalNumber alloc] initWithString:@"24"];
                
                if ([p1 compare:p2]==1) {
                    cell.lblMoneyRate.text = @"大于24%";
                }else{
                    cell.lblMoneyRate.text = [NSString stringWithFormat:@"%@%%" , [[Utils nf2] stringFromNumber:[info objectForKey:@"dueRate"]]];
                }
                
                if([[info objectForKey:@"type"] intValue]==3){
                    cell.lblInvestType.text = @"普通资金";
                }else if([[info objectForKey:@"type"] intValue]==4){
                    cell.lblInvestType.text = @"第三方担保资金";
                }
                
                break;
            }
            case 2:
            {
                cell2.lblItemNo.text = [info objectForKey:@"itemNo"];
                cell2.lblItemShowName.text = [info objectForKey:@"itemShowName"];
                cell2.lblAmt.text = [[[Utils nf] stringFromNumber:[info objectForKey:@"amt"]] stringByAppendingString:@"元"];
                
                NSTimeInterval investTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"tenderTime"]] longLongValue]/1000;
                NSDate *investTime = [NSDate dateWithTimeIntervalSince1970: investTimeInterval];
                cell2.lblInvestDate.text = [[Utils df] stringFromDate:investTime];
                
                NSTimeInterval endTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"endTime"]] longLongValue]/1000;
                NSDate *endTime = [NSDate dateWithTimeIntervalSince1970: endTimeInterval];
                cell2.lblEndDate.text = [[Utils df] stringFromDate:endTime];
                
                if([[info objectForKey:@"type"] intValue]==3){
                    cell2.lblInvestType.text = @"普通资金";
                }else if([[info objectForKey:@"type"] intValue]==4){
                    cell2.lblInvestType.text = @"第三方担保资金";
                }
                
                NSTimeInterval financingEndTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"expectedBorrowTime"]] longLongValue]/1000;
                NSDate *financingEndTimeDate = [NSDate dateWithTimeIntervalSince1970: financingEndTimeInterval];
                
                long financingEndTime = [financingEndTimeDate timeIntervalSince1970];
                long today = [[NSDate date] timeIntervalSince1970];
                
                long dayDiff = (today - financingEndTime) / (24 * 60 * 60);

                if(dayDiff>30){
                    id p1 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"curRate"]]];
                    id p2 = [[NSDecimalNumber alloc] initWithString:@"24"];
                    id p3 = [[NSDecimalNumber alloc] initWithString:@"0"];
                    
                    if ([p1 compare:p2]==1) {
                        cell2.lblMoneyRate.text = @"大于24%";
                    }else if ([p1 compare:p3]==-1){
                        cell2.lblMoneyRate.text = @"0%";
                    }else{
                        cell2.lblMoneyRate.text = [NSString stringWithFormat:@"%@%%" , [info objectForKey:@"curRate"]];
                    }
                    cell2.lblCurAmt.text = [[[Utils nf] stringFromNumber:[info objectForKey:@"curAmt"]] stringByAppendingString:@"元"];
                }else{
                    cell2.lblMoneyRate.text = @"--%";
                    cell2.lblCurAmt.text = @"--";
                }
                
                break;
            }
            case 3:
            {
                cell3.lblItemNo.text = [info objectForKey:@"itemNo"];
                cell3.lblItemShowName.text = [info objectForKey:@"itemShowName"];
                cell3.lblAmt.text = [[[Utils nf] stringFromNumber:[info objectForKey:@"realBonusAmt"]] stringByAppendingString:@"元"];
                
                if([[info objectForKey:@"type"] intValue]==3){
                    cell3.lblInvestType.text = @"普通资金";
                }else if([[info objectForKey:@"type"] intValue]==4){
                    cell3.lblInvestType.text = @"第三方担保资金";
                }
                
                if([[info objectForKey:@"sType"] intValue]==2){
                    cell3.lblStype.text = @"转";
                    cell3.lblStype.backgroundColor = MYCOLOR_LIGHT_BLUE;
                }else{
                    cell3.lblStype.text = @"宝";
                    cell3.lblStype.backgroundColor = MYCOLOR_BLUE;
                }
                
                id p1 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"realRate"]]];
                id p2 = [[NSDecimalNumber alloc] initWithString:@"24"];
                if ([p1 compare:p2]==1) {
                    cell3.lblMoneyRate.text = @"大于24%";
                }else{
                    cell3.lblMoneyRate.text = [NSString stringWithFormat:@"%@%%" , [info objectForKey:@"realRate"]];
                }
                
                cell3.lblholdDays.text = [NSString stringWithFormat:@"%d", [[info objectForKey:@"holdDays"] intValue]];
                
                NSTimeInterval endTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"unHoldTime"]] longLongValue]/1000;
                NSDate *endTime = [NSDate dateWithTimeIntervalSince1970: endTimeInterval];
                cell3.lblEndDate.text = [[Utils df] stringFromDate:endTime];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)loadDataSource
{
    [self showActiveLoading];
    
    BaseOperation *op;
    
    switch (myTab) {
        case 1:
            op = [[MyBaoOperation alloc] initWithPage:self.currentPage andWithStatus:MY_BHB_RAISING andWithDelegate:self];
            NSLog(@"page = %d", self.currentPage);
            NSLog(@"status = %d", MY_BHB_RAISING);
            break;
        case 2:
            op = [[MyBaoOperation alloc] initWithPage:self.currentPage andWithStatus:MY_BHB_CLOSED andWithDelegate:self];
            NSLog(@"page = %d", self.currentPage);
            NSLog(@"status = %d", MY_BHB_CLOSED);

            break;
        case 3:
            op = [[MyBaoOperation alloc] initWithPage:self.currentPage andWithStatus:MY_BHB_COMPLETED andWithDelegate:self];
            NSLog(@"page = %d", self.currentPage);
            NSLog(@"status = %d", MY_BHB_COMPLETED);

            break;
        default:
            break;
    }
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code==GET_MY_BAO_SUCCESS) {
        if (self.dataArray != nil && self.dataArray.count>0) {
            NSMutableArray *newArray=[[NSMutableArray alloc]init];
            [newArray addObjectsFromArray:self.dataArray];
            [newArray addObjectsFromArray:((PrjEntItem *)data).items];
            
            self.dataArray = newArray;
        }else {
            self.dataArray = ((PrjEntItem *)data).items;
        }
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