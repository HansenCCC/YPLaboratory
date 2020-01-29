//
//  KKWeChatCommentTableViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 1/29/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKWeChatCommentTableViewCell.h"

@interface KKWeChatCommentTableViewCell ()
@property (readonly, nonatomic) UIEdgeInsets contentInsets;
@end

@implementation KKWeChatCommentTableViewCell
DEF_SINGLETON(KKWeChatCommentTableViewCell);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
- (void)setCellModel:(KKWeChatMomentsCommentModel *)cellModel{
    _cellModel = cellModel;
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:cellModel.userName attributes:@{NSForegroundColorAttributeName:KKColor_626787,NSFontAttributeName:AdaptedBoldFontSize(14)}];
    if (cellModel.replyModel) {
        NSMutableAttributedString *replyAttributed = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"回复%@",cellModel.replyModel.userName] attributes:@{NSForegroundColorAttributeName:KKColor_1A1A1A,NSFontAttributeName:AdaptedFontSize(14)}];
        [replyAttributed setAttributes:@{NSForegroundColorAttributeName:KKColor_626787,NSFontAttributeName:AdaptedBoldFontSize(14)} range:NSMakeRange(2, replyAttributed.length - 2)];
        [attributed appendAttributedString:replyAttributed];
    }
    NSMutableAttributedString *lastAttributed = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@": %@",cellModel.content] attributes:@{NSForegroundColorAttributeName:KKColor_1A1A1A,NSFontAttributeName:AdaptedFontSize(14)}];
    [attributed appendAttributedString:lastAttributed];
    //
    self.contentLabel.attributedText = attributed;
    [self layoutSubviews];
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
- (UIEdgeInsets)contentInsets{
    CGFloat top = AdaptedWidth(6.f);
    CGFloat left = AdaptedWidth(8.f);
    CGFloat bottom = AdaptedWidth(0.f);
    CGFloat right = AdaptedWidth(8.f);
    return UIEdgeInsetsMake(top, left, bottom, right);
}
@end
