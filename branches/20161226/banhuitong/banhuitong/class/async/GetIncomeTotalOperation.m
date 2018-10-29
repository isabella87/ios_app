//
//  GetIncomeTotalOperation.m
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "GetIncomeTotalOperation.h"

@implementation GetIncomeTotalOperation

-(id)initWithType:(int) type andWithDelegate:(id<HttpResponseDelegate>)del{
    self.type = type;
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization  JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        
        int code = 0;
        if(self.type==RECHARGE){
            code = GET_ACC_INCOME_TOTAL_OF_RECHARGE;
        }else if(self.type==WITHDRAW){
            code = GET_ACC_INCOME_TOTAL_OF_WITHDRAW;
        }else if(self.type==TENDER){
            code = GET_ACC_INCOME_TOTAL_OF_INVEST;
        }else if(self.type==REPAY){
            code = GET_ACC_INCOME_TOTAL_OF_REPAY;
        }else if(self.type==REWARD){
            code = GET_ACC_INCOME_TOTAL_OF_BONUS;
        }else if(self.type==FEE){
            code= GET_ACC_INCOME_TOTAL_OF_EXPENDITURE;
        }
        [self.httpResponseDelegate callbackWithCode:code andWithData:dict];
    }@catch (NSException *exception){
        [Utils showMessage:@"网络异常！"];
    }
    
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"%d",self.type],@"type",
                                   nil];
    
//    NSString *server = SERVER_ADDRESS_P2P;
    NSString *server = @"";
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"account/income-total-amt"]withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

@end
