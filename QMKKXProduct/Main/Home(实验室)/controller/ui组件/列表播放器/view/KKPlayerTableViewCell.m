//
//  KKPlayerTableViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 5/26/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKPlayerTableViewCell.h"

@interface KKPlayerTableViewCell ()

@end

@implementation KKPlayerTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}
- (void)setCellModel:(KKLabelModel *)cellModel{
    _cellModel = cellModel;
    self.titleLabel.text = cellModel.title;
    if ([cellModel.value isEqualToString:self.playerView.playerItemUrl.absoluteString]) {
         //to do
     }else{
         self.playerView.playerItemUrl = cellModel.value.toURL;
     }
    //仅仅七牛云获取视频方法
    NSString *placeholderImage = [cellModel.value addString:@"?vframe/png/offset/0"];
    self.playerView.placeholderImage = placeholderImage;
}
- (void)setupSubViews{
    //
    self.titleLabel = [UILabel labelWithFont:AdaptedFontSize(15.f) textColor:KKColor_000000];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    //
    self.playerView = [[KKBeeAVPlayerView alloc] init];
    [self.contentView addSubview:self.playerView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = AdaptedWidth(15.f);
    f1.origin.y = AdaptedWidth(15.f);
    f1.size = [self.titleLabel sizeThatFits:CGSizeMake(bounds.size.width - 2 * f1.origin.x, 0)];
    self.titleLabel.frame = f1;
    //
    CGRect f2 = bounds;
    f2.origin.x = f1.origin.x;
    f2.origin.y = CGRectGetMaxY(f1) + AdaptedWidth(15.f);
    f2.size.width = bounds.size.width - 2 * f1.origin.x;
    f2.size.height = 9.0/16.0 * f2.size.width;
    self.playerView.frame = f2;
}
@end
