
//
//  IncomeController.m
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "IncomeController.h"
#import "JxGetIncomeOperation.h"

int incomeType = 1;

@interface IncomeController ()

@end

@implementation IncomeController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    switch (incomeType) {
        case RECHARGE:
            [self showHeader2:@"充值"];
            break;
        case WITHDRAW:
            [self showHeader2:@"提现"];
            break;
        case TENDER:
            [self showHeader2:@"出借"];
            break;
        case REPAY:
            [self showHeader2:@"还款"];
            break;
        case REWARD:
            [self showHeader2:@"奖励"];
            break;
        case FEE:
            [self showHeader2:@"支出"];
            break;
        default:
            break;
    }
    
    [self loadDataSource];
    self.didLoad = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Mark - TableView DataSource Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.selectedIndex) {
        if (self.isOpen == YES) {
            return 110;
        }else{
            return 65;
        }
    }
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    @try
    {
        NSString *IdentifierCell = @"IncomeTableViewCell";
        IncomeTableViewCell * cell = (IncomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"IncomeTableViewCell" owner:self options:nil];
            cell = [nib lastObject];
        }
        cell.selectionStyle = UITableViewCellStateDefaultMask;
        
        if (indexPath.row == self.selectedIndex) {
            if (self.isOpen == YES) {
                cell.imgSpinner.image = [UIImage imageNamed:@"spinner2.png"];
            }else{
                cell.imgSpinner.image = [UIImage imageNamed:@"spinner1.png"];
            }
        }
        
        if (self.dataArray.count>0) {
            NSMutableDictionary *info = [self.dataArray objectAtIndex:indexPath.row];
            
            NSTimeInterval interval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"datepoint"]] longLongValue]/1000;
            NSDate *datepoint = [NSDate dateWithTimeIntervalSince1970: interval];
            
            cell.lblDatepoint.text = [[Utils df] stringFromDate:datepoint];
            
            int arType = [[info objectForKey:@"arType"] intValue];
            
            if(arType==1){
                cell.lblAmt.text = [[Utils nf2] stringFromNumber:[info objectForKey:@"creditAmt"]];
            }else if(arType==2){
                cell.lblAmt.text = [[Utils nf2] stringFromNumber:[info objectForKey:@"debitAmt"]];
            }else if(arType==3||arType==21){
                if(arType==21){
                    cell.lblAmt.text = [[Utils nf2] stringFromNumber:[info objectForKey:@"debitAmt"]];
                }else{
                    cell.lblAmt.text = [[Utils nf2] stringFromNumber:[info objectForKey:@"frzAmt"]];
                }
            }else if(arType==7||arType==8||arType==9||arType==10||arType==4||arType==20){
                if(arType==4){
                    cell.lblAmt.text = [[Utils nf2] stringFromNumber:[info objectForKey:@"unfrzAmt"]];
                }else{
                    cell.lblAmt.text = [[Utils nf2] stringFromNumber:[info objectForKey:@"creditAmt"]];
                }
            }else if(arType==16||arType==17||arType==18){
                cell.lblAmt.text = [[Utils nf2] stringFromNumber:[info objectForKey:@"creditAmt"]];
            }else if(arType==11||arType==23){
                cell.lblAmt.text = [[Utils nf2] stringFromNumber:[info objectForKey:@"debitAmt"]];
            }else if(arType==99){
                cell.lblAmt.text = [[Utils nf2] stringFromNumber:[info objectForKey:@"creditAmt"]];
            }else if(arType>=24&&arType<=39){
                cell.lblAmt.text = [[Utils nf2] stringFromNumber:[info objectForKey:@"creditAmt"]];
            }
            cell.lblAmt.text = [cell.lblAmt.text stringByAppendingString:@"元"];
            cell.lblType.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"remark"]];
            cell.lblItemShowName.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"itemShowName"]];
        }
        
        return cell;
    }@catch (NSException * e) {
    }
}

#pragma - TableView Delegate Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    if (indexPath.row == self.selectedIndex) {
        self.isOpen = !self.isOpen;
    }else if (indexPath.row != self.selectedIndex) {
        self.isOpen = YES;
    }
    
    //记下选中的索引
    self.selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

-(void)loadDataSource
{
    NSString *key = @"";
    
    if(incomeType==RECHARGE){
        key = @"recharge";
    }else if(incomeType==WITHDRAW){
        key = @"withdraw";
    }else if(incomeType==TENDER){
        key = @"tender";
    }else if(incomeType==REPAY){
        key = @"repay";
    }else if(incomeType==REWARD){
        key = @"reward";
    }else if(incomeType==FEE){
        key = @"fee";
    }
    
    //check cache
    if (self.currentPage == 1 && self.didLoad == YES) {
        NSMutableArray *rst = [[CacheService sharedInstance] search:key];
        if (rst.count>0) {
            NSMutableDictionary *dic = [rst objectAtIndex:0];
            
            NSTimeInterval timeInterval = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"datepoint"]] longLongValue];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970: timeInterval];
            long datepoint = [date timeIntervalSince1970];
            long now = [[NSDate date] timeIntervalSince1970];
            long dayDiff = (now - datepoint) ;
            
            if (dayDiff < 10) {
                NSString *value = [dic objectForKey:@"value"];
                NSData *data =[value dataUsingEncoding:NSUTF8StringEncoding];
                NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                id items = [dict objectForKey:@"incomes"];
                
                self.dataArray = items;
                [self reloadDataAndResetHeaderFooter];
                return;
            }
        }
    }
    
    [self showActiveLoading];
    
    BaseOperation *op = [[JxGetIncomeOperation alloc] initWithDelegate:self];
    ((JxGetIncomeOperation*)op).type = incomeType;
    ((JxGetIncomeOperation*)op).lastNxTrnn = self.lastNxTrnn;
    ((JxGetIncomeOperation*)op).lastNxReld = self.lastNxReld;
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code==GET_ACC_INCOME) {
        if (self.dataArray != nil && self.dataArray.count>0) {
            NSMutableArray *newArray=[[NSMutableArray alloc]init];
            [newArray addObjectsFromArray:self.dataArray];
            [newArray addObjectsFromArray:(NSMutableArray *)data];
            
            self.dataArray = newArray;
        }else {
            self.dataArray = (NSMutableArray *)data;
        }
        
        //do cache
        NSString *key = @"";
        
        if(incomeType==RECHARGE){
            key = @"recharge";
        }else if(incomeType==WITHDRAW){
            key = @"withdraw";
        }else if(incomeType==TENDER){
            key = @"tender";
        }else if(incomeType==REPAY){
            key = @"repay";
        }else if(incomeType==REWARD){
            key = @"reward";
        }else if(incomeType==FEE){
            key = @"fee";
        }
        
        NSMutableDictionary *params3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.dataArray, @"incomes",nil];
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:params3 options:NSJSONWritingPrettyPrinted error:nil];
        NSString* str =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSMutableArray *rst = [[CacheService sharedInstance] search:key];
        if (rst.count>0) {
            [[CacheService sharedInstance] update:key value:str];
        }else{
            [[CacheService sharedInstance] insert:key value:str];
        }
    }
    
    [self reloadDataAndResetHeaderFooter];
}

@end
