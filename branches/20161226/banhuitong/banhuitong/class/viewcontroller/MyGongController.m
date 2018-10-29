//
//  MyGongController.m
//  banhuitong
//
//  Created by user on 16-1-7.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "MyGongController.h"

@interface MyGongController ()

@end

static int myTab;

@implementation MyGongController

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
    [self showHeader2:@"项目出借"];
    self.currentPage = 1;
    self.dataArray = [[NSMutableArray alloc] init];
    
    [self.segmentedControl setSelectedSegmentIndex:1];
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
    MyGongTableViewCell *cell;
    NSString *IdentifierCell;
    
        IdentifierCell = @"MyGongTableViewCell";
        cell = (MyGongTableViewCell *)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyGongTableViewCell" owner:self options:nil];
            cell = [nib lastObject];
        }
    
        if (self.dataArray.count>0) {
            
        NSMutableDictionary *info = [self.dataArray objectAtIndex:indexPath.row];
        
        cell.lblItemNo.text = [info objectForKey:@"itemNo"];
        cell.lblItemShowName.text = [info objectForKey:@"itemShowName"];
        cell.lblMoneyRate.text = [NSString stringWithFormat:@"%@%%", [info objectForKey:@"moneyRate"]];
        cell.lblBorrowDays.text = [NSString stringWithFormat:@"%@天",[info objectForKey:@"borrowDays"]];
        
        id p1 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [info objectForKey:@"amt"]]];
        id p2 = [[NSDecimalNumber alloc] initWithString:@"10000"];
        if ([p1 compare:p2]>=NSOrderedSame) {
            cell.lblAmt.text = [[[Utils nf2] stringFromNumber:[p1 decimalNumberByDividingBy:p2]] stringByAppendingString:@"万元"];
        }else{
            cell.lblAmt.text = [[[Utils nf2] stringFromNumber:p1] stringByAppendingString:@"元"];
        }

        NSTimeInterval investTimeInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"investTime"]] longLongValue]/1000;
        NSDate *investTime = [NSDate dateWithTimeIntervalSince1970: investTimeInterval];
        cell.lblInvestDate.text = [[Utils df] stringFromDate:investTime];
        
        if (myTab==INVEST_OF_FAILED) {
            cell.lblRepayCapitalDateName.text = @"流标日期";
            NSTimeInterval cancelDateInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"cancelDate"]] longLongValue]/1000;
            NSDate *cancelDate = [NSDate dateWithTimeIntervalSince1970: cancelDateInterval];
            cell.lblRepayCapitalDate.text = [[Utils df] stringFromDate:cancelDate];
        }else{
            NSTimeInterval repayCapitalDateInterval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"repayCapitalDate"]] longLongValue]/1000;
            NSDate *repayCapitalDate = [NSDate dateWithTimeIntervalSince1970: repayCapitalDateInterval];
            cell.lblRepayCapitalDate.text = [[Utils df] stringFromDate:repayCapitalDate];
        }
        
        if ([[info objectForKey:@"sType"] intValue]==2) {
            cell.lblType.text = @"转";
            cell.lblType.backgroundColor = MYCOLOR_LIGHT_BLUE;
        }else{
            if ([[info objectForKey:@"oriType"] intValue]==8 || [[info objectForKey:@"flags"] intValue]==32) {
                cell.lblType.text = @"员";
                cell.lblType.backgroundColor = MYCOLOR_ORANGE;
            }else if (([[info objectForKey:@"flags"] intValue] & 0x001)!=0) {
                cell.lblType.text = @"新";
                cell.lblType.backgroundColor = MYCOLOR_GREEN;
            }else{
                cell.lblType.text = @"工";
                cell.lblType.backgroundColor = MYCOLOR_BLUE;
            }
        }
    }
    return cell;
}

#pragma - TableView Delegate Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)loadDataSource
{
    [self showActiveLoading];
    
    BaseOperation *op;
    op = [[MyGongOperation alloc] initWithPage:self.currentPage andWithStatus:myTab andWithDelegate:self];
    
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code==GET_MY_GONG_SUCCESS) {
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
