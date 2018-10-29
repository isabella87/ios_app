//
//  ShowVideoController.m
//  banhuitong
//
//  Created by user on 16-1-13.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "ShowVideoController.h"

@interface ShowVideoController ()

@end

@implementation ShowVideoController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader2:@"注册流程视频演示"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *videoPath = self.myUrl;
    
    if (videoPath == NULL)return;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.filePath = [documentsDirectory stringByAppendingPathComponent:@"/register.mp4"] ;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:self.filePath]) {
        [self startActivityIndicator];
        BaseOperation *op = [[GetStreamOperation alloc] initWithDelegate:self andWithUrl:self.myUrl andWithCallbackCode:GET_REG_VIDEO_SUCCESS];
        [[AsyncCenter sharedInstance].operationQueue addOperation:op];
    }else{
        [self startActivityIndicator];
        [self performSelector:@selector(stopActivityIndicator) withObject:nil afterDelay:2];
    }
}

- (void) dealloc{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) initAndPlay:(NSString *)videoURL
{
    if ([videoURL rangeOfString:@"http://"].location!=NSNotFound||[videoURL rangeOfString:@"https://"].location!=NSNotFound)
    {
        NSURL *URL = [[NSURL alloc] initWithString:videoURL];
        if (URL) {
            if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 3.2)
            {
                MPMoviePlayerViewController* tmpMoviePlayViewController=[[MPMoviePlayerViewController alloc] initWithContentURL:URL];
                if (tmpMoviePlayViewController)
                {
                    self.movie=tmpMoviePlayViewController;
                     [self.movie.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
                    [self.movie.view setFrame:CGRectMake(0, 50, SCREEN_WIDTH, 300)];
                    [self.view addSubview:self.movie.view];
                    self.movie.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
                }
            }
            
            //视频播放完成通知
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackDidFinish) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
        }
    }
}

-(void) initAndPlay2:(NSString *)videoURL
{
        NSURL *URL = [NSURL fileURLWithPath:videoURL];
        if (URL) {
            if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 3.2)
            {
                MPMoviePlayerViewController* tmpMoviePlayViewController=[[MPMoviePlayerViewController alloc] initWithContentURL:URL];
                if (tmpMoviePlayViewController)
                {
                    self.movie=tmpMoviePlayViewController;
                    [self.movie.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
                    [self.movie.view setFrame:CGRectMake(0, 70, SCREEN_WIDTH, 300)];
                    [self.view addSubview:self.movie.view];
                }
            }
            
            //视频播放完成通知
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackDidFinish) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
        }
}

//视频播放完成后事件
- (void) playbackDidFinish
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    if (self.movie){
        [self.movie.moviePlayer stop];
        self.movie.moviePlayer.initialPlaybackTime=-1.0;
//        [self.movie.moviePlayer play];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations{
    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    
    
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            //home健在下
            [self.movie.view setFrame:CGRectMake(0, 70, SCREEN_WIDTH, 300)];
            self.headerView.hidden = NO;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            //home健在上
            break;
        case UIInterfaceOrientationLandscapeLeft:
            //home健在左
            [self.movie.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            self.headerView.hidden = YES;
            break;
        case UIInterfaceOrientationLandscapeRight:
            //home健在右
            [self.movie.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            self.headerView.hidden = YES;
            break;
        default:
            break;
    }
}

-(void)callbackWithCode:(int)code andWithData:(NSObject *) data{
    [self hideActiveLoading];
    [super callbackWithCode:code andWithData:data];
    
    if (code==GET_REG_VIDEO_SUCCESS) {
        if([(NSData *)data writeToFile: self.filePath atomically:NO]){
            [super stopActivityIndicator];
            [self initAndPlay2:self.filePath];
        }
    }
}

-(void) stopActivityIndicator{
    if (self.activityIndicator!=nil) {
        [super stopActivityIndicator];
    }
    [self initAndPlay2:self.filePath];
}

@end
