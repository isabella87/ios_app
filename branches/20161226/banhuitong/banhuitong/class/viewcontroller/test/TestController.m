//
//  TestController.m
//  banhuitong
//
//  Created by user on 16/6/13.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "TestController.h"
//#import "CPController.h"
#import "RSAUtil.h"

//#import <banhuitongSDK/banhuitongSDK.h>
//#import <banhuitongSDK/CommonUtils.h>

@interface TestController ()

@end

@implementation TestController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showHeader2:@"测试"];
//    [CommonUtils sayHello];
    [self Base64Test];
    [self RSATest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doTestCP:(id)sender {
//    CPController* controller = [[CPController alloc] initWithNibName:@"CPController" bundle:nil];
//    [self presentViewController:controller animated:NO completion:nil];
}

-(void)Base64Test
{
    // Create NSData object
    NSData *nsdata = [@"iOS Developer Tips encoded in Base64"
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    // Print the Base64 encoded string
    NSLog(@"Encoded: %@", base64Encoded);
    
    // Let's go the other way...
    
    // NSData from the Base64 encoded str
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:base64Encoded options:0];
    
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    NSLog(@"Decoded: %@", base64Decoded);
}

-(void)RSATest{
    NSString *pubkey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCNWZ4TJGDgyz4IolXMXqFUWdE/LO4upJZbWZKIJpzbftOqGyypx9wymazWg50Mja7m+4xerCQ3NxYk5eVC5Ol3tlHdSBk9aeNSv7iEJOfg95guuQAMidi9JY+KIPZrtjOuS/0abDTC9o4Sp66K4R0gi6yxc1di/sepsbd2XWMNIQIDAQAB";
    NSString *ret = [RSAUtil encryptString: @"中华人民共和国"  publicKey:pubkey];
    NSLog(@"encrypted: %@", ret);
}

@end
