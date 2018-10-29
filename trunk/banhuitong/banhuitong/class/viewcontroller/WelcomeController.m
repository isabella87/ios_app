//
//  WelcomeController.m
//  banhuitong
//
//  Created by 陈鲁 on 16/1/23.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "WelcomeController.h"
#import "GetPersonalInfoOperation.h"

@interface WelcomeController ()

@property(nonatomic) UIImageView *bgView;
@property(nonatomic) UIProgressView *progressView;
@property(nonatomic) NSTimer *myTimer;

@end

@implementation WelcomeController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void) viewDidAppear:(BOOL)animated{
    if ([AppDelegate hasAccess]==NO) {
        GuideController *controller = (GuideController *)[Utils getControllerFromStoryboard:@"GuideVC"];
        [self presentViewController:controller animated:YES completion:^{
            
        }];
        
    }else{
        self.bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.bgView.image = [UIImage imageNamed:@"launch.jpg"];
        self.bgView.image = [Utils cutImage:self.bgView.image];
        [self.view addSubview:self.bgView];
        [self performSelector:@selector(toMain) withObject:nil afterDelay:4.0f];
        
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT - 100, SCREEN_WIDTH/2, 20)];
        self.progressView.progress = 0.025;
        //设置进度条颜色
        self.progressView.trackTintColor = [UIColor orangeColor];
        //设置进度条上进度的颜色
        self.progressView.progressTintColor = [UIColor whiteColor];
        [self.view addSubview:self.progressView];
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                   target:self
                                                 selector:@selector(doProgress)
                                                 userInfo:nil
                                                  repeats:YES];
    }
    
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([AppDelegate isLogin]) {
        NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_USERNAME];
        NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_PASSWORD];
        
        BaseOperation *op = [[LoginOperation alloc] initWithUsername:userName andWithPassword:password andWithDelegate:self];
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    }else{
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) dealloc{
}

-(void) toMain{
    CustomTabBarViewController *controller = (CustomTabBarViewController *)[Utils getControllerFromStoryboard:@"CustomTabBarVC"];
//    MyPageViewController *controller = (MyPageViewController *)[Utils getControllerFromStoryboard:@"MyPageVC"];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)doProgress{
    self.progressView.progress += 0.025; // 设定步进长度
    if (self.progressView.progress == 1.0) {
        [self.myTimer invalidate];
    }
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    if (code == RESP_LOGIN_SUCCESS) {
        NSLog(@"登录成功",nil);
        BaseOperation *op = [[GetPersonalInfoOperation alloc] initWithDelegate:self];
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    }
}

@end
