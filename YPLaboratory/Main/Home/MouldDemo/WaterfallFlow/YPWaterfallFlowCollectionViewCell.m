//
//  YPWaterfallFlowCollectionViewCell.m
//  YPLaboratory
//
//  Created by Hansen on 2024/11/5.
//

#import "YPWaterfallFlowCollectionViewCell.h"

@interface YPWaterfallFlowCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YPWaterfallFlowCollectionViewCell

+ (instancetype)shareInstance {
    static YPWaterfallFlowCollectionViewCell *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[YPWaterfallFlowCollectionViewCell alloc] init];
    });
    return m;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [UILabel yp_labelWithFont:[UIFont systemFontOfSize:16.f] textColor:[UIColor yp_darkColor]];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor = [UIColor yp_blackColor];
        [self.contentView addSubview:self.titleLabel];
        
        self.layer.cornerRadius = 8.f;
        self.backgroundColor = [UIColor yp_whiteColor];
    }
    return self;
}

- (void)setCellModel:(YPPageRouter *)cellModel {
    _cellModel = cellModel;
    self.titleLabel.text = cellModel.title;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    
    CGRect f1 = bounds;
    f1.origin.x = 10.f;
    f1.origin.y = 10.f;
    f1.size = [self.titleLabel sizeThatFits:CGSizeMake(bounds.size.width - f1.origin.x * 2, 0)];
    f1.size.width = bounds.size.width - f1.origin.x * 2;
    self.titleLabel.frame = f1;
}

@end

