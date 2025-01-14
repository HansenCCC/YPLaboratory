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

+ (instancetype)shareInstance {
    static YPNetworkInfoCell *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[YPNetworkInfoCell alloc] init];
    });
    return m;
}

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
        // 构造格式化字符串
        NSMutableString *requestInfo = [NSMutableString string];
        [requestInfo appendFormat:@"ID: %ld\n", request.id];
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
    } else {
        self.textView.text = nil;
    }
    [self layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = 15.f;
    f1.origin.y = 15.f;
    f1.size = [self.textView sizeThatFits:CGSizeMake(bounds.size.width - f1.origin.x * 2, 0)];
    f1.size.width = bounds.size.width - f1.origin.x * 2;
    self.textView.frame = f1;
}

- (CGFloat)cellHeight {
    return CGRectGetMaxY(self.textView.frame) + 15.f;
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
