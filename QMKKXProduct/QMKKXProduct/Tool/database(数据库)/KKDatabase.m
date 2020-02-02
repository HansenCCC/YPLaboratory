//
//  KKDatabase.m
//  QMKKXProduct
//
//  Created by Hansen on 2/1/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKDatabase.h"

@interface KKDatabase ()
@property (strong, nonatomic) FMDatabase *db;

@end

@implementation KKDatabase
- (instancetype)init{
    if (self = [super init]) {
        /*
         //默认所有表创建在document目录kk_common.db文件目录下
         //想另行创建db文件，可以self.dbPath指定路径
         NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
         NSString *dbPath = [docuPath stringByAppendingPathComponent:@"kk_common.db"];
         self.dbPath = dbPath;
         */
    }
    return self;
}
+ (instancetype)databaseWithPath:(NSString *)dbPath{
    KKDatabase *database = [[self alloc] init];
    database.dbPath = dbPath;
    NSLog(@"数据库地址:\n%@\n",dbPath);
    return database;
}
//指定创建db路径
- (void)setDbPath:(NSString *)dbPath{
    _dbPath = dbPath;
    self.db = [FMDatabase databaseWithPath:dbPath];
    //3.判断文件是否open，不能open，可能是权限或者资源不足
    BOOL open = [self.db open];
    if (!open) {
        NSLog(@"⚠️⚠️⚠️db open fail⚠️⚠️⚠️");
    }
    [self setConfig];
}
//设置配置
- (void)setConfig{
    
}
//获取所有的表单信息
- (NSInteger)tableCount{
    // 根据请求参数查询数据
    FMResultSet *resultSet = nil;
    resultSet = [self.db executeQuery:@"SELECT * FROM sqlite_master where type='table';"];
    NSInteger tableCount = 0;
    while (resultSet.next) {
        tableCount ++;
    }
    return tableCount;
}
@end
