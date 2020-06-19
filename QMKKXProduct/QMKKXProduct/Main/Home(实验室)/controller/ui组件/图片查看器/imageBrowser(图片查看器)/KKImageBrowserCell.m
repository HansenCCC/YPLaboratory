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

@interface KKImageBrowserCell ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITapGestureRecognizer *tapTwoGestureRecognizer;
@property (strong, nonatomic) UITapGestureRecognizer *tapOneGestureRecognizer;

@end

@implementation KKImageBrowserCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    self.backgroundColor = KKColor_000000;
    //
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = YES;
    self.scrollView.multipleTouchEnabled = YES;
    self.scrollView.maximumZoomScale = 5;
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
    //
    [self.tapOneGestureRecognizer requireGestureRecognizerToFail:self.tapTwoGestureRecognizer];
}
- (void)whenTapOneClick:(id)sender{
    //单击
    if (self.whenActionClick) {
        self.whenActionClick(0);
    }
}
- (void)whenTapTwoClick:(UITapGestureRecognizer *)sender{
    //双击
    if (self.whenActionClick) {
        self.whenActionClick(1);
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
        zoomScale += 2;
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
@end
