//
//  MyPageViewController.m
//  banhuitong
//
//  Created by 陈鲁 on 16/2/6.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "MyPageViewController.h"

@interface MyPageViewController ()

@end

@implementation MyPageViewController

@synthesize pageContent = _pageContent;
@synthesize pageController = _pageController;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)dealloc{
    _pageContent = nil;
    _pageController = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.index = 0;
    
    [self createContentPages];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
        navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    _pageController.dataSource = self;

    [[_pageController view] setFrame:[[self view] bounds]];
    
    IndexController2 *controller = (IndexController2 *)[Utils getControllerFromStoryboard:@"IndexVC"];
    controller.dataObject =[self.pageContent objectAtIndex:0];
    
    MainViewController2 *controller2 = (MainViewController2 *)[Utils getControllerFromStoryboard:@"MainVC"];
    controller2.dataObject =[self.pageContent objectAtIndex:1];
    
    MyAccountController2 *controller3 = (MyAccountController2 *)[Utils getControllerFromStoryboard:@"MyAccountVC"];
    controller3.dataObject =[self.pageContent objectAtIndex:2];
    
    MoreController2 *controller4 = (MoreController2 *)[Utils getControllerFromStoryboard:@"MoreVC"];
    controller4.dataObject =[self.pageContent objectAtIndex:3];
    
    self.viewControllers =[NSArray arrayWithObjects:controller, nil];
    
    [_pageController setViewControllers:self.viewControllers
       direction:UIPageViewControllerNavigationDirectionForward 
                               animated:NO
                             completion:nil];
    
    self.viewControllers = [self.viewControllers arrayByAddingObject:controller2];
    self.viewControllers = [self.viewControllers arrayByAddingObject:controller3];
    self.viewControllers = [self.viewControllers arrayByAddingObject:controller4];
    
    // 在页面上，显示UIPageViewController对象的View
    [self addChildViewController:_pageController];
    [[self view] addSubview:[_pageController view]];
    
    if([AppDelegate isLogin]) {
        NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_USERNAME];
        NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_PASSWORD];
        
        BaseOperation *op = [[LoginOperation alloc] initWithUsername:userName andWithPassword:password andWithDelegate:self];
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    }
    
    [self showHeader1];
    [self showFooter];
    [self refreshFooter:self.index];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handle:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handle:)];
    singleTap2.delegate = self;
    singleTap2.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handle:)];
    singleTap3.delegate = self;
    singleTap3.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handle:)];
    singleTap4.delegate = self;
    singleTap4.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* singleTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handle:)];
    singleTap5.delegate = self;
    singleTap5.cancelsTouchesInView = NO;
    singleTap5.numberOfTapsRequired = 1;
    singleTap5.numberOfTouchesRequired = 1;
    
    self.footerImage1.tag = 0;
    self.footerImage1.userInteractionEnabled = YES;
    [self.footerImage1 addGestureRecognizer:singleTap];
    
    self.footerImage2.tag = 1;
    self.footerImage2.userInteractionEnabled = YES;
    [self.footerImage2 addGestureRecognizer:singleTap2];
    
    self.footerImage3.tag = 2;
    self.footerImage3.userInteractionEnabled = YES;
    [self.footerImage3 addGestureRecognizer:singleTap3];
    
    self.footerImage4.tag = 3;
    self.footerImage4.userInteractionEnabled = YES;
    [self.footerImage4 addGestureRecognizer:singleTap4];
    
    self.headerView.tag = 4;
    self.headerView.userInteractionEnabled = YES;
    [self.headerView addGestureRecognizer:singleTap5];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectPageNotification:) name:@"selectPageNotification" object:nil];
}

- (void) createContentPages {
    NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 4; i++){
        NSString *contentString = [[NSString alloc] initWithFormat:@"This is the page %d", i];
        [pageStrings addObject:contentString];
    }
    self.pageContent = [[NSArray alloc] initWithArray:pageStrings];
}

- (NSUInteger)indexOfViewController:(BaseViewController *)viewController {
    return [self.pageContent indexOfObject:viewController.dataObject];
}

#pragma mark- UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSInteger index = [self indexOfViewController:(BaseViewController *)viewController];
    NSLog(@"before:%lu",(unsigned long)index);
    
    if ((index == 0) || (index == NSNotFound)) {
        [self refreshFooter:index];
        return nil;
    }else if (index==2){
        if(![AppDelegate isLogin]) {
            LoginController *controller = (LoginController *)[Utils getControllerFromStoryboard:@"LoginVC"];
            [self presentViewController:controller animated:NO completion:nil];
            
            return nil;
        }
    }
    
    [self refreshFooter:index];
    index--;
    
    return [self.viewControllers objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger index = [self indexOfViewController:(BaseViewController *)viewController];
    
    NSLog(@"after:%lu",(unsigned long)index);
    
    if (index == NSNotFound) {
        return nil;
    }else if (index==2){
        if(![AppDelegate isLogin]) {
            LoginController *controller = (LoginController *)[Utils getControllerFromStoryboard:@"LoginVC"];
            [self presentViewController:controller animated:NO completion:nil];
                
            return nil;
        }
    }
    
    [self refreshFooter:index];
    index++;
    
    if (index == [self.pageContent count]) {
        return nil;
    }
    
    return [self.viewControllers objectAtIndex:index];
}

-(void)handle:(UITapGestureRecognizer *)sender{
    UIView *singleTapView = [sender view];
    long tag = singleTapView.tag;
    
    if (tag==4) {
        tag=0;
    }else if(tag==2){
        if(![AppDelegate isLogin]) {
            LoginController *controller = (LoginController *)[Utils getControllerFromStoryboard:@"LoginVC"];
            [self presentViewController:controller animated:NO completion:nil];
            
            return;
        }
    }
    
    [self.pageController setViewControllers:[NSArray arrayWithObject:self.viewControllers[tag]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    [self refreshFooter:tag];
}

-(void)selectPageNotification:(NSNotification*)notification{
    
    NSDictionary *nameDictionary = [notification userInfo];
    int index = [[nameDictionary objectForKey:@"index"] intValue];
    int tab = [[nameDictionary objectForKey:@"tab"] intValue];
    
    if (index==1) {
        MainViewController2 *controller = self.viewControllers[index];
        [MainViewController2 setTab:tab];
        controller.didLoad = NO;
    }
    
    [self.pageController setViewControllers:[NSArray arrayWithObject:self.viewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    [self refreshFooter:index];
}

@end
