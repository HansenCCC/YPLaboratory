//
//  KKDatabase.h
//  QMKKXProduct
//
//  Created by Hansen on 2/1/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

/*
 db数据类型（个人建议能text就用text）
 1. NULL 这个值为空值
 2. INTEGER 值被标识为整数，依据值的大小可以依次被存储1～8个字节
 3. REAL 所有值都是浮动的数值
 4. TEXT 值为文本字符串
 5. BLOB 值为blob数据
 
 */


#import <Foundation/Foundation.h>
#import "KKDatabaseColumnModel.h"

@interface KKDatabase : NSObject
@property (strong, nonatomic) NSString *dbPath;//db位置
@property (assign, nonatomic, readonly) NSInteger tableCount;//获取表单数量
@property (strong, nonatomic, readonly) NSArray *tableSqliteMasters;//获取当前所有表单描述

//
+ (instancetype)databaseWithPath:(NSString *)dbPath;

#pragma mark - action

/// 创建表单
/// @param tableName 表单名称
/// @param columnModels 字段类型
- (BOOL)createTableWithTableName:(NSString *)tableName columnModels:(NSArray <KKDatabaseColumnModel *>*)columnModels;

/// 增加内容到表单
/// @param tableName 表单名称
/// @param contents 增加数据内容
- (BOOL)insertTableWithTableName:(NSString *)tableName contents:(NSObject *)contents;

/// 删除内容从表单
/// @param tableName 表单名称
/// @param contents 删除数据内容
- (BOOL)deleteTableWithTableName:(NSString *)tableName contents:(NSObject *)contents;

/// 查询表单内容
/// @param tableName 表单名称
- (NSArray *)selectTableWithTableName:(NSString *)tableName;

/// 更新内容从表单
/// @param tableName 表单名称
/// @param contents 原数据内容
/// @param update 更新数据内容
- (BOOL)updateTableWithTableName:(NSString *)tableName contents:(NSObject *)contents update:(NSObject *)update;

/// 添加字段到表单
/// @param tableName 表单名称
/// @param columnModel 字段model
- (BOOL)addColumnWithTableName:(NSString *)tableName columnModel:(KKDatabaseColumnModel *)columnModel;

/// 通过表单获取表单字段
/// @param tableName 表单名称
- (NSArray <NSString *>*)getFieldsWithTableName:(NSString *)tableName;
/// 通过表单获取表单字段详情
- (NSArray <KKDatabaseColumnModel *>*)getFieldsInfoWithTableName:(NSString *)tableName;

/// 获取上一个操作错误信息
- (NSString *)lastErrorMessage;
@end

