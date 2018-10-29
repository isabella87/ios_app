//
//  GetIncomeOperation.m
//  banhuitong
//
//  Created by user on 16-1-5.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "JxGetIncomeOperation.h"

@implementation JxGetIncomeOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    return [super initWithDelegate:del];
}

-(void)delegateDispatch{
    @try{
        NSMutableDictionary *dict = [NSJSONSerialization  JSONObjectWithData:self.requestData options:NSJSONReadingAllowFragments error:nil];
        id items = [dict objectForKey:@"items"];
        
        [self.httpResponseDelegate callbackWithCode:GET_ACC_INCOME  andWithData:items];
    }@catch (NSException *exception){
        NSLog (@"%@", exception);
        [Utils showMessage:@"网络异常！"];
    }
}

-(void) start{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%@",self.lastNxReld] forKey:@"last-nx-reld"];
    [params setObject:[NSString stringWithFormat:@"%@",self.lastNxTrnn] forKey:@"last-nx-trnn"];
    [params setObject:[NSString stringWithFormat:@"%@",self.lastDatepoint] forKey:@"last-datepoint"];
    [params setObject:[NSString stringWithFormat:@"%d",self.type] forKey:@"tran-type-flag"];
    [params setObject:[NSString stringWithFormat:@"%d",self.pn] forKey:@"pn"];
    [params setObject:[NSString stringWithFormat:@"%@",self.savedUsername] forKey:@"login-name-or-mobile"];
    [params setObject:[NSString stringWithFormat:@"%@",self.savedPassword] forKey:@"pwd"];
    
    //    NSString *server = SERVER_ADDRESS_P2P;
    //    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:[server stringByAppendingString:@"trans/funds-detail"]withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
    
    NSString *url = URL_38;
    [[[HttpService alloc] initWithDelegate:self]requestWithUrl:url withHeader:self.headers withParamters:params withMethod:HTTP_METHOD_GET];
}

-(BOOL) checkCache:(BOOL)isCheck{
    BOOL ret = YES;
//    self.isCheckCache = isCheck;
    
    if(isCheck){
        NSString *key = @"";
        if(self.type==IN){
            key = @"money-in";
        }else if(self.type==OUT){
            key = @"money-out";
        }
        
        if (self.pn == 1) {
            NSMutableArray *rst = [[CacheService sharedInstance] search:key];
            if (rst.count>0) {
                NSMutableDictionary *dic = [rst objectAtIndex:0];
                
                NSTimeInterval timeInterval = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"datepoint"]] longLongValue];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970: timeInterval];
                long datepoint = [date timeIntervalSince1970];
                long now = [[NSDate date] timeIntervalSince1970];
                long dayDiff = (now - datepoint) ;
                
                if (dayDiff < 20) {
                    NSString *value = [dic objectForKey:@"value"];
                    NSData *data =[value dataUsingEncoding:NSUTF8StringEncoding];
                    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                    id items = [dict objectForKey:@"items"];
                    
                    ((id<HttpResponseDelegate>)self.httpResponseDelegate).isDataFromCache = YES;
                    [self.httpResponseDelegate callbackWithCode:GET_ACC_INCOME  andWithData:items];
                }else{
                    ret = NO;
                }
            }else{
                ret = NO;
            }
        }else{
            ret = NO;
        }
    }
    return ret;
}

@end
