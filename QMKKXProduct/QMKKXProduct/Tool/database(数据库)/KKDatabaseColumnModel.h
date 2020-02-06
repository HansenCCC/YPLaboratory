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
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *notnull;
@property (strong, nonatomic) NSString *pk;
@property (strong, nonatomic) NSString *type;
@end

