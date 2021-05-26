//
//  KKPostHeaderTableViewCell.m
//  KKLAFProduct
//
//  Created by Hansen on 4/13/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKPostHeaderTableViewCell.h"

@interface KKPostHeaderTableViewCell ()

@end

@implementation KKPostHeaderTableViewCell
DEF_SINGLETON(KKPostHeaderTableViewCell);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews{
    self.backgroundColor = KKColor_1A4FB9;
    //to do
    self.titleButton = [[KKUIFlowLayoutButton alloc] init];
    [self.titleButton setImage:[UIImageWithName(@"kk_icon_arrowDown") kk_imageWithTintColor:KKColor_FFFFFF] forState:UIControlStateNormal];
    [self.titleButton setImage:[UIImageWithName(@"kk_icon_arrowUp") kk_imageWithTintColor:KKColor_FFFFFF] forState:UIControlStateSelected];
    self.titleButton.imageSize = CGSizeMake(AdaptedWidth(25.f), AdaptedWidth(25.f));
    self.titleButton.reverseContent = YES;
    self.titleButton.titleLabel.font = AdaptedBoldFontSize(20.f);
    [self.titleButton setTitleColor:KKColor_FFFFFF forState:UIControlStateNormal];
    [self.contentView addSubview:self.titleButton];
    //
    self.contentLabel = [UILabel labelWithFont:AdaptedFontSize(14.f) textColor:KKColor_FFFFFF];
    self.contentLabel.numberOfLines = 0.f;
    [self.contentView addSubview:self.contentLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.size = [self.titleButton sizeThatFits:CGSizeZero];
    f1.origin.x = AdaptedWidth(30.f);
    f1.origin.y = AdaptedWidth(40.f);
    self.titleButton.frame = f1;
    //
    CGRect f2 = bounds;
    f2.origin.x = AdaptedWidth(15.f);
    f2.origin.y = CGRectGetMaxY(f1) + AdaptedWidth(50.f);
    f2.size = [self.contentLabel sizeThatFits:CGSizeMake(bounds.size.width - 2 * f2.origin.x, 0)];
    self.contentLabel.frame = f2;
}
#pragma mark - hansen 自动计算高度
- (void)kk_extensionCellModel:(id)cellModel{
    //to do
    NSString *title = @"程序员树洞";
    [self.titleButton setTitle:title forState:UIControlStateNormal];
    NSString *content = @"夏天的砖，烫手！";
    self.contentLabel.text = content;
    self.contentLabel.kk_lineSpacing = AdaptedWidth(5.f);
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (CGFloat)kk_extensionCellHeight:(id)cellModel tableView:(UITableView *)tableView{
    self.frame = tableView.bounds;
    [self kk_extensionCellModel:cellModel];
    CGFloat height = CGRectGetMaxY(self.contentLabel.frame) + AdaptedWidth(15.f);
    return height;
}
@end
