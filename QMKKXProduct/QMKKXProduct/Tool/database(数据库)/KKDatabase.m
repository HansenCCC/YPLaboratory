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
@property (strong, nonatomic) NSDictionary *tableSqliteMaster;//获取当前所有表单描述
@end

@implementation KKDatabase
- (instancetype)init{
    if (self = [super init]) {
        /*
         //在FMDB中，除查询以外的所有操作，都称为“更新”
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
}
//获取表单数量
- (NSInteger)tableCount{
    return self.tableSqliteMasters.count;
}
//获取当前所有表单描述
- (NSArray *)tableSqliteMasters{
    // 根据请求参数查询数据
    FMResultSet *resultSet = nil;
    resultSet = [self.db executeQuery:@"SELECT * FROM sqlite_master where type='table';"];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    while (resultSet.next) {
        //name = 1;
        //rootpage = 3;
        //sql = 4;
        //"tbl_name" = 2;
        //type = 0;
        NSString *str0 = [resultSet stringForColumnIndex:0];
        NSString *str1 = [resultSet stringForColumnIndex:1];
        NSString *str2 = [resultSet stringForColumnIndex:2];
        NSString *str3 = [resultSet stringForColumnIndex:3];
        NSString *str4 = [resultSet stringForColumnIndex:4];
        [items addObject:@{
            @"type":str0,
            @"name":str1,
            @"tbl_name":str2,
            @"rootpage":str3,
            @"sql":str4,
        }];
    }
    return [items copy];
}
#pragma mark - action
/// 创建表单
/// @param tableName 表单名称
- (void)createTable:(NSString *)tableName complete:(void(^)(BOOL success))complete;{
    NSString *sqlCommand = [NSString stringWithFormat:@"create table if not exists %@ (id Interger primary key)",tableName];
    BOOL success = [self.db executeUpdate:sqlCommand];
    if (complete) {
        complete(success);
    }
}
@end
