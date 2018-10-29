
//
//  IncomeController.m
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "JxIncomeController.h"
#import "JxGetIncomeOperation.h"

@interface JxIncomeController ()

@end

@implementation JxIncomeController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    switch (self.jxIncomeType) {
        case IN:
            [self showHeader2:@"收入"];
            break;
        case OUT:
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
    self.lastNxTrnn = @"";
    self.lastNxReld = @"";
    self.lastDatepoint = @"";
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
            
            NSTimeInterval interval = [[NSString stringWithFormat:@"%@",[info objectForKey:@"datePoint"]] longLongValue]/1000;
            NSDate *datepoint = [NSDate dateWithTimeIntervalSince1970: interval];
            
            cell.lblDatepoint.text = [[Utils df] stringFromDate:datepoint];
            
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            NSNumber *amount = [f numberFromString:[info objectForKey:@"amount"]];

            
            cell.lblAmt.text = [[Utils nf2] stringFromNumber:amount];
            cell.lblAmt.text = [cell.lblAmt.text stringByAppendingString:@"元"];
            cell.lblItemShowName.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"desc"]];
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
    if (self.currentPage==1) {
        self.lastNxReld = @"";
        self.lastNxTrnn = @"";
        self.lastDatepoint = @"";
    }
    
    [self showActiveLoading];
    
    BaseOperation *op = [[JxGetIncomeOperation alloc] initWithDelegate:self];
    ((JxGetIncomeOperation*)op).type = self.jxIncomeType;
    ((JxGetIncomeOperation*)op).lastNxTrnn = self.lastNxTrnn;
    ((JxGetIncomeOperation*)op).lastNxReld = self.lastNxReld;
    ((JxGetIncomeOperation*)op).lastDatepoint = self.lastDatepoint;
    ((JxGetIncomeOperation*)op).pn = self.currentPage;
    
    //check cache
    if([((JxGetIncomeOperation*)op) checkCache:YES]==NO){
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    }
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
        if(self.isDataFromCache==NO){
            [self doCache:self.dataArray];
        }
        
        if (self.dataArray.count>0) {
            self.lastNxReld = [[self.dataArray lastObject] objectForKey:@"hsReld"];
            self.lastNxTrnn = [[self.dataArray lastObject]  objectForKey:@"trxNo"];
            self.lastDatepoint = [[self.dataArray lastObject]  objectForKey:@"datePoint"];
        }

        [self reloadDataAndResetHeaderFooter];
    }
}

-(void) doCache:(NSObject*)object{
    NSString *key = @"";
    
    if(self.jxIncomeType==IN){
        key = @"money-in";
    }else if(self.jxIncomeType==OUT){
        key = @"money-out";
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:object, @"items",nil];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString* str =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableArray *rst = [[CacheService sharedInstance] search:key];
    if (rst.count>0) {
        [[CacheService sharedInstance] update:key value:str];
    }else{
        [[CacheService sharedInstance] insert:key value:str];
    }
}

@end
