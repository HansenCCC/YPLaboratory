//
//  KKDatabaseColumnModel.m
//  QMKKXProduct
//
//  Created by Hansen on 2/6/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKDatabaseColumnModel.h"

@implementation KKDatabaseColumnModel
- (instancetype)initWithName:(NSString *)name{
    if (self = [self init]) {
        self.name = name;
    }
    return self;
}
@end
