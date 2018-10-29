//
//  CPController.m
//  banhuitong
//
//  Created by user on 16/6/13.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "CPController.h"

@interface CPController ()

@end

NSString* cacheKey = @"cpData";

@implementation CPController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(self.isFirst){
//        [self callChinaPayPlugin];
        
        NSMutableArray *rst = [[CacheService sharedInstance] search:cacheKey];
        if (rst.count>0) {
            NSMutableDictionary *dic = [rst objectAtIndex:0];
            
            NSTimeInterval timeInterval = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"datepoint"]] longLongValue];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970: timeInterval];
            long datepoint = [date timeIntervalSince1970];
            long now = [[NSDate date] timeIntervalSince1970];
            long dayDiff = (now - datepoint) ;
            
            if (dayDiff < 300) {
                NSString *value = [dic objectForKey:@"value"];
                NSData *data =[value dataUsingEncoding:NSUTF8StringEncoding];
                NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                [self callChinaPayPlugin:dict];
                self.isFirst = NO;
                return;
            }
        }

        BaseOperation *op = [[GetCPDataOperation alloc] initWithDelegate:self];
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
        self.isFirst = NO;
    }else{
        [self onBackAction];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFirst = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code==GET_CPDATA_SUCCESS) {
        NSMutableDictionary *dict = data;
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString* cacheJson =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSMutableArray *rst = [[CacheService sharedInstance] search:cacheKey];
        if (rst.count>0) {
            [[CacheService sharedInstance] update:cacheKey value:cacheJson];
        }else{
            [[CacheService sharedInstance] insert:cacheKey value:cacheJson];
        }
        
        [self callChinaPayPlugin:dict];
    }
}


- (void)onResp:(CPBaseResp *)resp {
    NSLog(@"%@", resp.respCode);
    NSLog(@"%@", resp.respMsg);
    if([resp.respCode isEqualToString:@"0000"]){
        CPAuthResp *ar = (CPAuthResp *)resp;
        NSLog(@"%@", ar.cardNo);
        NSLog(@"%@", ar.cerNo);
        NSLog(@"%@", ar.cerName);
        NSLog(@"%@", ar.cardMobile);
    }
}

-	(void)callChinaPayPlugin {
    CPAuthReq *req = [[CPAuthReq alloc] init];
    req.userInfo = [NSDictionary dictionaryWithObject:@"test" forKey:@"environment"];   //环境参数，测试环境下需加此行，正式环境下无需此行。
    req.appSysId = @"90000";		//系统编号
    req.sign = @"b8c0f7a2bfa176f307ec6d609136e626";		//签名，见参数说明
    req.cardNo = @"6226620607792207";	//银行卡号
    req.cerType = @"01";			//证件类型
    req.cerNo = @"231002198903302089";	//证件号码
    req.cerName = @"刘敏";			//证件姓名
    req.cardMobile = @"18817331234";	//预留手机号
    
    [CPApi openAuthPluginAtViewController:self withReq:req];
}

-	(void)callChinaPayPlugin:(NSMutableDictionary*) dict {
    CPAuthReq *req = [[CPAuthReq alloc] init];
    req.userInfo = [NSDictionary dictionaryWithObject:@"test" forKey:@"environment"];   //环境参数，测试环境下需加此行，正式环境下无需此行。
    req.appSysId = [dict objectForKey:@"appSysId"];		//系统编号
    req.sign =  [dict objectForKey:@"sign"];		//签名，见参数说明
    req.cardNo =  [dict objectForKey:@"cardNo"];	//银行卡号
    req.cerType =  [dict objectForKey:@"cerType"];			//证件类型
    req.cerNo =  [dict objectForKey:@"cerNo"];	//证件号码
    req.cerName =  [dict objectForKey:@"cerName"];			//证件姓名
    req.cardMobile =  [dict objectForKey:@"cardMobile"];	//预留手机号
    
    [CPApi openAuthPluginAtViewController:self withReq:req];
}


@end
