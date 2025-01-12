//
//  YPModuleTableTableViewCell.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/21.
//

#import "YPModuleNormalCell.h"
#import "YPPageRouter.h"

@interface YPModuleNormalCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation YPModuleNormalCell

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
    [self.contentView addSubview:self.contentLabel];
}

- (void)setCellModel:(YPPageRouter *)cellModel {
    [super setCellModel:cellModel];
    self.titleLabel.text = cellModel.title?:@"";
    if (cellModel.content.length > 0) {
        self.contentLabel.text = cellModel.content?:@"";
        self.contentLabel.textColor = [UIColor yp_blackColor];
    } else {
        self.contentLabel.text = cellModel.placeholder?:@"";
        self.contentLabel.textColor = [UIColor yp_grayColor];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = 20.f;
    f1.size.width = bounds.size.width - f1.origin.x * 2;
    self.titleLabel.frame = f1;
    
    CGRect f2 = bounds;
    f2.size.width = bounds.size.width - 180.f;
    if (self.accessoryType != UITableViewCellAccessoryNone) {
        f2.origin.x = bounds.size.width - f2.size.width - 5.f;
    } else {
        f2.origin.x = bounds.size.width - f2.size.width - 20.f;
    }
    self.contentLabel.frame = f2;
}

#pragma mark - getters | setters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17.f];
        _titleLabel.textColor = [UIColor yp_blackColor];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:16.f];
        _contentLabel.textColor = [UIColor yp_grayColor];
        _contentLabel.numberOfLines = 1;
        _contentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _contentLabel;
}

@end
