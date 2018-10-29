//
//  ApplyCaController.m
//  banhuitong
//
//  Created by 陈鲁 on 16/1/15.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "BhbApplyCaController.h"

@interface BhbApplyCaController ()

@end

@implementation BhbApplyCaController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader2:@"申请转让"];
    self.txtAssignDays.keyboardType = UIKeyboardTypeNumberPad;
    self.txtAssignAmt.keyboardType = UIKeyboardTypeDecimalPad;
    [self.txtPassword setSecureTextEntry:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self myInit];
    [self showActiveLoading];
    
    BaseOperation *op = [[PrjBhbDetailOperation alloc] initWithDelegate:self];
    ((PrjBhbDetailOperation *)op).tiId = self.tiId;
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc{
}

-(void)myInit{
    self.maxAssignAmt = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.minAssignAmt = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.unPaiedBonusAmt = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.waitingDays = 0;
    self.daysRemaining = 0;
    self.maxWaitingDays = 0;
    self.mobileCode = @"";
    self.password = @"";
    self.assignAmt = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.mobile = @"";
    
    NSMutableDictionary *personalInfo = [CacheObject sharedInstance].personalInfo;
    if(personalInfo!=nil){
        self.mobile = [personalInfo objectForKey:@"mobile"];
    }
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendMobileCode)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    [self.lblSendCode setUserInteractionEnabled:YES];
    [self.lblSendCode addGestureRecognizer:singleTap];
}

- (void)sendMobileCode {
        BaseOperation *op = [[SendMobileCodeOperation2 alloc] initWithDelegate:self];
        ((SendMobileCodeOperation2 *)op).mobile = self.mobile;
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code==GET_PRJ_BHB_DETAIL_SUCCESS) {
        NSMutableDictionary *dic = (NSMutableDictionary *)data;
        
        self.maxAssignAmt =  [[NSDecimalNumber decimalNumberWithString:[[dic objectForKey:@"curAmt"] stringValue]] decimalNumberByRoundingAccordingToBehavior:[Utils roundingBehavior]];
        self.minAssignAmt =   [[[NSDecimalNumber decimalNumberWithString:[[dic objectForKey:@"amt"] stringValue]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"0.8"]] decimalNumberByRoundingAccordingToBehavior:[Utils roundingBehavior]];

        self.unPaiedBonusAmt =  [NSDecimalNumber decimalNumberWithString:[[dic objectForKey:@"unPaiedBonusAmt"] stringValue]];
        if (isnan([self.unPaiedBonusAmt floatValue])) {
            self.unPaiedBonusAmt =  [NSDecimalNumber decimalNumberWithString:@"0"];
        }
        
//        self.daysRemaining = [[dic objectForKey:@"daysRemaining"] longValue];
        self.expectedBorrowTime = [[dic objectForKey:@"expectedBorrowTime"] longValue];
        self.borrowDays = [[dic objectForKey:@"borrowDays"] longValue];
        long today = [[NSDate date] timeIntervalSince1970] * 1000;
        self.daysRemaining  = (self.expectedBorrowTime + self.borrowDays * 24 * 60 * 60 * 1000 - today) / (1000 * 24 * 60 * 60);
        
        id p1 = [[NSDecimalNumber alloc] initWithString: [NSString stringWithFormat:@"%@", [dic objectForKey:@"curRate"]]];
        id p2 = [[NSDecimalNumber alloc] initWithString:@"24"];
        if ([p1 compare:p2]>NSOrderedSame) {
            self.lblMoneyRate.text = @"大于24";
        }else{
            self.lblMoneyRate.text = [[Utils nf2] stringFromNumber:[dic objectForKey:@"curRate"]];
        }
        
        self.maxWaitingDays = self.daysRemaining-2>=0?self.daysRemaining-2:0;
        
        self.lblItemNo.text = [dic objectForKey:@"itemNo"];
        self.lblItemShowName.text = [dic objectForKey:@"itemShowName"];
        self.lblRemainingBorrowDays.text = [NSString stringWithFormat:@"%ld", self.daysRemaining];
        
        self.lblUnpaid.text = [[Utils nf2] stringFromNumber:self.unPaiedBonusAmt];
        self.lblCurAmt.text = [[Utils nf2] stringFromNumber:[[NSDecimalNumber decimalNumberWithString:[[dic objectForKey:@"curAmt"] stringValue]] decimalNumberByRoundingAccordingToBehavior:[Utils roundingBehavior]]];
        self.txtAssignDays.placeholder = [NSString stringWithFormat:@"最长转让期%ld", self.maxWaitingDays];
        self.txtAssignAmt.placeholder = [NSString stringWithFormat:@"%@—%@", self.minAssignAmt, self.maxAssignAmt];
        
    }else if (code==SEND_MOBILE_CODE_SUCCESS) {
        NSString *msg = [NSString stringWithFormat:@"手机激活码已发送到手机【%@】上，请注意查收", [Utils formatMobile:self.mobile]];
        [self showAlertWithText:msg];
    }else if (code==CA_APPLY_SUCCESS) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"申请转让成功。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        alert.tag = 2;
        [alert show];
    }else  if (code==NETWORK_ERROR) {
        NSString *msg = ((NSString*)data);
        [self showAlertWithText:msg];
    }
}

- (IBAction)onApply:(id)sender {
    if([self validate]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认提交申请？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 1;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1) {
        if (buttonIndex==1) {
            [self showActiveLoading];
            
            BaseOperation *op = [[BhbCaApplyOperation alloc] initWithDelegate:self];
            ((BhbCaApplyOperation *)op).tiid = [NSString stringWithFormat:@"%d", self.tiId];
            ((BhbCaApplyOperation *)op).mobileCode = self.mobileCode;
            ((BhbCaApplyOperation *)op).pwd = self.password;
            ((BhbCaApplyOperation *)op).assignDays = [NSString stringWithFormat:@"%ld", self.waitingDays];
            ((BhbCaApplyOperation *)op).assignAmount = [NSString stringWithFormat:@"%@", [[NSDecimalNumber decimalNumberWithString:[self.assignAmt stringValue]] decimalNumberByRoundingAccordingToBehavior:[Utils roundingBehavior]]];
            [[AsyncCenter sharedInstance].operationQueue addOperation:op];
            
        }
    }else if (alertView.tag==2) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

-(BOOL) validate{
    self.waitingDays = [[self.txtAssignDays.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] longLongValue];
    self.mobileCode = [self.txtCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.password = [self.txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(!(self.waitingDays>0)){
        [self showAlertWithText:[NSString stringWithFormat:@"有效转让期1—%ld天！", self.maxWaitingDays ]];
        [self.txtAssignDays becomeFirstResponder];
        return false;
    }
    
    if(self.waitingDays>self.maxWaitingDays){
        [self showAlertWithText:[NSString stringWithFormat:@"有效转让期1—%ld天！", self.maxWaitingDays]];
        [self.txtAssignDays becomeFirstResponder];
        return false;
    }
    
    if(self.txtAssignAmt.text.length==0){
        [self showAlertWithText:@"转让标价不能为空！"];
        [self.txtAssignAmt becomeFirstResponder];
        return false;
    }
    
    self.assignAmt = [NSDecimalNumber decimalNumberWithString:self.txtAssignAmt.text];
    if (!([self.assignAmt compare:self.minAssignAmt]>=NSOrderedSame && [self.assignAmt compare:self.maxAssignAmt]<=NSOrderedSame))
    {
        [self showAlertWithText:[NSString stringWithFormat:@"有效转让标价%@—%@！", self.minAssignAmt, self.maxAssignAmt]];
        [self.txtAssignAmt becomeFirstResponder];
        return false;
    }
    
    if(self.mobileCode.length==0){
        [self showAlertWithText:@"手机验证码不能为空！"];
        [self.txtCode becomeFirstResponder];
        return false;
    }
    
    if(self.password.length==0){
        [self showAlertWithText:@"登录密码不能为空！"];
        [self.txtPassword becomeFirstResponder];
        return false;
    }
    
    return true;
}

@end
