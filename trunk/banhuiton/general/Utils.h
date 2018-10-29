
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"
#import <CommonCrypto/CommonDigest.h>

@class  BaseViewController;

@interface Utils : NSObject


+ (BaseViewController *) getControllerFromStoryboard:(NSString *)identity;

+(void)showMessage:(NSString *)message;

@end
