//
//  CustomTabBarViewController.m
//  Navigation
//
//  Created by ym.sun on 16/12/14.
//  Copyright © 2016年 banbank. All rights reserved.
//

#import "CustomTabBarViewController.h"

@interface CustomTabBarViewController ()

@end

@implementation CustomTabBarViewController

{
    AccountViewController *accountViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self ;
    
    for (UITabBarItem *item in self.tabBar.items) {
        //UIControlStateNormal 没有选中的状态，title字体颜色为白色
        //NSDictionary 数据字典，储存键值对儿
        //dictionaryWithObjectsAndKeys 创建键值对儿，firstObject是键值对的值
        //NSForegroundColorAttributeName 设置字体颜色
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Marion-Italic" size:13.0f], NSFontAttributeName, nil] forState:UIControlStateNormal] ;
        //UIControlStateSelected 选中状态，title字体颜色为黄色
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor yellowColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected] ;
        
        switch (item.tag) {
            case 0:
                //imageWithRenderingMode 设置UIImage的渲染模式
                //UIImageRenderingModeAlwaysOriginal 始终绘制图片原始状态，不使用Tint Color
                item.image = [[UIImage imageNamed:@"footer_home@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                item.selectedImage =[[UIImage imageNamed:@"footer_home_highlight@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                break;
                
            case 1:
                item.image = [[UIImage imageNamed:@"footer_product@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                item.selectedImage =[[UIImage imageNamed:@"footer_product_highlight@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                break;
                
            case 2:
                item.image = [[UIImage imageNamed:@"footer_myaccount@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                item.selectedImage =[[UIImage imageNamed:@"footer_myaccount_highlight@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                break;
                
            case 3:
                item.image = [[UIImage imageNamed:@"footer_more@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
                item.selectedImage =[[UIImage imageNamed:@"footer_more_highlight@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
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
//
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    self.tabBarController.delegate = self ;
//}

@end
