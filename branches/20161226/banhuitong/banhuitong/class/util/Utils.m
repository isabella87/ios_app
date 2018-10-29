
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>


@interface Utils ()
{
    NSDateFormatter     *dateFormatter;
}
@end

static NSNumberFormatter *numberFormatter;
static NSDateFormatter *dateFormatter;

@implementation Utils

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
                                
    return scaledImage;
}

//裁剪图片
+ (UIImage *)cutImage:(UIImage*)image
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (SCREEN_WIDTH / SCREEN_HEIGHT)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * SCREEN_HEIGHT / SCREEN_WIDTH;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * SCREEN_WIDTH / SCREEN_HEIGHT;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    UIImage *_image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return _image;
}

+(void)showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((SCREEN_WIDTH - LabelSize.width - 20)/2, SCREEN_HEIGHT - 100, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:2.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

+ (NSNumberFormatter *)getNumberFormatterWithFormatString:(NSString*) fmt
{
    numberFormatter = [[NSNumberFormatter alloc] init];
    if (fmt!=nil && [fmt isEqualToString:@""]==NO) {
         [numberFormatter setPositiveFormat:fmt];
    }
    return numberFormatter;
}

+ (NSString *) formatMobile:(NSString *) mobile;{
    NSString *str1 = [mobile substringWithRange:NSMakeRange(0,3)];
    NSString *str2 = [mobile substringWithRange:NSMakeRange(8,3)];
    return [NSString stringWithFormat:@"%@****%@", str1, str2];
}

+ (NSDateFormatter *)getDateFormatterWithString:(NSString*) fmt
{
    dateFormatter = [[NSDateFormatter alloc] init];
    if (fmt!=nil && [fmt isEqualToString:@""]==NO) {
        dateFormatter.dateFormat = fmt;
    }
    return dateFormatter;
}

+ (NSDictionary *) getBonusType{
    return  [NSDictionary dictionaryWithObjectsAndKeys:
             @"利息",@"0",
             @"本金",@"1",
             @"普通资金\r期间分红",@"2",
             @"第三方担保资金\r期间分红",@"3",
             @"普通资金\r本金",@"4",
             @"普通资金\r收益",@"5",
             @"第三方担保资金\r本金",@"6",
             @"第三方担保资金\r补贴",@"7",
             @"普通资金\r盈余分红",@"8",
             @"第三方担保资金\r盈余分红",@"9",
             nil];
}

+ (NSString *) getAppVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (float) getIOSVersion{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return version;
}

+ (BaseViewController *)getControllerFromStoryboard:(NSString *)identity
{
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    BaseViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:identity];
    
    return controller;
}

+ (NSDecimalNumber *) getAssignRate:(NSDecimalNumber *) creditAmount
                       assignAmount:(NSDecimalNumber *) assignAmount
                     notReceiveLilv:(NSDecimalNumber *) notReceiveLilv
                               days:(NSDecimalNumber*) days
{
    NSDecimalNumber *daysOfYear = [NSDecimalNumber decimalNumberWithString:@"365"];
    
    NSDecimalNumberHandler *round = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                               scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *temp = [[creditAmount decimalNumberByAdding:notReceiveLilv] decimalNumberBySubtracting:assignAmount];
    
    if ([temp compare:[NSDecimalNumber decimalNumberWithString:@"0"]]>NSOrderedAscending) {
        
        NSDecimalNumber *assignRate = [[[temp decimalNumberByMultiplyingBy:daysOfYear] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]] decimalNumberByDividingBy:[assignAmount decimalNumberByMultiplyingBy:days] withBehavior:round];
        return assignRate;
    }
    return [NSDecimalNumber decimalNumberWithString:@"0"];
}

+ (NSDecimalNumber *) getAssignAmount:(NSDecimalNumber *) creditAmount
                       assignRate:(NSDecimalNumber *) assignRate
                       notReceiveLilv:(NSDecimalNumber *) notReceiveLilv
                        days:(NSDecimalNumber*) days
{
    NSDecimalNumber *daysOfYear = [NSDecimalNumber decimalNumberWithString:@"365"];
    
    NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                               scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];

    NSDecimalNumber *temp = [creditAmount decimalNumberByAdding:notReceiveLilv];
        NSDecimalNumber *assignAmount = [[[temp decimalNumberByMultiplyingBy:daysOfYear] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]] decimalNumberByDividingBy:[[assignRate decimalNumberByMultiplyingBy:days] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"36500"]]  withBehavior:roundDown];
        return assignAmount;
}

+(NSNumberFormatter *) nf{
    return [Utils getNumberFormatterWithFormatString:@"###,##0"] ;
}

+(NSNumberFormatter *) nf2{
     return  [Utils getNumberFormatterWithFormatString:@"###,##0.##"] ;
}

+(NSNumberFormatter *) nf3{
    return [Utils getNumberFormatterWithFormatString:@"###,##0.00"] ;
}

+(NSDecimalNumberHandler *) roundingBehavior{
    return [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
}

+(NSDecimalNumberHandler *) roundingBehavior2{
     return [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
}

+(NSDecimalNumberHandler *) roundingBehavior3{
     return [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
}

+(NSDateFormatter *) df{
    return [Utils getDateFormatterWithString:@"yyyy-MM-dd"];
}

+(NSString *)readCurrentCookie{
    NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSMutableString *cookieString = [[NSMutableString alloc] init];
    
//    NSMutableString *domain = [[NSMutableString alloc] initWithString:SERVER_DOMAIN];
    NSMutableString *domain = @"";

    NSArray *domainArr = [domain componentsSeparatedByString:@":"];
    NSMutableString *domainString = [NSMutableString stringWithString:domainArr[1]];
    [domainString deleteCharactersInRange:NSMakeRange(0, 2)];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        if ([cookie.domain isEqualToString:domainString]) {
            //多个字段之间用“；”隔开
            [cookieString appendFormat:@"%@=%@;",cookie.name,cookie.value];
        }
        
    }
    //删除最后一个“；”
    [cookieString deleteCharactersInRange:NSMakeRange(cookieString.length - 1, 1)];
    return cookieString;
}

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

@end
