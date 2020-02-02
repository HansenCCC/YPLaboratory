//
//  KKDatabase.h
//  QMKKXProduct
//
//  Created by Hansen on 2/1/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKDatabase : NSObject
@property (strong, nonatomic) NSString *dbPath;//db位置
@property (assign, nonatomic, readonly) NSInteger tableCount;//获取表单数量
@property (strong, nonatomic, readonly) NSArray *tableSqliteMasters;//获取当前所有表单描述

//
+ (instancetype)databaseWithPath:(NSString *)dbPath;

#pragma mark - action
/// 创建表单
/// @param tableName 表单名称
- (void)createTable:(NSString *)tableName complete:(void(^)(BOOL success))complete;

@end

