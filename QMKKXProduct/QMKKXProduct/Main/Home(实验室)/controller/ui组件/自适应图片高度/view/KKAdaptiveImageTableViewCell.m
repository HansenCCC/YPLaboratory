//
//  KKAdaptiveImageTableViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 9/25/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKAdaptiveImageTableViewCell.h"

@interface KKAdaptiveImageTableViewCell ()

@end

@implementation KKAdaptiveImageTableViewCell
DEF_SINGLETON(KKAdaptiveImageTableViewCell);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews{
    //to do
    self.contentImageView = [[UIImageView alloc] init];
    self.contentImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.contentImageView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = AdaptedWidth(5.f);
    f1.origin.y = AdaptedWidth(5.f);
    f1.size.width = bounds.size.width - 2 * f1.origin.x;
    f1.size.height = bounds.size.height - 2 * f1.origin.y;
    self.contentImageView.frame = f1;
}
@end
