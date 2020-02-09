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
/// @param columnModels 字段类型
- (BOOL)createTableWithTableName:(NSString *)tableName columnModels:(NSArray <KKDatabaseColumnModel *>*)columnModels{
    NSString *column = @"";
    for (KKDatabaseColumnModel *columnModel in columnModels) {
        NSString *name = columnModel.name;
        NSString *pk = @"primary KEY AUTOINCREMENT";
        NSString *notnull = @"NOT NULL";
        NSString *type = columnModel.type?:@"TEXT";//没有类型默认为text文本类型
        NSString *attribute = @"";
        if (columnModel.pk.intValue == 1) {
            attribute = pk;
            type = @"INTEGER";
        }else if(columnModel.notnull.intValue == 1){
            attribute = notnull;
        }
        NSString *value = [NSString stringWithFormat:@"%@ %@ %@,",name,type,attribute];
        column = [column addString:value];
    }
    if (column.length > 0) {
        column = [column substringToIndex:column.length - 1];
    }
    NSString *sqlCommand = [NSString stringWithFormat:@"create table if not exists %@ (%@)",tableName,column];
    BOOL success = [self.db executeUpdate:sqlCommand];
    if(!success){
        NSLog(@"error = %@", [self lastErrorMessage]);
    }
    return success;
}

/// 插入内容到表单
/// @param tableName 表单名称
/// @param contents 插入数据内容
- (BOOL)insertTableWithTableName:(NSString *)tableName contents:(NSObject *)contents{
    //插入内容，遍历字段属性，不能为空属性默认赋值空字符串
    NSMutableDictionary *dict = contents.mj_keyValues;
    NSArray <KKDatabaseColumnModel *>*infoItems = [self getFieldsInfoWithTableName:tableName];
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (KKDatabaseColumnModel *info in infoItems) {
        NSString *key = info.name;
        NSString *value = [dict objectForKey:key];
        if (info.notnull.intValue == 1) {
            //不能为空
        }else{
            //可以为空
        }
        if (info.pk.intValue == 1) {
            //是特殊自增字段
            if (value.length > 0) {
                [keys addObject:key?:@""];
                [values addObject:value?:@""];
            }
        }else{
            //不是特殊自增字段
            [keys addObject:key?:@""];
            [values addObject:value?:@""];
        }
    }
    //嵌套''
    NSMutableArray *valuesMutable = [[NSMutableArray alloc] init];
    for (NSString *value in values) {
        [valuesMutable addObject:[NSString stringWithFormat:@"'%@'",value]];
    }
    values = [valuesMutable copy];
    NSString *key = [keys componentsJoinedByString:@","];
    NSString *value = [values componentsJoinedByString:@","];
    NSString *sqlCommand = [NSString stringWithFormat:@"insert into %@ (%@) values (%@)", tableName,key,value];
    BOOL success = [self.db executeUpdate:sqlCommand];
    if(!success){
        NSLog(@"error = %@", [self lastErrorMessage]);
    }
    return success;
}

/// 添加字段到表单
/// @param tableName 表单名称
/// @param columnModel 字段model
- (BOOL)addColumnWithTableName:(NSString *)tableName columnModel:(KKDatabaseColumnModel *)columnModel{
    NSString *columnName = columnModel.name;
    NSString *type = columnModel.type?:@"TEXT";
    NSString *pk = @"primary key AUTOINCREMENT";
    NSString *notnull = @"";
    NSString *attribute = @"";
    if (columnModel.pk.intValue == 1) {
        attribute = pk;
        type = @"INTEGER";
    }else if(columnModel.notnull.intValue == 1){
        attribute = notnull;
    }
    //执行添加字段命令
    NSString *sqlCommand = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@ %@",tableName,columnName,type,attribute];
    BOOL success = [self.db executeUpdate:sqlCommand];
    if(!success){
        NSLog(@"error = %@", [self lastErrorMessage]);
    }
    return success;
}

/// 遍历表单内容
/// @param tableName 表单名称
- (NSArray *)selectTableWithTableName:(NSString *)tableName{
    NSString *sqlCommand = [NSString stringWithFormat:@"select * from %@",tableName];
    FMResultSet *resultSet = [self.db executeQuery:sqlCommand];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    while([resultSet next]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        NSDictionary *columnNames = resultSet.columnNameToIndexMap;
        NSArray *keys = columnNames.allKeys;
        for (NSString *key in keys) {
            NSString *value = [resultSet objectForColumn:key];
            [dict setObject:value forKey:key];
        }
        [items addObject:dict];
    }
    return items;
}
/// 通过表单获取表单字段
/// @param tableName 表单名称
- (NSArray <NSString *>*)getFieldsWithTableName:(NSString *)tableName{
//    FMResultSet *reslutSet = [self.db getTableSchema:tableName];
//    NSMutableArray *resultArray = [NSMutableArray array];
//    while ([reslutSet next]) {
//        NSString *cloumn = [reslutSet objectForColumnName:@"name"];
//        [resultArray addObject:cloumn];
//        NSLog(@"%@",reslutSet.columnNameToIndexMap);
//        NSLog(@"%@",reslutSet.resultDictionary);
//    }
    //获取表单字段，或者通过[db getTableSchema:tableName]获取
    NSString *sqlCommand = [NSString stringWithFormat:@"select * from %@",tableName];
    FMResultSet *resultSet = [self.db executeQuery:sqlCommand];
    NSDictionary *dict = resultSet.columnNameToIndexMap;
    return dict.allKeys;
}
/// 通过表单获取表单字段详情
- (NSArray <KKDatabaseColumnModel *>*)getFieldsInfoWithTableName:(NSString *)tableName{
    FMResultSet *reslutSet = [self.db getTableSchema:tableName];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    while ([reslutSet next]) {
        KKDatabaseColumnModel *model = [KKDatabaseColumnModel mj_objectWithKeyValues:reslutSet.resultDictionary];
        [resultArray addObject:model];
    }
    return resultArray;
}

/// 获取上一个操作错误信息
- (NSString *)lastErrorMessage{
    return [self.db lastErrorMessage];
}
@end
