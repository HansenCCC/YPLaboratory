//
//  YPWaterfallFlowViewController.m
//  YPLaboratory
//
//  Created by Hansen on 2024/11/5.
//

#import "YPWaterfallFlowViewController.h"
#import "YPCollectionViewWaterfallFlowLayout.h"
#import "YPWaterfallFlowCollectionViewCell.h"

@interface YPWaterfallFlowViewController () <UICollectionViewDelegate, UICollectionViewDataSource, YPCollectionViewWaterfallFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) YPCollectionViewWaterfallFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation YPWaterfallFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    [self reloadDatas];
}

- (void)setupSubviews {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
}

- (void)reloadDatas {
    NSString *cellPath = [[NSBundle mainBundle] pathForResource:@"Waterfall.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:cellPath];
    NSError *error = nil;
    NSArray *items = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    for (NSString *string in items) {
        YPPageRouter *model = [[YPPageRouter alloc] init];
        model.title = string;
        [dataList addObject:model];
    }
    self.dataList = [dataList copy];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YPWaterfallFlowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPWaterfallFlowCollectionViewCell" forIndexPath:indexPath];
    cell.cellModel = self.dataList[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

#pragma mark - YPCollectionViewWaterfallFlowLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect f1 = collectionView.bounds;
    CGFloat minimumLineSpacing = self.flowLayout.minimumLineSpacing;
    f1.size.width = (f1.size.width - (self.flowLayout.numberOfColumns + 1) * minimumLineSpacing) / (CGFloat)self.flowLayout.numberOfColumns;
    YPWaterfallFlowCollectionViewCell *cell = [YPWaterfallFlowCollectionViewCell shareInstance];
    cell.bounds = f1;
    cell.cellModel = self.dataList[indexPath.row];
    [cell layoutSubviews];
    CGFloat height = CGRectGetMaxY(cell.contentView.yp_verticalBottomView.frame) + 10.f;
    return height;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [[YPShakeManager shareInstance] tapShare];
}

#pragma mark - getters | setters

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[YPWaterfallFlowCollectionViewCell class] forCellWithReuseIdentifier:@"YPWaterfallFlowCollectionViewCell"];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(0.f, 10.f, 0.f, -10.f);
    }
    return _collectionView;
}

- (YPCollectionViewWaterfallFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[YPCollectionViewWaterfallFlowLayout alloc] init];
        _flowLayout.delegate = self;
        _flowLayout.minimumLineSpacing = 10.f;
        _flowLayout.minimumInteritemSpacing = 10.f;
        _flowLayout.numberOfColumns = 2;
    }
    return _flowLayout;
}

@end
