//
//  YPBarcodeAndQRCodeCell.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import "YPBarcodeAndQRCodeCell.h"

@interface YPBarcodeAndQRCodeCell ()

@property (nonatomic, strong) UIImageView *qrImageView;

@end

@implementation YPBarcodeAndQRCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self.contentView addSubview:self.qrImageView];
}

- (void)setCellModel:(YPPageRouter *)cellModel {
    [super setCellModel:cellModel];
    if (cellModel.extend) {
        self.qrImageView.image = cellModel.extend;
    } else {
        self.qrImageView.image = nil;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.size.width = MIN(500.f - 2 * 20.f, bounds.size.width - 2 * 20.f);
    f1.size.height = f1.size.width;
    f1.origin.x = (bounds.size.width - f1.size.width) / 2.f;
    f1.origin.y = (bounds.size.height - f1.size.height) / 2.f;
    f1.size.height = f1.size.width;
    self.qrImageView.frame = f1;
}

#pragma mark - getters | setters

- (UIImageView *)qrImageView {
    if (!_qrImageView) {
        _qrImageView = [[UIImageView alloc] init];
        _qrImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _qrImageView;
}

@end
