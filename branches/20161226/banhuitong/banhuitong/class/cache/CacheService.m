//
//  CacheService.m
//  banhuitong
//
//  Created by user on 16/2/22.
//  Copyright © 2016年 banhuitong. All rights reserved.
//

#import "CacheService.h"

@implementation CacheService

static CacheService * sharedNC = nil;

- (void) dealloc{
    
}

+ (CacheService *)sharedInstance
{
    @synchronized(self)
    {
        if (!sharedNC)
            sharedNC = [[CacheService alloc] init];
    }
    
    return(sharedNC);
}

@synthesize _database;

-(id) init
{
    [self openDB];
    return self;
};

//获取document目录并返回数据库目录
- (NSString *)dataFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    documentsDirectory = @"/Users/user";
    return [documentsDirectory stringByAppendingPathComponent:@"banhuitong.db"];
}

//创建，打开数据库
- (BOOL)openDB {
    
    //获取数据库路径
    NSString *path = [self dataFilePath];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断数据库是否存在
    BOOL find = [fileManager fileExistsAtPath:path];
    
    if (find) {
        
        if(sqlite3_open([path UTF8String], &_database) != SQLITE_OK) {
            
            //如果打开数据库失败则关闭数据库
            sqlite3_close(self._database);
            NSLog(@"Error: open database file.");
            return NO;
        }
        
        //创建一个新表
        [self create:self._database];
        
        return YES;
    }

    if(sqlite3_open([path UTF8String], &_database) == SQLITE_OK) {
        
        //创建一个新表
        [self create:self._database];
        return YES;
    } else {
        //如果创建并打开数据库失败则关闭数据库
        sqlite3_close(self._database);
        NSLog(@"Error: open database file.");
        return NO;
    }
    return NO;
}

//创建表
- (BOOL) create:(sqlite3*)db {
    
    char *sql = "create table if not exists tb_json(key text PRIMARY KEY, value text, datepoint text)";
    sqlite3_stmt *statement;

    NSInteger sqlReturn = sqlite3_prepare_v2(_database, sql, -1, &statement, nil);
    
    //如果SQL语句解析出错的话程序返回
    if(sqlReturn != SQLITE_OK) {
        NSLog(@"Error: failed to prepare statement:create test table");
        return NO;
    }
    
    //执行SQL语句
    int success = sqlite3_step(statement);
    //释放sqlite3_stmt
    sqlite3_finalize(statement);
    
    //执行SQL语句失败
    if ( success != SQLITE_DONE) {
        NSLog(@"Error: failed to dehydrate:create table test");
        return NO;
    }
    NSLog(@"Create table 'testTable' successed.");
    return YES;
}

//插入数据
-(BOOL) insert:(NSString *)key value:(NSString *)value {
    
    //先判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement;
        
        static char *sql = "INSERT INTO tb_json(key, value, datepoint) VALUES(?, ?, ?)";
        
        int success2 = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success2 != SQLITE_OK) {
            NSLog(@"Error: failed to insert:tb_json");
            sqlite3_close(_database);
            return NO;
        }

        sqlite3_bind_text(statement, 1,  [key UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [value UTF8String], -1, SQLITE_TRANSIENT);
         long ll = [[NSDate date] timeIntervalSince1970] ;
        sqlite3_bind_text(statement, 3, [[NSString stringWithFormat:@"%ld", ll] UTF8String], -1, SQLITE_TRANSIENT);
//        sqlite3_bind_int64(statement, 3, [[NSDate date] timeIntervalSince1970]);
        
        //执行插入语句
        success2 = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果插入失败
        if (success2 == SQLITE_ERROR) {
            NSLog(@"Error: failed to insert into the database with message.");
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        //关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;
}

//获取数据
- (NSMutableArray*)get{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        char *sql = "SELECT key, value, datepoint FROM tb_json";
        
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:get testValue.");
            return NO;
        }
        else {
            while (sqlite3_step(statement) == SQLITE_ROW) {

            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return array;
}

//更新数据
-(BOOL) update:(NSString *)key value:(NSString *)value{
    
    if ([self openDB]) {
        sqlite3_stmt *statement;//这相当一个容器，放转化OK的sql语句
        //组织SQL语句
        char *sql = "update tb_json set value = ?, datepoint = ? WHERE key = ?";
        
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success != SQLITE_OK) {
            NSLog(@"Error: failed to update:testTable");
            sqlite3_close(_database);
            return NO;
        }
        
        sqlite3_bind_text(statement, 1,  [value UTF8String], -1, SQLITE_TRANSIENT);
        NSString *ll = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        sqlite3_bind_text(statement, 2, [ll UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [key UTF8String], -1, SQLITE_TRANSIENT);
        
        //执行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            NSLog(@"Error: failed to update the database with message.");
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        //执行成功后依然要关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;
}
//删除数据
- (BOOL) delete:(NSString *)key {
    if ([self openDB]) {
        
        sqlite3_stmt *statement;
        //组织SQL语句
        static char *sql = "delete from tb_json  where key = ?";
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success != SQLITE_OK) {
            NSLog(@"Error: failed to delete:testTable");
            sqlite3_close(_database);
            return NO;
        }
        
        sqlite3_bind_text(statement, 1,  [key UTF8String], -1, SQLITE_TRANSIENT);
        //执行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            NSLog(@"Error: failed to delete the database with message.");
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        //执行成功后依然要关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;
    
}
//查询数据
- (NSMutableArray*)search:(NSString *)key {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        
        const char *sql = "SELECT key, value, datepoint from tb_json where key = ?";

        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:search testValue.");
            return NO;
        } else {
            sqlite3_bind_text(statement, 1, [key UTF8String], -1, SQLITE_TRANSIENT);
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSMutableDictionary *dic = [NSMutableDictionary new];
                
                const unsigned char *key = sqlite3_column_text(statement, 0);
                const unsigned char *value = sqlite3_column_text(statement, 1);
                const unsigned char *datepoint = sqlite3_column_text(statement, 2);
                
                [dic setObject:[NSString stringWithUTF8String:(char*)key] forKey:@"key"];
                [dic setObject:[NSString stringWithUTF8String:(char*)value] forKey:@"value"];
                [dic setObject:[NSString stringWithFormat:@"%s", datepoint] forKey:@"datepoint"];
                
                [array addObject:dic];
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return array;
}

@end
