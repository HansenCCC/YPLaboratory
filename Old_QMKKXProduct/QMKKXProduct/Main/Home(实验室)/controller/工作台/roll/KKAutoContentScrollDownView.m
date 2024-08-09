//
//  KKAutoContentScrollDownView.m
//  QMKKXProduct
//
//  Created by Hansen on 2021/11/10.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKAutoContentScrollDownView.h"

@interface KKAutoContentScrollDownView ()

@property (nonatomic, strong) UILabel *currentView;
@property (nonatomic, strong) UILabel *nextView;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation KKAutoContentScrollDownView

- (instancetype)init {
    if (self = [super init]) {
        self.currentIndex = 0;
        self.backgroundColor = [UIColor blueColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self addSubview:self.currentView];
    [self addSubview:self.nextView];
}

- (void)setContents:(NSArray<NSString *> *)contents {
    _contents = contents;
}

- (void)startTimingRun {
    [self prepareToAnimate];
    if (self.contents.count <= 1) {
        return;
    }
    [self.class cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(doNextAnimate) withObject:nil afterDelay:2.f];
}

- (void)prepareToAnimate {
    CGFloat height = self.frame.size.height;
    self.currentView.alpha = 1.f;
    self.currentView.transform = CGAffineTransformIdentity;
    self.nextView.alpha = 0.f;
    self.nextView.transform = CGAffineTransformMakeTranslation(0, height);
    //
    NSInteger currentIndex = self.currentIndex;
    NSInteger nextIndex = self.currentIndex + 1;
    if (nextIndex >= self.contents.count) {
        nextIndex = 0;
    }
    NSString *currentString = self.contents[currentIndex];
    NSString *nextString = self.contents[nextIndex];
    self.currentView.text = currentString;
    self.nextView.text = nextString;
}

- (void)doNextAnimate {
    CGFloat height = self.frame.size.height;
    [UIView animateWithDuration:0.25f animations:^{
        self.currentView.transform = CGAffineTransformMakeTranslation(0, -height);
        self.nextView.transform = CGAffineTransformIdentity;
        self.currentView.alpha = 0.f;
        self.nextView.alpha = 1.f;
        UILabel *tempView = self.currentView;
        self.currentView = self.nextView;
        self.nextView = tempView;
    } completion:^(BOOL finished) {
        self.currentIndex ++;
        if (self.currentIndex >= self.contents.count) {
            self.currentIndex = 0;
        }
        [self startTimingRun];
    }];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.currentView.frame = self.bounds;
    self.nextView.frame = self.bounds;
    [self prepareToAnimate];
}

#pragma mark - getters

- (UILabel *)currentView {
    if (!_currentView) {
        UILabel *label = [[UILabel alloc] init];
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        _currentView = label;
    }
    return _currentView;
}

- (UILabel *)nextView {
    if (!_nextView) {
        UILabel *label = [[UILabel alloc] init];
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        _nextView = label;
    }
    return _nextView;
}

@end
