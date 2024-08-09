//
//  KKDatabaseColumnModel.h
//  QMKKXProduct
//
//  Created by Hansen on 2/6/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKDatabaseColumnModel : NSObject
@property (strong, nonatomic) NSString *cid;
@property (strong, nonatomic) NSString *dflt_value;
@property (strong, nonatomic) NSString *name;//字段名
@property (strong, nonatomic) NSString *notnull;//是否值不能为空 1or0
@property (strong, nonatomic) NSString *pk;//是否自动增长唯一key 1or0
@property (strong, nonatomic) NSString *type;//类型1. NULL 这个值为空值2. INTEGER 值被标识为整数，依据值的大小可以依次被存储1～8个字节3. REAL 所有值都是浮动的数值4. TEXT 值为文本字符串5. BLOB 值为blob数据
- (instancetype)initWithName:(NSString *)name;
@end

