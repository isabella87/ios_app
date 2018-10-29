//
//  CustomTabBarViewController.m
//  Navigation
//
//  Created by ym.sun on 16/12/14.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "GuideController.h"

#import "Constants.h"
#import "AsyncCenter.h"
#import "Utils.h"

//定义变量
NSString *trackViewUrl ;

@interface CustomTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation CustomTabBarViewController

{
    AccountViewController *accountViewController;
}

- (void)viewDidAppear:(BOOL)animated {
    
    if ([AppDelegate hasAccess]==NO) {
        GuideController *controller = (GuideController *)[Utils getControllerFromStoryboard:@"guideVC"];
        [self presentViewController:controller animated:YES completion:^{
            
        }];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isDataFromCache = NO ;
    
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(clearCache) name:CLEAR_CACHE object: nil] ;
    
    self.delegate = self ;

    
    for (UITabBarItem *item in self.tabBar.items) {
        //UIControlStateNormal 没有选中的状态，title字体颜色为白色
        //NSDictionary 数据字典，储存键值对儿
        //dictionaryWithObjectsAndKeys 创建键值对儿，firstObject是键值对的值
        //NSForegroundColorAttributeName 设置字体颜色
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:13.0f], NSFontAttributeName, nil] forState:UIControlStateNormal] ;
        //UIControlStateSelected 选中状态，title字体颜色为黄色
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor yellowColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected] ;
        //调节图标上下位置：top、bottom绝对值应相等
        //item.imageInsets = UIEdgeInsetsMake(-10, 0, 10, 0) ;
        [item setImageInsets:UIEdgeInsetsMake(-2, 0, 2, 0)] ;
        //调节title位置
        [item setTitlePositionAdjustment:UIOffsetMake(0, -6)] ;
        
        switch (item.tag) {
            case 0:
                //imageWithRenderingMode 设置UIImage的渲染模式
                //UIImageRenderingModeAlwaysOriginal 始终绘制图片原始状态，不使用Tint Color
                item.image = [[UIImage imageNamed:@"footer_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                item.selectedImage =[[UIImage imageNamed:@"footer_home_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                break;
                
            case 1:
                item.image = [[UIImage imageNamed:@"footer_product"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                item.selectedImage =[[UIImage imageNamed:@"footer_product_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                break;
                
            case 2:
                item.image = [[UIImage imageNamed:@"footer_myaccount"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                item.selectedImage =[[UIImage imageNamed:@"footer_myaccount_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                break;
                
            case 3:
                item.image = [[UIImage imageNamed:@"footer_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                item.selectedImage =[[UIImage imageNamed:@"footer_more_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                break;
                
            default:
                break;
        }
    }
    
    //设置初始化标签栏选项，这里初始化标签栏是账户中心。
    self.selectedIndex = 2 ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 1:
            if (buttonIndex == 1){
                UIApplication *application = [UIApplication sharedApplication];
                [application openURL:[NSURL URLWithString:trackViewUrl]];
            }
            break;
        default:
            break;
    }
}

//单击tabbar刷新当前界面
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    // 再次选中的 tab 页面是之前上一次选中的控制器页面
    if ([viewController isEqual: tabBarController.selectedViewController]) {
        [viewController viewWillAppear:YES] ;
    }
    return YES ;
}

//重写viewDidLayoutSubviews实现设置tabbar的高度
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.tabBar.frame;
    frame.size.height = 64;
    //origin坐标原点
    frame.origin.y = self.view.frame.size.height - frame.size.height;
    
    self.tabBar.frame = frame;
    self.tabBar.backgroundColor = [UIColor whiteColor];//此处背景色可为任意颜色但是不能少
    self.tabBar.barStyle = UIBarStyleBlack;//此处需要设置barStyle，否则颜色会分成上下两层
}

-(void)clearCache{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey: SAVE_USERNAME] ;
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey: SAVE_PASSWORD] ;
    
    //self.accountWebView = nil ;
    
    NSHTTPCookie *cookie ;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage] ;
    for (cookie in [storage cookies]) {
        [storage deleteCookie: cookie] ;
    }
    
    //清楚UIWebView的缓存
    NSURLCache *cache = [NSURLCache sharedURLCache] ;
    [cache removeAllCachedResponses] ;
    [cache setDiskCapacity: 0] ;
    [cache setMemoryCapacity: 0] ;
    
    [self.selectedViewController viewWillAppear: YES] ;
}


@end
