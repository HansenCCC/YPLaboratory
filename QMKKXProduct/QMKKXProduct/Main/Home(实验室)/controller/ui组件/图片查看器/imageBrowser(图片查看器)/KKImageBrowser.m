//
//  KKImageBrowser.m
//  QMKKXProduct
//
//  Created by Hansen on 6/17/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKImageBrowser.h"

@interface KKImageBrowser ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) BOOL cacheStatusBarHidden;
@property (assign, nonatomic) UIView *weakView;
@property (strong, nonatomic) UIImageView *placeholderView;//占位试图

@end

@implementation KKImageBrowser
- (instancetype)init{
    if (self = [super init]) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    self.backgroundColor = KKColor_000000;
    //
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = KKColor_FFFFFF;
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerClass:[KKImageBrowserCell class] forCellWithReuseIdentifier:@"KKImageBrowserCell"];
    //增加占位图
    self.placeholderView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.placeholderView.contentMode = UIViewContentModeScaleAspectFit;
    self.placeholderView.backgroundColor = KKColor_000000;
    [self addSubview:self.placeholderView];
}
- (void)removeShow{
    //复原状态栏
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //隐藏状态栏
    //状态栏优先UIApplication控制 UIViewControllerBasedStatusBarAppearance -> NO
    //状态栏优先UIViewController控制 UIViewControllerBasedStatusBarAppearance -> YES
    [[UIApplication sharedApplication] setStatusBarHidden:self.cacheStatusBarHidden];
    #pragma clang diagnostic pop
    self.placeholderView.hidden = NO;
    //
    UIView *view = self.weakView;
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    CGRect f1 = window.bounds;
    CGRect f2 = [view convertRect:view.bounds toView:window];
    if (view == nil) {
        CGPoint point = window.center;
        f2 = CGRectMake(point.x, point.y, 0, 0);
    }
    self.frame = f1;
    self.collectionView.frame = self.bounds;
    self.placeholderView.frame = self.bounds;
    //执行动画
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = f2;
        self.collectionView.frame = self.bounds;
        self.placeholderView.frame = self.bounds;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
//展示
- (void)show{
    if (self.images.count == 0) {
        NSAssert(NO, @"图片内容不能为空");
        return;
    }
    //记录状态栏
    self.cacheStatusBarHidden = [UIApplication sharedApplication].statusBarHidden;
    //隐藏状态栏
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    #pragma clang diagnostic pop
    //
    NSInteger index = self.index;
    KKImageBrowserModel *cellModel = self.images[index];
    UIView *view = cellModel.toView;
    self.weakView = view;
    //设置占位图片
    [self.placeholderView kk_setImageWithUrl:cellModel.url.absoluteString];
    //
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    CGRect f1 = [view convertRect:view.bounds toView:window];
    if (view == nil) {
        CGPoint point = window.center;
        f1 = CGRectMake(point.x, point.y, 0, 0);
    }
    CGRect f2 = window.bounds;
    self.frame = f1;
    self.collectionView.frame = self.bounds;
    self.placeholderView.frame = self.bounds;
    [self.collectionView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = f2;
        self.collectionView.frame = self.bounds;
        self.placeholderView.frame = self.bounds;
        [self.collectionView reloadData];
    } completion:^(BOOL finished) {
        self.collectionView.contentOffset = CGPointMake(index * f2.size.width, 0);
        self.placeholderView.hidden = YES;
    }];
    [window addSubview:self];
}
- (void)setImages:(NSArray<KKImageBrowserModel *> *)images{
    _images = images;
    [self.collectionView reloadData];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KKImageBrowserModel *cellModel = self.images[indexPath.row];
    KKImageBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKImageBrowserCell" forIndexPath:indexPath];
    cell.cellModel = cellModel;
    WeakSelf
    cell.whenActionClick = ^(NSInteger index) {
        if (index == 0) {
            //单击了
            [weakSelf removeShow];
        }else if(index == 1){
            //双击了
        }
    };
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self whenNeedChangeWeakView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate) {
        //进入，不操作
    }else{
        //不进入，自动播放判断
        [self whenNeedChangeWeakView];
    }
}
//需要修改weakview
- (void)whenNeedChangeWeakView{
    CGPoint point = self.collectionView.contentOffset;
    point.x += self.center.x;
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    KKImageBrowserModel *cellModel = self.images[indexPath.row];
    self.weakView = cellModel.toView;
    [self.placeholderView kk_setImageWithUrl:cellModel.url.absoluteString];
}
@end
