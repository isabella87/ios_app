
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"
#import <CommonCrypto/CommonDigest.h>

@class  BaseViewController;

@interface Utils : NSObject

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
+ (UIImage *)cutImage:(UIImage*)image;

+(void)showMessage:(NSString *)message view:(UIView *) view;

+ (NSDecimalNumber *) getAssignRate:(NSDecimalNumber *) creditAmount
                       assignAmount:(NSDecimalNumber *) assignAmount
                     notReceiveLilv:(NSDecimalNumber *) notReceiveLilv
                               days:(NSDecimalNumber*) days;

+ (NSDecimalNumber *) getAssignAmount:(NSDecimalNumber *) creditAmount
                           assignRate:(NSDecimalNumber *) assignRate
                       notReceiveLilv:(NSDecimalNumber *) notReceiveLilv
                                 days:(NSDecimalNumber*) days;

+ (NSString *) formatMobile:(NSString *) mobile;
+ (NSString *) getAppVersion;
+ (float) getIOSVersion;
+ (NSDictionary*) getBonusType;
+ (NSNumberFormatter *) getNumberFormatterWithFormatString:(NSString*) fmt;
+ (NSDateFormatter *) getDateFormatterWithString:(NSString*) fmt;
+ (BaseViewController *) getControllerFromStoryboard:(NSString *)identity;

+(NSNumberFormatter *) nf;
+(NSNumberFormatter *) nf2;
+(NSNumberFormatter *) nf3;

+(NSDecimalNumberHandler *) roundingBehavior;
+(NSDecimalNumberHandler *) roundingBehavior2;
+(NSDecimalNumberHandler *) roundingBehavior3;

+(NSDateFormatter *) df;

+(NSString *)readCurrentCookie;
+(void)showMessage:(NSString *)message;

+ (NSString *)md5:(NSString *)str;

@end
