//
//  KKAdaptiveTableViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 2/2/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKAdaptiveTableViewCell.h"

@interface KKAdaptiveTableViewCell ()

@end

@implementation KKAdaptiveTableViewCell
DEF_SINGLETON(KKWeChatCommentTableViewCell);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat top = AdaptedWidth(6.f);
        CGFloat left = AdaptedWidth(8.f);
        CGFloat bottom = AdaptedWidth(6.f);
        CGFloat right = AdaptedWidth(8.f);
        self.contentInsets = UIEdgeInsetsMake(top, left, bottom, right);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KKColor_CLEAR;
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews{
    //to do
    self.contentLabel = [UILabel labelWithFont:AdaptedFontSize(14) textColor:KKColor_1A1A1A];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    UIEdgeInsets contentInsets = self.contentInsets;
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    f1.origin.x = contentInsets.left;
    f1.origin.y = contentInsets.top;
    f1.size.width = bounds.size.width - (contentInsets.left + contentInsets.right);
    f1.size.height = bounds.size.height - (contentInsets.top + contentInsets.bottom);
    self.contentLabel.frame = f1;
}
- (CGSize)sizeThatFits:(CGSize)size{
    UIEdgeInsets contentInsets = self.contentInsets;
    size.width -= (contentInsets.left + contentInsets.right);
    CGSize _size = [self.contentLabel sizeThatFits:size];
    _size.height += (contentInsets.top + contentInsets.bottom);
    return _size;
}
@end
