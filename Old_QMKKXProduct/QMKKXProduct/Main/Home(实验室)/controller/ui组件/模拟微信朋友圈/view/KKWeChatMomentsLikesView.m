//
//  KKWeChatMomentsLikesView.m
//  QMKKXProduct
//
//  Created by Hansen on 1/28/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKWeChatMomentsLikesView.h"

@interface KKWeChatMomentsLikesView ()
@property (readonly, nonatomic) UIEdgeInsets contentInsets;

@end

@implementation KKWeChatMomentsLikesView
- (instancetype)init{
    if (self = [super init]) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    self.contentLabel = [UILabel labelWithFont:AdaptedBoldFontSize(14.f) textColor:KKColor_626787];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
}
- (void)setLikes:(NSArray<KKWeChatMomentsLikeModel *> *)likes{
    _likes = likes;
    NSString *value = @"♥︎  ";
    for (KKWeChatMomentsLikeModel *model  in likes) {
        value = [value addString:[NSString stringWithFormat:@"%@, ",model.userName]];
    }
    value = [value substringWithRange:NSMakeRange(0, value.length - 2)];
    if (self.likes.count == 0) {
        //点赞为空时
        self.contentLabel.text = @"";
    }else{
        //有人点赞
        self.contentLabel.text = value;
    }
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
    f1.size.height = bounds.size.height - ((contentInsets.top + contentInsets.bottom));
    self.contentLabel.frame = f1;
}
- (CGSize)sizeThatFits:(CGSize)size{
    UIEdgeInsets contentInsets = self.contentInsets;
    size.width -= (contentInsets.left + contentInsets.right);
    CGSize _size = [self.contentLabel sizeThatFits:size];
    _size.height += ((contentInsets.top + contentInsets.bottom));
    if (self.likes.count == 0) {
        _size.height = 0.f;
    }
    return _size;
}
- (UIEdgeInsets)contentInsets{
    CGFloat top = AdaptedWidth(6.f);
    CGFloat left = AdaptedWidth(8.f);
    CGFloat bottom = AdaptedWidth(6.f);
    CGFloat right = AdaptedWidth(8.f);
    return UIEdgeInsetsMake(top, left, bottom, right);
}
@end
