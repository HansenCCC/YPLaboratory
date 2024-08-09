//
//  YPModuleButtonCell.m
//  YPLaboratory
//
//  Created by Hansen on 2023/6/4.
//

#import "YPModuleButtonCell.h"

@interface YPModuleButtonCell ()

@property (nonatomic, strong) YPButton *button;

@end

@implementation YPModuleButtonCell

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
    [self.contentView addSubview:self.button];
}

- (void)setCellModel:(YPPageRouter *)cellModel {
    [super setCellModel:cellModel];
    [self.button setTitle:cellModel.title?:@"" forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    self.button.frame = f1;
}

#pragma mark - action

- (void)didChangeSwitch:(UISwitch *)cellSwitch {
    self.cellModel.content = @(!self.cellModel.content.boolValue).stringValue;
}

#pragma mark - getters | setters

- (YPButton *)button {
    if (!_button) {
        _button = [[YPButton alloc] init];
        _button.userInteractionEnabled = NO;
        _button.titleLabel.font = [UIFont systemFontOfSize:17.f];
        [_button setTitleColor:[UIColor yp_themeColor] forState:UIControlStateNormal];
    }
    return _button;
}

@end
