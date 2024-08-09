//
//  YPPageRouter.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/20.
//

#import "YPPageRouter.h"

@implementation YPPageRouter

- (instancetype)init {
    if (self = [super init]) {
        self.enable = YES;
        self.useInsetGrouped = NO;
        self.cellHeight = 44.f;
    }
    return self;
}

@end
