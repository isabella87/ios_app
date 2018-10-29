//
//  MoreController.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/29.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "MoreController.h"
#import <Photos/Photos.h>

BOOL booSignedRcode;

@implementation MoreController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showHeader1];
    
    if ([AppDelegate isLogin] ) {
        BaseOperation *op = [[GetCryptMobileOperation alloc] initWithDelegate:self];
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
        [self getRcode];
    }else{
//        [self makeShare];
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.tabBarController.tabBarItem.tag = 3;
    
    self.layer1.tag = 1;
    self.layer2.tag = 2;
    self.layer3.tag = 3;
    self.layer4.tag = 4;
    self.layer5.tag = 5;
    self.imgRCode.tag = 6;
    
    self.imgRCode.userInteractionEnabled = YES;
    
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
    
    [self.layer1 addGestureRecognizer:singleTap];
    [self.layer2 addGestureRecognizer:singleTap2];
    [self.layer3 addGestureRecognizer:singleTap3];
    [self.layer4 addGestureRecognizer:singleTap4];
    [self.layer5 addGestureRecognizer:singleTap5];
    [self.imgRCode addGestureRecognizer:singleTap6];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
    self.srvMain.contentSize = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT);
}

- (void) dealloc{
}

- (IBAction) tappedLeftButton:(id)sender
{
    
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    if (selectedIndex > 0) {
        
        selectedIndex--;
        
        if (selectedIndex==2) {
            if(![AppDelegate isLogin]) {
                LoginController *controller = (LoginController *)[Utils getControllerFromStoryboard:@"LoginVC"];
                [self presentViewController:controller animated:NO completion:nil];
                
                return;
            }
        }
        
        UIView *fromView = [self.tabBarController.selectedViewController view];
        
        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex] view];
        
        [UIView transitionFromView:fromView toView:toView duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            if (finished) {
                [self.tabBarController setSelectedIndex:selectedIndex];
            }
        }];
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender{
    
    UIView *singleTapView = [sender view];
    long tag = singleTapView.tag;
    [AppDelegate setShareHiden:YES];
    
    if (tag==1) {
        AboutusController *controller = (AboutusController *)[Utils getControllerFromStoryboard:@"AboutusVC"];
        [self presentViewController:controller animated:NO completion:nil];
        
    }else if (tag==2) {
        
        ShowVideoController *controller = (ShowVideoController *)[Utils getControllerFromStoryboard:@"ShowVideoVC"];
        controller.myUrl = [NSString stringWithFormat:@"%@%@", MOBILE_ADDRESS, @"web/video/register.mp4"];
        [self presentViewController:controller animated:NO completion:nil];
        
    }else if (tag==3) {
       [self makeShare];
        
    }else if (tag==4) {
        AboutController *controller = (AboutController *)[Utils getControllerFromStoryboard:@"AboutVC"];
        [self presentViewController:controller animated:NO completion:nil];
        
    }else if (tag==5) {
        [self exitApplication];
        
    }else if (tag==6) {
        [self getRcode];
    }
}

- (void)swipe:(UISwipeGestureRecognizer *)gesture {
    
    NSInteger currentIndex = self.tabBarController.selectedIndex;
    
    CATransition *transaction = [CATransition animation];
    transaction.type = kCATransitionPush;
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        return;
    } else {
        if (currentIndex==3) {
            if(![AppDelegate isLogin]) {
                LoginController *controller = (LoginController *)[Utils getControllerFromStoryboard:@"LoginVC"];
                [self presentViewController:controller animated:NO completion:nil];
                
                return;
            }
        }
        
        [transaction setSubtype:kCATransitionFromLeft];
        self.tabBarController.selectedIndex = currentIndex - 1;
    }
    
    transaction.duration = 0.5;
    transaction.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [[self.tabBarController.view layer] addAnimation:transaction forKey:@"switchView"];
}

//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code==GET_CRYPT_MOBILE_SUCCESS) {
        if (![data isMemberOfClass:[NSNull class]]) {
            self.rcode = [((NSMutableDictionary *)data) objectForKey:@"rcode"];
//            if ([AppDelegate isShareHiden]!=YES) {
//                 [self makeShare];
//            }
        }
    }else if (code==GET_QRCODE_SUCCESS) {
        UIImage *img = [UIImage imageWithData: (NSData *)data];
        self.imgRCode.image = [Utils scaleImage:img toScale:0.75];
        [self saveImage:img];
    }
}

- (void)saveImage:(UIImage*)img{
    __block NSString *assetId = [[NSUserDefaults standardUserDefaults] objectForKey:ASSET_ID];
    
    if (assetId==nil) {
        // 1. 存储图片到"相机胶卷"
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            assetId = [PHAssetCreationRequest creationRequestForAssetFromImage:img].placeholderForCreatedAsset.localIdentifier;
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                NSLog(@"保存图片到相机胶卷中失败");
                return;
            }
            
            NSLog(@"成功保存图片到相机胶卷中");
            [[NSUserDefaults standardUserDefaults] setObject:assetId forKey:ASSET_ID];
        }];
    }else{
        PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
        
        if (asset==nil) {
            // 1. 存储图片到"相机胶卷"
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                assetId = [PHAssetCreationRequest creationRequestForAssetFromImage:img].placeholderForCreatedAsset.localIdentifier;
                
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"保存图片到相机胶卷中失败");
                    return;
                }
                
                NSLog(@"成功保存图片到相机胶卷中");
                [[NSUserDefaults standardUserDefaults] setObject:assetId forKey:ASSET_ID];
                
            }];
        }
    }
}

/**
 *  返回相册
 */
- (PHAssetCollection *)collection{
    NSString *BSCollectionName = @"banhuitong";
    
    // 先获得之前创建过的相册
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:BSCollectionName]) {
            return collection;
        }
    }
    
    // 如果相册不存在,就创建新的相册(文件夹)
    __block NSString *collectionId = nil; // __block修改block外部的变量的值
    // 这个方法会在相册创建完毕后才会返回
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 新建一个PHAssertCollectionChangeRequest对象, 用来创建一个新的相册
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:BSCollectionName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
}

-(void) getRcode{
    booSignedRcode = !booSignedRcode;
    
//    NSString *url = [NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS_P2P, @"reg/rq-code-pic?disp-name=", booSignedRcode?@"true":@"false" ];
    
    NSString *baseUrl = URL_11;
    NSString *url = [NSString stringWithFormat:@"%@%@%@", baseUrl, @"?disp-name=", booSignedRcode?@"true":@"false" ];
    
    BaseOperation *op = [[GetStreamOperation alloc] initWithDelegate:self andWithUrl:url andWithCallbackCode:GET_QRCODE_SUCCESS];
    [[AsyncCenter sharedInstance].operationQueue addOperation:op];
}

@end


