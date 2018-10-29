//
//  ShowVideoController.h
//  banhuitong
//
//  Created by user on 16-1-13.
//  Copyright (c) 2016年 banhuitong. All rights reserved.
//

#import "BaseViewController.h"
#import <MediaPlayer/MediaPlayer.h>
//#import <AVFoundation/AVFoundation.h>
#import "GetStreamOperation.h"
#import "AsyncCenter.h"

@interface ShowVideoController : BaseViewController

@property (nonatomic) NSString *myUrl, *filePath;
@property (nonatomic) MPMoviePlayerViewController *movie;

@end
