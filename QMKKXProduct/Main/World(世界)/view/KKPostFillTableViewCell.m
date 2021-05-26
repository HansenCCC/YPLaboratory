//
//  KKPostFillTableViewCell.m
//  KKLAFProduct
//
//  Created by Hansen on 4/20/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKPostFillTableViewCell.h"

@interface KKPostFillTableViewCell ()<UITextViewDelegate>
@property (strong, nonatomic) UILabel *starLabel;
@property (strong, nonatomic) UIView *secondContentView;
@property (strong, nonatomic) KKTextView *textView;
@property (strong, nonatomic) UIView *markView;

@end

@implementation KKPostFillTableViewCell
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
    self.textView = [[KKTextView alloc] init];
    self.textView.font = AdaptedFontSize(14.f);
    self.textView.textColor = KKColor_000000;
    self.textView.placeholderColor = KKColor_999999;
    self.textView.delegate = self;
    [self.secondContentView addSubview:self.textView];
    //
    self.markView = [[UIView alloc] init];
    self.markView.backgroundColor = KKColor_EEEEEE;
    [self.secondContentView addSubview:self.markView];
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
    f2.origin.y = AdaptedWidth(10.f);
    self.starLabel.frame = f2;
    //
    CGRect f3 = bounds;
    f3.origin.x = CGRectGetMaxX(f2);
    f3.size = [self.textView sizeThatFits:CGSizeMake(f1.size.width - f3.origin.x - AdaptedWidth(15.f), 0)];
    f3.origin.y = AdaptedWidth(5.f);
    f3.size.height = MAX(f3.size.height, AdaptedWidth(88.f));
    f3.size.width = f1.size.width - f3.origin.x - AdaptedWidth(5.f);
    self.textView.frame = f3;
    //
    CGRect f4 = bounds;
    f4.origin.x = f3.origin.x;
    f4.size.width = f3.size.width;
    f4.size.height = AdaptedWidth(0.5f);
    f4.origin.y = f1.size.height - f4.size.height;
    self.markView.frame = f4;
}
- (void)setCellModel:(KKLabelModel *)cellModel{
    _cellModel = cellModel;
    [self reloadDatas];
}
#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.cellModel.value = textView.text?:@"";
    [self kk_reloadCurrentTableViewCell];
}
#pragma mark - 自适应高度
DEF_SINGLETON(KKPostFillTableViewCell);
- (void)reloadDatas{
    KKLabelModel *model = self.cellModel;
    self.markView.hidden = !model.isShowLine;
    self.starLabel.hidden = !model.isShowStar;
    self.textView.userInteractionEnabled = model.isCanEdit;
    self.textView.text = model.value?:@"";
    self.textView.placeholder = model.placeholder?:@"";
    [self layoutSubviews];
}
- (void)kk_extensionCellModel:(id)cellModel{
    [super kk_extensionCellModel:cellModel];
    self.cellModel = cellModel;
}
- (CGFloat)kk_extensionCellHeight:(id)cellModel tableView:(UITableView *)tableView{
    [super kk_extensionCellHeight:cellModel tableView:tableView];
    CGFloat height = CGRectGetMaxY(self.textView.frame) + AdaptedWidth(5.f);
    return height;
}
@end
