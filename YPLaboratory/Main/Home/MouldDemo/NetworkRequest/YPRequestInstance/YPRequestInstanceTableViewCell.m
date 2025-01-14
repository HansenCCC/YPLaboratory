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

@property (nonatomic, strong) YPTextView *textView;

@end

@implementation YPRequestInstanceTableViewCell

+ (instancetype)shareInstance {
    static YPRequestInstanceTableViewCell *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[YPRequestInstanceTableViewCell alloc] init];
    });
    return m;
}

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
    [self.contentView addSubview:self.textView];
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

    if ([cellModel.model isKindOfClass:[YpApiRequest class]] && cellModel.isShow) {
        YpApiRequest *request = cellModel.model;
        // 构造格式化字符串
        NSMutableString *requestInfo = [NSMutableString string];
        [requestInfo appendFormat:@"Method: %@\n", request.method];
        [requestInfo appendFormat:@"Start Date: %@\n", request.startDate];
        [requestInfo appendFormat:@"End Date: %@\n", request.endDate];
        if (request.startDate && request.endDate) {
            NSTimeInterval timeInterval = [request.endDate timeIntervalSinceDate:request.startDate];
            NSInteger milliseconds = (NSInteger)(timeInterval * 1000);
            [requestInfo appendFormat:@"Request Duration: %ld ms", (long)milliseconds];
        } else {
            [requestInfo appendString:@"Request Duration: N/A"];
        }
        [requestInfo appendFormat:@"URL: \n%@\n", request.url];
        [requestInfo appendFormat:@"Headers: \n%@\n", request.headers];
        [requestInfo appendFormat:@"Body: \n%@\n", request.body];
        [requestInfo appendFormat:@"Response: \n%@", request.response];
        self.textView.text = requestInfo;
        self.textView.hidden = NO;
    } else {
        self.textView.text = nil;
        self.textView.hidden = YES;
    }
    
    [self layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    bounds.size.height = 44.f;
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
    
    CGRect f2 = self.contentView.bounds;
    f2.size.width = 8.f;
    f2.origin.x = bounds.size.width - f2.size.width;
    self.statusView.frame = f2;
        
    CGRect f3 = bounds;
    f3.origin.x = 15.f;
    f3.origin.y = 44.f;
    f3.size = [self.textView sizeThatFits:CGSizeMake(bounds.size.width - f3.origin.x * 2, 0)];
    f3.size.width = bounds.size.width - f3.origin.x * 2;
    self.textView.frame = f3;
}

- (CGFloat)cellHeight {
    if (!self.cellModel.isShow) {
        return 44.f;
    }
    return CGRectGetMaxY(self.textView.frame) + 15.f;
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
        _textView.scrollEnabled = NO;
    }
    return _textView;
}

@end
