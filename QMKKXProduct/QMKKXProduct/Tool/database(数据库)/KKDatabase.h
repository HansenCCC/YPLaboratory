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
//
+ (instancetype)databaseWithPath:(NSString *)dbPath;

@end

