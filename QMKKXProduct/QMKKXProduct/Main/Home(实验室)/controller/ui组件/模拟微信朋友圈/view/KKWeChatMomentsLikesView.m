//
//  KKWeChatMomentsLikesView.m
//  QMKKXProduct
//
//  Created by Hansen on 1/28/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKWeChatMomentsLikesView.h"

@implementation KKWeChatMomentsLikesView
- (instancetype)init{
    if (self = [super init]) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    self.contentLabel = [UILabel labelWithFont:AdaptedFontSize(14.f) textColor:KKColor_626787];
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
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    f1.origin.x = AdaptedWidth(8.f);
    f1.origin.y = AdaptedWidth(6.f);
    f1.size.width = bounds.size.width - f1.origin.x * 2;
    f1.size.height = bounds.size.height - f1.origin.y * 2;
    self.contentLabel.frame = f1;
}
- (CGSize)sizeThatFits:(CGSize)size{
    size.width -= AdaptedWidth(8.f) * 2;
    CGSize _size = [self.contentLabel sizeThatFits:size];
    _size.height += AdaptedWidth(6.f) * 2;
    if (self.likes.count == 0) {
        _size.height = 0.f;
    }
    return _size;
}
@end
