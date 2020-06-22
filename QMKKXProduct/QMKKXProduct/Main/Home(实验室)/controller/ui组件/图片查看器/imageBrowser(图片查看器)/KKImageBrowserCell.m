//
//  KKImageBrowserCell.m
//  QMKKXProduct
//
//  Created by Hansen on 6/18/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKImageBrowserCell.h"

@implementation KKImageBrowserModel
/// 快速创建model
/// @param url url
/// @param type 类型
- (instancetype)initWithUrl:(NSURL *)url type:(KKImageBrowserType) type{
    if (self = [self init]) {
        self.url = url;
        self.type = type;
    }
    return self;
}
@end

@interface KKImageBrowserCell ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) UITapGestureRecognizer *tapTwoGestureRecognizer;
@property (strong, nonatomic) UITapGestureRecognizer *tapOneGestureRecognizer;
@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
//
@property (assign, nonatomic) CGPoint panBeginPoint;
@end

@implementation KKImageBrowserCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    self.backgroundColor = KKColor_CLEAR;
    //
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = KKColor_CLEAR;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = YES;
    self.scrollView.multipleTouchEnabled = YES;
    self.scrollView.maximumZoomScale = 4;
    self.scrollView.minimumZoomScale = 1;
    [self.contentView addSubview:self.scrollView];
    //
    self.browserImageView = [[UIImageView alloc] init];
    self.browserImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:self.browserImageView];
    //
    [self addGestureRecognizer];
}
- (void)addGestureRecognizer{
    self.tapOneGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOneClick:)];
    [self addGestureRecognizer:self.tapOneGestureRecognizer];
    //
    self.tapTwoGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapTwoClick:)];
    self.tapTwoGestureRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:self.tapTwoGestureRecognizer];
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(whenPanClick:)];
    self.panGestureRecognizer.delegate = self;
    [self addGestureRecognizer:self.panGestureRecognizer];
    //
    [self.tapOneGestureRecognizer requireGestureRecognizerToFail:self.tapTwoGestureRecognizer];
    [self.tapOneGestureRecognizer requireGestureRecognizerToFail:self.panGestureRecognizer];
    [self.tapTwoGestureRecognizer requireGestureRecognizerToFail:self.panGestureRecognizer];
}
//单击手势
- (void)whenTapOneClick:(id)sender{
    //单击
    if (self.whenActionClick) {
        self.whenActionClick(self,0);
    }
}
//双击手势
- (void)whenTapTwoClick:(UITapGestureRecognizer *)sender{
    //双击
    if (self.whenActionClick) {
        self.whenActionClick(self,1);
    }
    //双击图片，进行放大处理
    UIScrollView *scrollView = self.scrollView;
    UIView *zoomView = [self viewForZoomingInScrollView:scrollView];
    CGPoint point = [sender locationInView:zoomView];
    //判断图片是否在双击点上
    if (!CGRectContainsPoint(zoomView.bounds, point)){
        return;
    }
    NSInteger normalScale = 1;
    if (scrollView.zoomScale >= scrollView.maximumZoomScale) {
        [scrollView setZoomScale:normalScale animated:YES];
    }else{
        CGFloat zoomScale = scrollView.zoomScale;
        zoomScale = 4;
        if (zoomScale >= scrollView.maximumZoomScale) {
            zoomScale = scrollView.maximumZoomScale;
        }
        CGFloat width = scrollView.width/zoomScale;
        CGFloat height = scrollView.height/zoomScale;
        CGFloat x = point.x - width/2.0;
        CGFloat y = point.y - height/2.0;
        [scrollView zoomToRect:CGRectMake(x, y, width, height) animated:YES];
    }
}
//拖动手势
- (void)whenPanClick:(UIPanGestureRecognizer *)sender{
    //如果上级已经在滚动中，则取消当前试图移动手势
    UICollectionView *collectionView = (UICollectionView *)self.superview;
    if ([collectionView isKindOfClass:[UICollectionView class]]) {
        if (collectionView.dragging||collectionView.decelerating) {
            return;
        }
    }
    CGPoint point = [sender locationInView:self];
    CGPoint translation = [sender translationInView:self];
    CGPoint center = self.browserImageView.center;
    CGFloat maxHeight = self.bounds.size.height * 0.3;//阈值
    if (sender.state == UIGestureRecognizerStateBegan) {
        // Star.
        self.panBeginPoint = point;
    } else if (sender.state == UIGestureRecognizerStateCancelled || sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateRecognized || sender.state == UIGestureRecognizerStateFailed) {
        // End.
        //满足隐藏的条件
        if (sender.state == UIGestureRecognizerStateEnded) {
            if (fabs(point.y - self.panBeginPoint.y) > maxHeight) {
                //单击
                if (self.whenActionClick) {
                    self.whenActionClick(self,2);
                }
                return;
            }
        }
        //没有满足取消隐藏的条件
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.center = center;
            self.weakBackgroundView.alpha = 1;
            self.scrollView.transform = CGAffineTransformIdentity;
        }];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        // Change.
        center.x += (point.x - self.panBeginPoint.x);
        center.y += (point.y - self.panBeginPoint.y);
        self.scrollView.center = center;
        CGFloat value = 1 - fabs(translation.y)/self.size.height;
        self.weakBackgroundView.alpha = value;
        self.scrollView.transform = CGAffineTransformMakeScale(value, value);
    }
}
- (void)setCellModel:(KKImageBrowserModel *)cellModel{
    _cellModel = cellModel;
    self.scrollView.zoomScale = 1.0f;
    [self.browserImageView kk_setImageWithUrl:cellModel.url.absoluteString];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    self.browserImageView.frame = f1;
    //
    CGRect f2 = bounds;
    self.scrollView.frame = f2;
}
#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.browserImageView;
}
//缩放中
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
}
//移动中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.isZooming) {
        //是否同时在放大
    }else{
        //单纯移动
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [(UIPanGestureRecognizer*)gestureRecognizer translationInView:self];
        if (fabs(translation.x) > fabs(translation.y) ) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return YES;
    }
}
@end
