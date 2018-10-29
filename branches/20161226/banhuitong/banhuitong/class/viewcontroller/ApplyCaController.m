//
//  ApplyCaController.m
//  banhuitong
//
//  Created by 陈鲁 on 16/1/15.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "ApplyCaController.h"

@interface ApplyCaController ()

@end

@implementation ApplyCaController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader2:@"申请转让"];
    self.txtAssignDays.keyboardType = UIKeyboardTypeNumberPad;
    self.txtAssignAmt.keyboardType = UIKeyboardTypeDecimalPad;
    self.txtAssignRate.keyboardType = UIKeyboardTypeDecimalPad;
    [self.txtPassword setSecureTextEntry:YES];
    [self.segmentedControl setSelectedSegmentIndex:0];
    [self indexChanged:self.segmentedControl];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self myInit];
    [self showActiveLoading];
    
    BaseOperation *op = [[PrjEntDetailOperation alloc] initWithDelegate:self];
    ((PrjEntDetailOperation *)op).tiId = self.tiId;
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
    self.maxAssignRate = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.minAssignRate = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.capital = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.unpaidAmt = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.waitingDays = 0;
    self.daysRemaining = 0;
    self.maxWaitingDays = 0;
    self.mobileCode = @"";
    self.password = @"";
    self.assignAmt = [NSDecimalNumber decimalNumberWithString:@"0"];;
    self.assignRate = [NSDecimalNumber decimalNumberWithString:@"0"];;
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
    
    if (code==GET_PRJ_ENT_DETAIL_SUCCESS) {
        NSMutableDictionary *dic = (NSMutableDictionary *)data;
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * unpaidAmt = [f numberFromString:[((NSMutableDictionary*)data) objectForKey:@"unpaidAmt"]];
        NSNumber * moneyRate = [f numberFromString:[((NSMutableDictionary*)data) objectForKey:@"moneyRate"]];
        
        self.maxAssignAmt =  [[NSDecimalNumber decimalNumberWithString:[dic objectForKey:@"unpaidAmt"]] decimalNumberByRoundingAccordingToBehavior:[Utils roundingBehavior]];
        self.minAssignAmt =   [[NSDecimalNumber decimalNumberWithString:[dic objectForKey:@"capital"]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"0.8"]];
        self.capital =  [NSDecimalNumber decimalNumberWithString:[dic objectForKey:@"capital"]];
        self.unpaidAmt =  [NSDecimalNumber decimalNumberWithString:[dic objectForKey:@"unpaidAmt"]];
        self.daysRemaining = [[dic objectForKey:@"daysRemaining"] longValue];
        self.maxWaitingDays = self.daysRemaining-2>=0?self.daysRemaining-2:0;
        
        self.maxAssignRate = [Utils getAssignRate:self.capital assignAmount:self.minAssignAmt notReceiveLilv:[self.unpaidAmt decimalNumberBySubtracting:self.capital] days:  [[NSDecimalNumber alloc] initWithLong:self.daysRemaining]];
        
        self.lblItemNo.text = [dic objectForKey:@"itemNo"];
        self.lblItemShowName.text = [dic objectForKey:@"itemShowName"];
        self.lblRemainingBorrowDays.text = [[dic objectForKey:@"daysRemaining"] stringValue];
        self.lblMoneyRate.text = [[Utils nf2] stringFromNumber:moneyRate];
        self.lblUnpaid.text = [[Utils nf2] stringFromNumber:unpaidAmt];
        self.txtAssignDays.placeholder = [NSString stringWithFormat:@"最长转让期%ld", self.maxWaitingDays];
        self.txtAssignRate.placeholder = [NSString stringWithFormat:@"最大值%@", self.maxAssignRate];
        
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

- (IBAction)indexChanged:(UISegmentedControl *)sender {
    
    if(sender.selectedSegmentIndex==0){
        self.lockType = 1;
        [self switchLockType];
    }else if(sender.selectedSegmentIndex==1){
        self.lockType = 2;
        [self switchLockType];
    }
}

- (IBAction)onEndEditAssignRate:(id)sender {
    NSDecimalNumber *assignRate = [NSDecimalNumber decimalNumberWithString:self.txtAssignRate.text];
    if (assignRate==nil || [assignRate isEqualToNumber:[NSDecimalNumber notANumber]]) {
        return;
    }
    
    NSDecimalNumber *assignAmt = [Utils getAssignAmount:self.capital assignRate:assignRate notReceiveLilv:[self.unpaidAmt decimalNumberBySubtracting:self.capital] days:[[NSDecimalNumber alloc] initWithLong:self.daysRemaining]];
    self.lblAssignAmt.text =  [[[NSDecimalNumber decimalNumberWithString:[assignAmt stringValue]] decimalNumberByRoundingAccordingToBehavior:[Utils roundingBehavior]] stringValue];
}

- (IBAction)onEndEditAssignAmt:(id)sender {
    NSDecimalNumber *assignAmt = [NSDecimalNumber decimalNumberWithString:self.txtAssignAmt.text];
    if (assignAmt==nil || [assignAmt isEqualToNumber:[NSDecimalNumber notANumber]]) {
        return;
    }
    
    NSDecimalNumber *assignRate = [Utils getAssignRate:self.capital assignAmount:assignAmt notReceiveLilv:[self.unpaidAmt decimalNumberBySubtracting:self.capital] days:  [[NSDecimalNumber alloc] initWithLong:self.daysRemaining]];
    self.lblAssignRate.text =  [[[NSDecimalNumber decimalNumberWithString:[assignRate stringValue]] decimalNumberByRoundingAccordingToBehavior:[Utils roundingBehavior2]] stringValue];
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
            
            BaseOperation *op = [[CaApplyOperation alloc] initWithDelegate:self];
            ((CaApplyOperation *)op).tiid = [NSString stringWithFormat:@"%d", self.tiId];
            ((CaApplyOperation *)op).mobileCode = self.mobileCode;
            ((CaApplyOperation *)op).pwd = self.password;
            ((CaApplyOperation *)op).assignDays = [NSString stringWithFormat:@"%ld", self.waitingDays];
            ((CaApplyOperation *)op).assignAmount = [NSString stringWithFormat:@"%@", [[NSDecimalNumber decimalNumberWithString:[self.assignAmt stringValue]] decimalNumberByRoundingAccordingToBehavior:[Utils roundingBehavior]]];
            ((CaApplyOperation *)op).isRateLocked = [NSString stringWithFormat:@"%d", self.lockType];
            ((CaApplyOperation *)op).assignRate = [NSString stringWithFormat:@"%@", [[NSDecimalNumber decimalNumberWithString:[self.assignRate stringValue]] decimalNumberByRoundingAccordingToBehavior:[Utils roundingBehavior2]]];
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
    
    if(self.lockType==1){
        if(self.txtAssignRate.text.length==0){
            [self showAlertWithText:@"折算借款年利率不能为空！"];
            [self.txtAssignRate becomeFirstResponder];
            return false;
        }
        
        self.assignRate = [NSDecimalNumber decimalNumberWithString:self.txtAssignRate.text];
        if (!([self.assignRate compare:self.minAssignRate]>=NSOrderedSame && [self.assignRate compare:self.maxAssignRate]<=NSOrderedSame))
        {
            [self showAlertWithText:[NSString stringWithFormat:@"有效折算借款年利率%@—%@！", self.minAssignRate, self.maxAssignRate]];
            [self.txtAssignRate becomeFirstResponder];
            return false;
        }
        
        self.assignAmt = [Utils getAssignAmount:self.capital assignRate:self.assignRate notReceiveLilv:[self.unpaidAmt decimalNumberBySubtracting:self.capital] days:[[NSDecimalNumber alloc] initWithLong:self.daysRemaining]];
        
    }else if(self.lockType==2){
        if(self.txtAssignAmt.text.length==0){
            [self showAlertWithText:@"转让标价不能为空！"];
            [self.txtAssignAmt becomeFirstResponder];
            return false;
        }
        
        self.assignAmt = [NSDecimalNumber decimalNumberWithString:self.txtAssignAmt.text];
        if (!([self.assignAmt compare:self.minAssignAmt]>=NSOrderedSame && [self.assignAmt compare:self.maxAssignAmt]<=NSOrderedSame))
        {
            [self showAlertWithText:[NSString stringWithFormat:@"有效转让标价%@—%@！", self.minAssignAmt,self.maxAssignAmt]];
            [self.txtAssignAmt becomeFirstResponder];
            return false;
        }
        
        self.assignRate = [Utils getAssignRate:self.capital assignAmount:self.assignAmt notReceiveLilv:[self.unpaidAmt decimalNumberBySubtracting:self.capital] days:  [[NSDecimalNumber alloc] initWithLong:self.daysRemaining]];
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


-(void) switchLockType{
    self.lblAssignRate.text = @"";
    self.txtAssignRate.text = @"";
    self.lblAssignAmt.text = @"";
    self.txtAssignAmt.text = @"";
    
    if(self.lockType==1){
        self.lblAssignRate.hidden = YES;
        self.txtAssignRate.hidden = NO;
        self.lblAssignAmt.hidden = NO;
        self.txtAssignAmt.hidden = YES;
        self.txtAssignRate.placeholder = [NSString stringWithFormat:@"最大值%@", self.maxAssignRate];
    }else if(self.lockType==2){
        self.lblAssignRate.hidden = NO;
        self.txtAssignRate.hidden = YES;
        self.lblAssignAmt.hidden = YES;
        self.txtAssignAmt.hidden = NO;
        self.txtAssignAmt.placeholder = [NSString stringWithFormat:@"最大值%@", self.maxAssignAmt];
    }
}

@end
