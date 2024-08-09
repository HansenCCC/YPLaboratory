//
//  KKBaseResponse.m
//  FanRabbit
//
//  Created by 程恒盛 on 2019/5/29.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KKBaseResponse.h"

@implementation KKBaseResponse
- (instancetype)initWithData:(id)data{
    if (self = [self init]) {
        self.data = data;
    }
    return self;
}
@end
