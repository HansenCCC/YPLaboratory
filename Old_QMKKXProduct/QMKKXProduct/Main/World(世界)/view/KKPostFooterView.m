//
//  KKPostFooterView.m
//  KKLAFProduct
//
//  Created by Hansen on 8/25/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKPostFooterView.h"

@implementation KKPostFooterView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [UILabel labelWithFont:AdaptedFontSize(12.f) textColor:KKColor_7D7D7D];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        self.titleLabel.userInteractionEnabled = YES;
        //
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapClick)];
        [self.titleLabel addGestureRecognizer:self.tapGestureRecognizer];
    }
    return self;
}
- (void)setAttributedText:(NSAttributedString *)attributedText{
    _attributedText = attributedText;
    self.titleLabel.attributedText = attributedText;
    [self layoutSubviews];
}
- (void)whenTapClick{
    if (self.whenTapAciton) {
        self.whenTapAciton(0);
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    f1.size = [self.titleLabel sizeThatFits:CGSizeZero];
    f1.origin.y = AdaptedWidth(15.f);
    f1.origin.x = (bounds.size.width - f1.size.width)/2.0;
    self.titleLabel.frame = f1;
}
@end
