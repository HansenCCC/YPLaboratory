//
//  YPSystemFontsTableViewCell.m
//  YPLaboratory
//
//  Created by Hansen on 2023/7/19.
//

#import "YPSystemFontsTableViewCell.h"
#import "YPPageRouter.h"

@interface YPSystemFontsTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation YPSystemFontsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
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
    self.titleLabel.font = [UIFont fontWithName:cellModel.content?:@"" size:17.f];
    self.contentLabel.text = cellModel.content?:@"";
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = 20.f;
    f1.size.width = bounds.size.width - f1.origin.x * 2;
    self.titleLabel.frame = f1;
    
    CGRect f2 = bounds;
    f2.size.width = [self.contentLabel sizeThatFits:CGSizeMake(100.f, 0)].width;
    f2.origin.x = bounds.size.width - f2.size.width - 20.f;
    self.contentLabel.frame = f2;
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

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:15.f];
        _contentLabel.textColor = [UIColor blackColor];
    }
    return _contentLabel;
}

@end
