//
//  YPRequestInstanceTableViewCell.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/13.
//

#import "YPRequestInstanceTableViewCell.h"
#import "YPRequestInstanceModel.h"
#import "YpApiRequestDao.h"

@interface YPRequestInstanceTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *methodLabel;
@property (nonatomic, strong) UIView *statusView;

@end

@implementation YPRequestInstanceTableViewCell

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
    [self.contentView addSubview:self.methodLabel];
    [self.contentView addSubview:self.statusView];
}

- (void)setCellModel:(YPRequestInstanceModel *)cellModel {
    _cellModel = cellModel;
    NSString *methodString = cellModel.model.method;
    NSString *hexColor = @"#000000";
    if ([methodString isEqualToString:@"GET"]) {
        hexColor = @"#17b26a";
    } else if ([methodString isEqualToString:@"POST"]) {
        hexColor = @"#ef6820";
    } else if ([methodString isEqualToString:@"PUT"]) {
        hexColor = @"#2e90fa";
    } else if ([methodString isEqualToString:@"DELETE"]) {
        hexColor = @"#f04438";
    } else if ([methodString isEqualToString:@"HEAD"]) {
        hexColor = @"#ee46bc";
    }
    self.methodLabel.text = methodString;
    self.methodLabel.backgroundColor = [UIColor yp_colorWithHexString:hexColor];
    self.titleLabel.text = [NSString stringWithFormat:@"%ld、%@", cellModel.model.id, cellModel.model.url];
    
    if (cellModel.model.isLoading) {
        self.statusView.backgroundColor = [UIColor yp_colorWithHexString:@"#FFD700"]; // 金黄色，代表加载中，吸引注意力
    } else {
        if (cellModel.model.success) {
            self.statusView.backgroundColor = [UIColor yp_colorWithHexString:@"#32CD32"]; // 亮绿色，代表成功，传递正向情绪
        } else {
            self.statusView.backgroundColor = [UIColor yp_colorWithHexString:@"#FF4500"]; // 橙红色，代表失败，清晰明了
        }
    }
    
    [self layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f0 = bounds;
    f0.size = [self.methodLabel sizeThatFits:CGSizeMake(0, 0)];
    f0.size.width += 15.f;
    f0.size.height += 8.f;
    f0.origin.x = 10.f;
    f0.origin.y = (bounds.size.height - f0.size.height) / 2.f;
    self.methodLabel.frame = f0;
    
    CGRect f1 = bounds;
    f1.origin.x = CGRectGetMaxX(f0) + 10.f;
    f1.size.width = bounds.size.width - f1.origin.x - 15.f;
    self.titleLabel.frame = f1;
    
    CGRect f2 = bounds;
    f2.size.width = 8.f;
    f2.origin.x = bounds.size.width - f2.size.width;
    self.statusView.frame = f2;
}

#pragma mark - getters | setters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textColor = [UIColor yp_blackColor];
    }
    return _titleLabel;
}

- (UILabel *)methodLabel {
    if (!_methodLabel) {
        _methodLabel = [[UILabel alloc] init];
        _methodLabel.font = [UIFont boldSystemFontOfSize:12.f];
        _methodLabel.textColor = [UIColor yp_whiteColor];
        _methodLabel.textAlignment = NSTextAlignmentCenter;
        _methodLabel.layer.cornerRadius = 5.f;
        _methodLabel.clipsToBounds = YES;
    }
    return _methodLabel;
}

- (UIView *)statusView {
    if (!_statusView) {
        _statusView = [[UIView alloc] init];
    }
    return _statusView;
}

@end
