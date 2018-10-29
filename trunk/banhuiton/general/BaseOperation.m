//
//  BaseOperation.m
//  banhuitong
//
//  Created by 陈鲁 on 15/12/23.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import "BaseOperation.h"

@implementation BaseOperation

-(id)initWithDelegate:(id<HttpResponseDelegate>)del{
    self.httpResponseDelegate = del;
    self.headers = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"gzip", @"Accept-Encoding", @"application/json", @"Accept", nil];
    self.savedUsername =  [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_USERNAME];
    self.savedPassword = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_PASSWORD];
    return [super init];
}

-(void)delegateDispatch{

}

- (void) dealloc{
    self.httpRequest = nil;
    self.httpResponse = nil;
    self.requestData = nil;
    self.headers = nil;
    self.httpResponseDelegate = nil;
}

#pragma mark NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    if (self.requestData != nil) {
        [self.requestData appendData:data];
    }else {
        NSMutableData * receivedData = [[NSMutableData alloc]initWithData:data];
        self.requestData = 	receivedData;
    }
    NSLog(@"ResponseData: %@", [[NSString alloc] initWithData:self.requestData encoding:NSUTF8StringEncoding]);
    NSLog(@"===================================================", nil);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    _done = true;
    [self.httpResponseDelegate callbackWithCode:NETWORK_ERROR  andWithData:nil];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    if ([self isCancelled])
    {
        return;
    }
    
    responseCode = (HTTP_RESPONSE_CODE)[self.httpResponse statusCode];
    
    if (responseCode == HTTP_RESPONSE_CODE_OK) {
        [self performSelectorOnMainThread:@selector(delegateDispatch) withObject:nil waitUntilDone:YES];
    }else{
        NSString *data = [[NSString alloc] initWithData:self.requestData encoding:NSUTF8StringEncoding];
        NSString *msg = @"";
        if ([data containsString:@"*"]) {
            NSRange range = [data rangeOfString:@"*"];
            msg = [data substringFromIndex:NSMaxRange(range)];
        }else{
            msg = data;
        }
        [self.httpResponseDelegate callbackWithCode:NETWORK_ERROR andWithData:msg];
    }
    
    _done = true;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse * res = (NSHTTPURLResponse *)response;
    responseCode = (HTTP_RESPONSE_CODE)[res statusCode];
    self.httpResponse = res;
    
    NSLog(@"===================================================", nil);
    NSLog(@"ResquestUrl = %@",self.httpResponse.URL);
    NSLog(@"ResquestParams = %@",self.params);
    NSLog(@"ResponseCode = %d",responseCode);
}

@end
