//
//  CacheService.h
//  banhuitong
//
//  Created by user on 16/2/22.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface CacheService : NSObject{
    sqlite3 *_database;
}

@property (nonatomic) sqlite3 *_database;
-(BOOL) create:(sqlite3 *)db;//创建数据库
-(BOOL) insert:(NSString *)key value:(NSString *)value;//插入数据
-(BOOL) update:(NSString *)key value:(NSString *)value;//更新数据
-(NSMutableArray*)get;//获取全部数据
- (BOOL) delete:(NSString *)key;//删除数据：
- (NSMutableArray*)search:(NSString*)searchString;//查询数据库，searchID为要查询数据的ID，返回数据为查询到的数据

+ (CacheService *)sharedInstance;

@end
