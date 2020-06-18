//
//  KKImageBrowserCell.m
//  QMKKXProduct
//
//  Created by Hansen on 6/18/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKImageBrowserCell.h"

@implementation KKImageBrowserCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    self.browserImageView = [[UIImageView alloc] init];
    self.browserImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.browserImageView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    self.browserImageView.frame = f1;
}
@end
