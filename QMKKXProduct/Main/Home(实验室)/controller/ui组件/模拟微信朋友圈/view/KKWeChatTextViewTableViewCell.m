//
//  KKWeChatTextViewTableViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 2/12/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKWeChatTextViewTableViewCell.h"

@implementation KKWeChatTextViewTableViewCell
DEF_SINGLETON(KKWeChatTextViewTableViewCell);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textView = [[KKTextView alloc] init];
        self.textView.delegate = self;
        self.textView.showsVerticalScrollIndicator = NO;
        self.textView.showsHorizontalScrollIndicator = NO;
        self.textView.textColor = KKColor_000000;
        self.textView.font = AdaptedFontSize(17.f);
        [self.contentView addSubview:self.textView];
        CGFloat top = AdaptedWidth(6.f);
        CGFloat left = AdaptedWidth(8.f);
        CGFloat bottom = AdaptedWidth(6.f);
        CGFloat right = AdaptedWidth(8.f);
        self.contentInsets = UIEdgeInsetsMake(top, left, bottom, right);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setCellModel:(KKLabelModel *)cellModel{
    _cellModel = cellModel;
    self.textView.text = cellModel.value;
    self.textView.placeholder = cellModel.placeholder;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    UIEdgeInsets contentInsets = self.contentInsets;
    CGRect f1 = bounds;
    f1.origin.x = contentInsets.left;
    f1.origin.y = contentInsets.top;
    f1.size.width = bounds.size.width - (contentInsets.left + contentInsets.right);
    f1.size.height = bounds.size.height - (contentInsets.top + contentInsets.bottom);
    self.textView.frame = f1;
}
- (CGSize)sizeThatFits:(CGSize)size{
    UIEdgeInsets contentInsets = self.contentInsets;
    size.width -= (contentInsets.left + contentInsets.right);
    CGSize _size = [self.textView sizeThatFits:size];
    _size.height += (contentInsets.top + contentInsets.bottom);
    return _size;
}
#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.cellModel.value = self.textView.text;
}
- (void)textViewDidChange:(UITextView *)textView{
    self.cellModel.value = self.textView.text;
}
@end
