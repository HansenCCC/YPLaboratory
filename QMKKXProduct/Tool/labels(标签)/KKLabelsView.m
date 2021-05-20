//
//  KKLabelsView.m
//  KKLAFProduct
//
//  Created by Hansen on 3/18/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKLabelsView.h"

//官方发放的标签label
@implementation KKOfficialLabelsModel


@end

@implementation KKOfficialLabelsCollectionViewFlowLayout
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //使用系统帮我们计算好的结果。
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    //第0个cell没有上一个cell，所以从1开始
    for(int i = 1; i < [attributes count]; ++i) {
        //这里 UICollectionViewLayoutAttributes 的排列总是按照 indexPath的顺序来的。
        UICollectionViewLayoutAttributes *curAttr = attributes[i];
        UICollectionViewLayoutAttributes *preAttr = attributes[i-1];
        NSInteger origin = CGRectGetMaxX(preAttr.frame);
        //根据  maximumInteritemSpacing 计算出的新的 x 位置
        CGFloat targetX = origin + self.maximumInteritemSpacing;
        // 只有系统计算的间距大于  maximumInteritemSpacing 时才进行调整
        if (CGRectGetMinX(curAttr.frame) > targetX) {
            // 换行时不用调整
            if (targetX + CGRectGetWidth(curAttr.frame) < self.collectionViewContentSize.width) {
                CGRect frame = curAttr.frame;
                frame.origin.x = targetX;
                curAttr.frame = frame;
            }
        }
    }
    return attributes;
}
@end


@implementation KKOfficialLabelsCollecitonViewCell
DEF_SINGLETON(KKOfficialLabelsCollecitonViewCell);
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [UILabel labelWithFont:AdaptedFontSize(14.f) textColor:KKColor_FFFFFF];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    self.titleLabel.frame = bounds;
    self.titleLabel.clipsToBounds = YES;
    self.titleLabel.layer.cornerRadius = bounds.size.height/2.0f;
}
@end

@implementation KKLabelsView
- (instancetype)init{
    if (self = [super init]) {
        [self setupSubviews];
    }
    return self;
}
- (void)reloadDatas{
    [self.collectionView reloadData];
}
- (void)setupSubviews{
    self.flowLayout = [[KKOfficialLabelsCollectionViewFlowLayout alloc] init];
    self.flowLayout.sectionInset = UIEdgeInsetsZero;
    self.flowLayout.maximumInteritemSpacing = AdaptedWidth(10.f);
    self.flowLayout.minimumLineSpacing = AdaptedWidth(10.f);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = KKColor_CLEAR;
    [self.collectionView registerClass:[KKOfficialLabelsCollecitonViewCell class] forCellWithReuseIdentifier:@"KKOfficialLabelsCollecitonViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
}
#pragma mark - lazy load
- (NSMutableArray<KKOfficialLabelsModel *> *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KKOfficialLabelsModel *cellModel = self.datas[indexPath.row];
    KKOfficialLabelsCollecitonViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKOfficialLabelsCollecitonViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = cellModel.label;
    cell.titleLabel.backgroundColor = [UIColor colorWithHexString:cellModel.color?:@""];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    KKOfficialLabelsModel *cellModel = self.datas[indexPath.row];
    KKOfficialLabelsCollecitonViewCell *cell = [KKOfficialLabelsCollecitonViewCell sharedInstance];
    cell.bounds = collectionView.bounds;
    cell.titleLabel.text = cellModel.label;
    CGSize size = [cell.titleLabel sizeThatFits:CGSizeZero];
    size.width += AdaptedWidth(30.f);
    size.height = AdaptedWidth(30.f);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.whenAcitonClick){
        self.whenAcitonClick(self, indexPath.row);
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    self.collectionView.frame = bounds;
}
- (CGSize)sizeThatFits:(CGSize)size{
    //获取总共有多少行
    int row = 0;
    CGFloat collectionWidth = size.width;
    CGFloat width = 0;
    if (self.datas.count > 0) {
        row = 1;
    }
    for (KKOfficialLabelsModel *cellModel in self.datas) {
        CGFloat space = self.flowLayout.maximumInteritemSpacing;
        KKOfficialLabelsCollecitonViewCell *cell = [KKOfficialLabelsCollecitonViewCell sharedInstance];
        cell.bounds = self.collectionView.bounds;
        cell.titleLabel.text = cellModel.label;
        CGSize size = [cell.titleLabel sizeThatFits:CGSizeZero];
        size.width += AdaptedWidth(30.f);
        size.height = AdaptedWidth(30.f);
        width += size.width + space;
        if ((width - space) >= collectionWidth) {
            row += 1;
            width = size.width + space;
        }
    }
    CGFloat space = self.flowLayout.minimumLineSpacing;
    CGFloat height = row * AdaptedWidth(30.f) + (row - 1) * space;
    size.height = height;
    return size;
}
@end
