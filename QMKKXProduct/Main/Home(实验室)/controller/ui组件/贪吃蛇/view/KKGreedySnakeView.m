//
//  KKGreedySnakeView.m
//  QMKKXProduct
//
//  Created by Hansen on 6/29/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKGreedySnakeView.h"

@interface KKGreedySnakeView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (assign, nonatomic) NSUInteger maxRow;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation KKGreedySnakeView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.maxRow = 500;
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.minimumLineSpacing = 0.f;
    self.flowLayout.minimumInteritemSpacing = 0.f;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = KKColor_FFFFFF;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = NO;
    [self addSubview:self.collectionView];
    //
    [self.collectionView registerClass:[KKGreedySnakeCell class] forCellWithReuseIdentifier:@"KKGreedySnakeCell"];
    //
    WeakSelf
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES handler:^(NSTimer *timer) {
        [weakSelf updateSubviews];
    }];
}
- (void)updateSubviews{
    self.datas = [[NSMutableArray alloc] initWithArray:@[@(43),@(44),@(45),@(46)]];
    [self.collectionView reloadData];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    self.collectionView.frame = f1;
    CGFloat lineRow = 10.f;
    CGSize itemSize = CGSizeZero;
    itemSize.width = bounds.size.width/lineRow;
    itemSize.height = bounds.size.width/lineRow;
    self.flowLayout.itemSize = itemSize;
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KKGreedySnakeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKGreedySnakeCell" forIndexPath:indexPath];
    BOOL flag = [self.datas containsObject:@(indexPath.row)];
    if (flag) {
        cell.backgroundColor = KKColor_RANDOM;
    }else{
        cell.backgroundColor = KKColor_FFFFFF;
    }
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.maxRow;
}
@end
