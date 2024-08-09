//
//  KKRunLabel.m
//  QMKKXProduct
//
//  Created by Hansen on 7/8/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKRunLabel.h"

@interface KKRunLabel ()<UIScrollViewDelegate>
@property (assign, nonatomic) BOOL along;//是否是顺方向

@end

@implementation KKRunLabel
- (instancetype)init{
    if (self = [super init]) {
        self.along = YES;
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    //to do
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    //to do
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 0;
    [self.scrollView addSubview:self.titleLabel];
    //
    WeakSelf
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.03 repeats:YES handler:^(NSTimer *timer) {
        [weakSelf startRunLabel];
    }];
}
//开始跑马灯
- (void)startRunLabel{
    CGFloat threshold = AdaptedWidth(1);//偏移阈值
    CGPoint point = self.scrollView.contentOffset;
    CGSize size = self.titleLabel.size;
    CGFloat space = AdaptedWidth(20.f);//空隙
    if ((point.x + self.width - space) > size.width) {
        //逆方向
        self.along = NO;
    }else if(point.x < -space){
        //顺方向
        self.along = YES;
    }
    threshold *= self.along?1:-1;
    self.scrollView.contentOffset = CGPointMake(point.x + threshold, 0);
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    //
    CGRect f1 = bounds;
    f1.size = [self.titleLabel sizeThatFits:CGSizeZero];
    f1.size.height = bounds.size.height;
    self.titleLabel.frame = f1;
    //
    CGRect f2 = bounds;
    self.scrollView.frame = f2;
    self.scrollView.contentSize = f1.size;
}
- (CGSize)sizeThatFits:(CGSize)size{
    size = [self.titleLabel sizeThatFits:size];
    size.height = [self.titleLabel sizeThatFits:CGSizeZero].height;
    return size;
}
- (void)dealloc{
    NSLog(@"释放了");
    [self.timer invalidate];
    self.timer = nil;
}
@end
