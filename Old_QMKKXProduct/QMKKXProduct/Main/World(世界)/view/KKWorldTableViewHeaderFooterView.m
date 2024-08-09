//
//  KKWorldTableViewHeaderFooterView.m
//  QMKKXProduct
//
//  Created by Hansen on 5/26/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKWorldTableViewHeaderFooterView.h"

@implementation KKWorldTableViewHeaderFooterView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = KKColor_1A4FB9;
        //
        self.titleLabel = [UILabel labelWithFont:AdaptedFontSize(12) textColor:KKColor_FFFFFF];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
    [self layoutIfNeeded];
    [self setNeedsLayout];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.size = [self.titleLabel sizeThatFits:CGSizeZero];
    f1.origin.x = AdaptedWidth(10.f);
    f1.origin.y = (bounds.size.height - f1.size.height)/2.0;
    self.titleLabel.frame = f1;
}

@end
