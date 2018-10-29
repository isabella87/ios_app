//
//  BaseOperation.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/23.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "HttpResponseDelegate.h"
#import "Utils.h"
#import "Urls.h"

@interface BaseOperation : NSOperation <NSURLConnectionDelegate>
{
    HTTP_RESPONSE_CODE responseCode;
}

@property(nonatomic, retain)NSMutableURLRequest * httpRequest;

@property(nonatomic, retain)NSHTTPURLResponse * httpResponse;

@property(nonatomic,retain)NSMutableData * requestData;

@property(nonatomic,strong)NSMutableDictionary * headers;

@property(nonatomic) BOOL done;

@property(nonatomic)id<HttpResponseDelegate> httpResponseDelegate;

@property(nonatomic) NSString *params;

@property(nonatomic) NSString *savedUsername;
@property(nonatomic) NSString *savedPassword;

-(id)initWithDelegate:(id<HttpResponseDelegate>)del;

@end
