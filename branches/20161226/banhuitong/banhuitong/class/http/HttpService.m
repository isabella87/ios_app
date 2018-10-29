//
//  HttpService.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/23.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "HttpService.h"

@implementation HttpService

-(id)initWithDelegate:(id<NSURLConnectionDelegate>) del{
    self.del = del;
    return self;
}

-(void)requestWithUrl:(NSString *)url
           withHeader:(NSMutableDictionary *)headers
        withParamters:(NSMutableDictionary *)argument
           withMethod:(HTTP_METHOD)method
{
    if (!url)
        return;
    
    NetworkRequest *request = [[NetworkRequest alloc] initWithUrl:url];
    request.method = method;
    request.header = headers;
    self.request = request;
    
    for (NSString *key in argument) {
        [request setParamWithKey:key AndValue:[argument objectForKey:key]];
    }
    
    [self makeRequest];
}

- (void)makeRequest
{
    @autoreleasepool {
        NSMutableString *requestUrl = [NSMutableString stringWithString:self.request.url];
        NSString * queryString = @"1=1";
        
        if([self.request.params count]>0){
            
            NSArray * keys = [self.request.params allKeys];
            for (NSString *key in keys) {
                NSString *value = [self.request.params objectForKey:key];
                queryString = [queryString stringByAppendingFormat:@"&%@=%@", key, value];
            }
            
            if(self.request.method == HTTP_METHOD_GET)
                [requestUrl appendFormat:@"?%@",queryString];
        }
        
        self.del.params = queryString;
        
//        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//            NSLog(@"Cookie: %@", cookie);
//        }
        
        NSURL * encodedUrl = [[NSURL alloc]initWithString:
                              [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSMutableURLRequest * req = [[NSMutableURLRequest alloc]initWithURL:encodedUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:defaultTimeoutSeconds];
        
        if ([self.request.header count] > 0)
            [req setAllHTTPHeaderFields:self.request.header];
        
        if(self.request.method == HTTP_METHOD_POST)
        {
            [req setHTTPMethod:@"POST"];

            NSMutableData *bodyData = [NSMutableData data];
                if(queryString){
                    NSData *postData = [queryString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                    [bodyData appendData:postData];
                }
            
            [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            
            [req setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[bodyData length]] forHTTPHeaderField:@"Content-Length"];
            [req setHTTPBody:bodyData];
            
        }else if(self.request.method == HTTP_METHOD_PUT){
            [req setHTTPMethod:@"PUT"];
            
            NSMutableData *bodyData = [NSMutableData data];
            if(queryString){
                NSData *postData = [queryString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                [bodyData appendData:postData];
            }
            
            [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            
            [req setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[bodyData length]] forHTTPHeaderField:@"Content-Length"];
            [req setHTTPBody:bodyData];
        }
        
        self.del.done = false;
//        [req setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//        [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];

        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self.del startImmediately:NO];
        [conn start];
        
        do {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        } while (!self.del.done);
    }
    
}

@end
