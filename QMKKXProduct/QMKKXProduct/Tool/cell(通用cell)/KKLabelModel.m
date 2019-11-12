//
//  KKLabelModel.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/11.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKLabelModel.h"

@implementation KKLabelModel
- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value{
    if (self = [self init]) {
        self.title = title;
        self.value = value;
        self.isShowLine = NO;
        self.isCanEdit = NO;
    }
    return self;
}
@end
