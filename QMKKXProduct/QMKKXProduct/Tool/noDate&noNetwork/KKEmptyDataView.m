//
//  KKEmptyDataView.m
//  FanRabbit
//
//  Created by 程恒盛 on 2019/6/17.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KKEmptyDataView.h"

@implementation KKEmptyDataView
- (instancetype)init{
    if (self = [super init]) {
        self.emptyImageView = [[UIImageView alloc] init];
        self.emptyImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.emptyImageView];
    }
    return self;
}
- (instancetype)initWithImage:(UIImage *)image{
    if (self = [self init]) {
        self.emptyImageView.image = image;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.emptyImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(AdaptedWidth(-50.f));
    }];
}

/**
 创建空数据显示view
 */
+ (id)createEmptyDateView{
    return [[KKEmptyDataView alloc] initWithImage:UIImageWithName(@"sq_icon_empty")];
}


/**
 创建网络异常view
 */
+ (id)createNetworkFailDateView{
        return [[KKEmptyDataView alloc] initWithImage:UIImageWithName(@"sq_icon_fail")];
}
@end
