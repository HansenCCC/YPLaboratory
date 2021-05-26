//
//  KKFormTableViewCell.m
//  KKLAFProduct
//
//  Created by Hansen on 9/9/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKFormTableViewCell.h"

@interface KKFormTableViewCell ()
@property (strong, nonatomic) UILabel *starLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) KKUIFlowLayoutButton *rightButton;
@property (strong, nonatomic) UIView *secondContentView;
@property (strong, nonatomic) KKTextField *textField;
@property (strong, nonatomic) UIView *markView;

@end

@implementation KKFormTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews{
    //to do
    self.backgroundColor = KKColor_F2F2F7;
    //
    self.secondContentView = [[UIView alloc] init];
    self.secondContentView.backgroundColor = KKColor_FFFFFF;
    [self.contentView addSubview:self.secondContentView];
    //
    self.starLabel = [UILabel labelWithFont:AdaptedFontSize(18.f) textColor:KKColor_DA4F49];
    self.starLabel.text = @"*";
    [self.secondContentView addSubview:self.starLabel];
    //
    self.textField = [[KKTextField alloc] init];
    self.textField.font = AdaptedFontSize(14.f);
    self.textField.textColor = KKColor_000000;
    self.textField.textAlignment = NSTextAlignmentRight;
    WeakSelf
    self.textField.whenDidEndEditing = ^(UITextField *textField) {
        //结束编辑时
        weakSelf.cellModel.value = textField.text;
    };
    [self.secondContentView addSubview:self.textField];
    //
    self.markView = [[UIView alloc] init];
    self.markView.backgroundColor = KKColor_EEEEEE;
    [self.secondContentView addSubview:self.markView];
    //
    self.titleLabel = [UILabel labelWithFont:AdaptedFontSize(14.f) textColor:KKColor_000000];
    [self.secondContentView addSubview:self.titleLabel];
    //
    self.rightButton = [[KKUIFlowLayoutButton alloc] init];
    self.rightButton.userInteractionEnabled = NO;
    self.rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.secondContentView addSubview:self.rightButton];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = AdaptedWidth(15.f);
    f1.size.width = bounds.size.width - f1.origin.x * 2;
    self.secondContentView.frame = f1;
    //
    CGRect f2 = bounds;
    f2.origin.x = AdaptedWidth(5.f);
    f2.size = [self.starLabel sizeThatFits:CGSizeZero];
    f2.origin.y = (f1.size.height - f2.size.height)/2.0;
    self.starLabel.frame = f2;
    //
    CGRect fv = bounds;
    fv.size = [self.titleLabel sizeThatFits:CGSizeZero];
    fv.origin.x = CGRectGetMaxX(f2);
    fv.origin.y = (bounds.size.height - fv.size.height)/2.0;
    self.titleLabel.frame = fv;
    //
    CGRect fb = bounds;
    fb.size = [self.rightButton sizeThatFits:CGSizeZero];
    fb.origin.y = (f1.size.height - fb.size.height)/2.0;
    fb.origin.x = f1.size.width - fb.size.width - AdaptedWidth(5.f);
    if (self.rightButton.hidden == YES) {
        fb.size = CGSizeZero;
        fb.origin.x = f1.size.width - fb.size.width - AdaptedWidth(5.f);;
    }
    self.rightButton.frame = fb;
    self.rightButton.imageSize = self.cellModel.rightImageSize;
    //
    CGRect f3 = bounds;
    f3.size.width = AdaptedWidth(200.f);
    f3.origin.x = fb.origin.x - f3.size.width - AdaptedWidth(5.f);
    self.textField.frame = f3;
    //
    CGRect f4 = bounds;
    f4.origin.x = fv.origin.x;
    f4.size.width = f1.size.width - fv.origin.x - AdaptedWidth(10.f);;
    f4.size.height = AdaptedWidth(0.5f);
    f4.origin.y = f1.size.height - f4.size.height;
    self.markView.frame = f4;
}
- (void)setCellModel:(KKLabelModel *)cellModel{
    _cellModel = cellModel;
    [self reloadDatas];
}
#pragma mark - 自适应高度
- (void)reloadDatas{
    KKLabelModel *model = self.cellModel;
    self.markView.hidden = !model.isShowLine;
    self.starLabel.hidden = !model.isShowStar;
    self.textField.userInteractionEnabled = model.isCanEdit;
    self.textField.text = model.value?:@"";
    self.textField.placeholder = model.placeholder?:@"";
    self.titleLabel.text = model.title?:@"";
    if (model.rightImageName.length > 0) {
        [self.rightButton setImage:UIImageWithName(model.rightImageName) forState:UIControlStateNormal];
        self.rightButton.hidden = NO;
    }else{
        [self.rightButton setImage:nil forState:UIControlStateNormal];
        self.rightButton.hidden = YES;
    }
    [self layoutSubviews];
}
- (void)kk_extensionCellModel:(id)cellModel{
    [super kk_extensionCellModel:cellModel];
    self.cellModel = cellModel;
}
- (CGFloat)kk_extensionCellHeight:(id)cellModel tableView:(UITableView *)tableView{
    return AdaptedWidth(44.f);
}
@end
