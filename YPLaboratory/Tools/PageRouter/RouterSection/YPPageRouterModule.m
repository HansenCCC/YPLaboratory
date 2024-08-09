//
//  YPPageRouterModule.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/25.
//

#import "YPPageRouterModule.h"

@implementation YPPageRouterModule

- (instancetype)initWithRouters:(NSArray *)routers {
    if (self = [self init]) {
        self.routers = routers;
    }
    return self;
}

@end
