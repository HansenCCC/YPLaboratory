//
//  YPNetworkInfoCell.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/13.
//

#import "YPNetworkInfoCell.h"
#import "YpApiRequestDao.h"

@interface YPNetworkInfoCell () <UITextFieldDelegate>

@property (nonatomic, strong) YPTextView *textView;

@end

@implementation YPNetworkInfoCell

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
    [self.contentView addSubview:self.textView];
}

- (void)setCellModel:(YPPageRouter *)cellModel {
    [super setCellModel:cellModel];
    if ([cellModel.extend isKindOfClass:[YpApiRequest class]]) {
        YpApiRequest *request = cellModel.extend;
        self.textView.text = @"iOS Lab,Development,Beginner Development,OC Learning,Software Development,Programming,UIKit,Network Requests,Domain Resolution,Network Diagnostics,File Download,Port Scanning,File Management,QR Code,Barcode,Face Tracking,Color Picker,Waterfall Flow,Learn Development,Software Testing https://www.kdocs.cn/l/cns5XmAPHnAH";
    } else {
        self.textView.text = nil;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = 15.f;
    f1.origin.y = 5.f;
    f1.size = [self.textView sizeThatFits:CGSizeMake(bounds.size.width - f1.origin.x * 2, 0)];
    self.textView.frame = f1;
}

#pragma mark - getters | setters

- (YPTextView *)textView {
    if (!_textView) {
        _textView = [[YPTextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:15.f];
        _textView.textColor = [UIColor yp_blackColor];
        _textView.backgroundColor = [UIColor yp_gray6Color];
        _textView.editable = NO;
        _textView.selectable = YES;
        _textView.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _textView;
}
@end
