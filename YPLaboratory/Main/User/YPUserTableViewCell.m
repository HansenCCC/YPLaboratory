//
//  YPUserTableViewCell.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/17.
//

#import "YPUserTableViewCell.h"
#import "YPUserModel.h"

@interface YPUserTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YPUserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self.contentView addSubview:self.titleLabel];
}

- (void)setCellModel:(YPUserModel *)cellModel {
    _cellModel = cellModel;
    self.titleLabel.text = cellModel.title?:@"";
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = 20.f;
    f1.size.width = bounds.size.width - f1.origin.x * 2;
    self.titleLabel.frame = f1;
}

#pragma mark - getters | setters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

@end
