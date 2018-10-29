//
//  HttpResponseDelegate.h
//  banhuitong
//
//  Created by 陈鲁 on 15/12/23.
//  Copyright © 2015年 banhuitong. All rights reserved.
//

#ifndef HttpResponseDelegate_h
#define HttpResponseDelegate_h
#endif /* HttpResponseDelegate_h */

@protocol HttpResponseDelegate

@property (nonatomic) BOOL isDataFromCache;

@required
-(void)callbackWithCode:(int)code andWithData:(NSObject *) data;

@end
