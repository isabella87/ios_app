//
//  MyAccountController.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/27.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "MyAccountController.h"
#import "GetBalanceOperation.h"
#import "JxIncomeListController.h"

@implementation MyAccountController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showHeader1];
    [self myInit];
    [AppDelegate setShareHiden:NO];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backIndex:) name:NOTIFY_BACK_INDEX object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toRecharge:) name:NOTIFY_TO_RECHARGE object:nil];
    
    self.tabBarController.tabBarItem.tag = 2;
    
    self.layer1.layer.borderWidth = 1;
    self.layer2.layer.borderWidth = 1;
    self.layer3.layer.borderWidth = 1;
    self.layer4.layer.borderWidth = 1;
    self.layer5.layer.borderWidth = 1;
    self.layer6.layer.borderWidth = 1;
    self.layer7.layer.borderWidth = 1;
    self.layer8.layer.borderWidth = 1;
    self.layer1.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer2.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer3.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer4.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer5.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer6.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer7.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer8.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.layer5.tag = 1;
    self.layer6.tag = 2;
    self.layer7.tag =3;
    self.layer8.tag = 4;
    self.lblLoginName.tag = 5;
    self.lblLoginName.userInteractionEnabled = YES;
    self.imgMessage.tag = 6;
    self.imgMessage.userInteractionEnabled = YES;
    self.imgSettings.tag = 7;
    self.imgSettings.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap2.delegate = self;
    singleTap2.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap3.delegate = self;
    singleTap3.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap4.delegate = self;
    singleTap4.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap5.delegate = self;
    singleTap5.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap6.delegate = self;
    singleTap6.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap7.delegate = self;
    singleTap7.cancelsTouchesInView = NO;
    
    [self.layer5 addGestureRecognizer:singleTap];
    [self.layer6 addGestureRecognizer:singleTap2];
    [self.layer7 addGestureRecognizer:singleTap3];
    [self.layer8 addGestureRecognizer:singleTap4];
    [self.lblLoginName addGestureRecognizer:singleTap5];
    [self.imgMessage addGestureRecognizer:singleTap6];
    [self.imgSettings addGestureRecognizer:singleTap7];

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipeDown];

}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_BACK_INDEX object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_TO_JX object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_TO_RECHARGE object:nil];
}

-(void)backIndex:(NSNotification*)notify
{
    self.tabBarController.selectedIndex = 0;
}

-(void) myInit {
    BaseOperation *op = [[GetAccOperation alloc] initWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    
    BaseOperation *op2 = [[GetAccSurveyOperation alloc] initWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op2];
    
    BaseOperation *op3 = [[GetPersonalInfoOperation alloc] initWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op3];
    
    BaseOperation *op4 = [[GetUnreadMsgCountOperation alloc] initWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op4];
    
    [self performSelector:@selector(queryBalance) withObject:nil afterDelay:0];
    [self performSelector:@selector(queryBalance) withObject:nil afterDelay:10];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code==GET_ACC_SUCCESS) {
        self.lblLoginName.text = [((NSMutableDictionary*)data) objectForKey:@"loginName"];
        
    }else  if (code==GET_ACC_SURVEY_SUCCESS) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * receivingPrincipal = [f numberFromString:[((NSMutableDictionary*)data) objectForKey:@"receivingPrincipal"]];
       
        self.lblFrz.text = [[Utils nf3] stringFromNumber:receivingPrincipal];
        self.lblUnpaid.text = [[Utils nf3] stringFromNumber:[MyAccountController getTotalUnpaid]];
        
    }else  if (code==GET_PERSONAL_INFO_SUCCESS) {
        
    }else  if (code==GET_BALANCE_SUCCESS) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        
        if ([data isEqual:[NSNull null]] || data==nil) {
            self.lblBalance.text = @"0.00";
        }else{
            NSNumber * available = [f numberFromString:[((NSMutableDictionary*)data) objectForKey:@"available"]];
            self.lblBalance.text = [[Utils nf3] stringFromNumber:available];
        }
    }else  if (code==GET_UNREAD_MSG_COUNT_SUCCESS) {
        int unreadCount = [((NSString *)data) intValue];
        if (unreadCount>0) {
            [self.imgMessage setImage:[UIImage imageNamed:@"message_new.png"]];
        }else{
            [self.imgMessage setImage:[UIImage imageNamed:@"message.png"]];
        }
    }else if (code == RESP_LOGIN_SUCCESS) {
        [self myInit];
    }
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    
    UIView *singleTapView = [sender view];
    int tag = singleTapView.tag;
    
    if (tag==1) {
        MyInvestController *controller = (MyInvestController *)[Utils getControllerFromStoryboard:@"MyInvestVC"];
        [self presentViewController:controller animated:NO completion:nil];
        
    }else if (tag==2) {
        RepayPlanController *controller = (RepayPlanController *)[Utils getControllerFromStoryboard:@"RepayPlanVC"];
        [self presentViewController:controller animated:NO completion:nil];
        
    }else if (tag==3) {
//        IncomeListController *controller = (IncomeListController *)[Utils getControllerFromStoryboard:@"IncomeListVC"];
//        [self presentViewController:controller animated:NO completion:nil];
        
        JxIncomeListController *controller = (JxIncomeListController *)[Utils getControllerFromStoryboard:@"JxIncomeListVC"];
        [self presentViewController:controller animated:NO completion:nil];

    }else if (tag==4) {
//        ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebView2VC"];
//        controller.noHeader = YES;
//        controller.hasFooter = YES;
//        controller.myUrl = [NSString stringWithFormat:@"%@app/chinapay-info.html", MOBILE_ADDRESS];
//        
//        [self presentViewController:controller animated:YES completion:nil];
        
        [super getJxUserInfo];
    }else if (tag==5) {
        PersonalInfoController *controller = (PersonalInfoController *)[Utils getControllerFromStoryboard:@"PersonalInfoVC"];
        [self presentViewController:controller animated:YES completion:nil];
        
    }else if (tag==6) {
        ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebViewVC"];
        controller.myTitle = @"消息中心";
        controller.myUrl = [NSString stringWithFormat:@"%@app/message-list.html", MOBILE_ADDRESS];
        
        [self presentViewController:controller animated:YES completion:nil];
    }else if (tag==7) {
        SettingController *controller = (SettingController *)[Utils getControllerFromStoryboard:@"SettingVC"];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (IBAction)toWithdraw:(id)sender {
    ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebView2VC"];
    controller.noHeader = YES;
    controller.hasFooter = YES;
    controller.myUrl = [NSString stringWithFormat:@"%@app/withdraw.html", MOBILE_ADDRESS];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)toRecharge:(id)sender {
    ShowWebViewController *controller = (ShowWebViewController *)[Utils getControllerFromStoryboard:@"WebView2VC"];
    controller.noHeader = YES;
    controller.hasFooter = YES;
    controller.myUrl = [NSString stringWithFormat:@"%@app/recharge.html", MOBILE_ADDRESS];
    
    [self presentViewController:controller animated:YES completion:nil];
}

+ (NSDecimalNumber *) getTotalUnpaid{
    NSDecimalNumber *totalUnpaid = [NSDecimalNumber decimalNumberWithString:@"0"];
    
     NSMutableArray *unpaidList = [[[CacheObject sharedInstance].survey objectForKey:@"preReceiveAmtList"] copy];
    
    for(int i = 0; i<unpaidList.count; ++i){
        NSDecimalNumber *amt = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[[unpaidList objectAtIndex:i] objectForKey:@"amt"]]];
        totalUnpaid = [totalUnpaid decimalNumberByAdding:amt];
    }
    return totalUnpaid;
}

- (void)swipeDown:(UISwipeGestureRecognizer *)gesture {
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionDown) {
        [self showActiveLoading];
        
        NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_USERNAME];
        NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_PASSWORD];
        BaseOperation *op = [[LoginOperation alloc] initWithUsername:userName andWithPassword:password andWithDelegate:self];
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    } else {
        return;
    }
}

- (void) queryBalance{
    BaseOperation *op5 = [[GetBalanceOperation alloc] initWithDelegate:self];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op5];
}

@end
