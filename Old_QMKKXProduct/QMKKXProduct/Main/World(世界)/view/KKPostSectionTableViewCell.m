//
//  KKPostSectionTableViewCell.m
//  KKLAFProduct
//
//  Created by Hansen on 4/14/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKPostSectionTableViewCell.h"

@interface KKPostSectionTableViewCell ()

@end

@implementation KKPostSectionTableViewCell
DEF_SINGLETON(KKPostSectionTableViewCell);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews{
    //to do
    self.titleLabel = [UILabel labelWithFont:AdaptedFontSize(14.f) textColor:KKColor_999999];
    [self addSubview:self.titleLabel];
    self.backgroundColor = KKColor_CLEAR;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    f1.size = [self.titleLabel sizeThatFits:CGSizeZero];
    f1.origin.x = AdaptedWidth(15.f);
    f1.origin.y = (bounds.size.height - f1.size.height)/2.0;
    self.titleLabel.frame = f1;
}
- (void)kk_extensionCellModel:(id)cellModel{
    [super kk_extensionCellModel:cellModel];
    KKLabelModel *model = cellModel;
    self.titleLabel.text = model.title?:@"";
}
@end
