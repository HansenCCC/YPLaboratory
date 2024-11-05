//
//  YPModuleSwitchCell.m
//  YPLaboratory
//
//  Created by Hansen on 2023/6/4.
//

#import "YPModuleSwitchCell.h"

@interface YPModuleSwitchCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISwitch *cellSwitch;

@end

@implementation YPModuleSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryType = UITableViewCellAccessoryNone;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.cellSwitch];
}

- (void)setCellModel:(YPPageRouter *)cellModel {
    [super setCellModel:cellModel];
    self.titleLabel.text = cellModel.title?:@"";
    self.cellSwitch.on = cellModel.content.boolValue;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = 20.f;
    f1.size.width = bounds.size.width - f1.origin.x * 2;
    self.titleLabel.frame = f1;
    
    CGRect f2 = bounds;
    f2.size = [self.cellSwitch sizeThatFits:CGSizeZero];
    f2.origin.y = (bounds.size.height - f2.size.height) / 2.f;
    if (self.accessoryType != UITableViewCellAccessoryNone) {
        f2.origin.x = bounds.size.width - f2.size.width - 5.f;
    } else {
        f2.origin.x = bounds.size.width - f2.size.width - 20.f;
    }
    self.cellSwitch.frame = f2;
}

#pragma mark - action

- (void)didChangeSwitch:(UISwitch *)cellSwitch {
    self.cellModel.content = @(!self.cellModel.content.boolValue).stringValue;
    if (self.cellModel.didSelectedCallback) {
        self.cellModel.didSelectedCallback(self.cellModel, self);
    }
}

#pragma mark - getters | setters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17.f];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UISwitch *)cellSwitch {
    if (!_cellSwitch) {
        _cellSwitch = [[UISwitch alloc] init];
        [_cellSwitch addTarget:self action:@selector(didChangeSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _cellSwitch;
}

@end
