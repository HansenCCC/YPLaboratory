//
//  KKFileViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 11/25/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKFileViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"

@interface KKFileViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation KKFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.filePath;
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = self.filePath;
    NSArray *tempArray = [manager contentsOfDirectoryAtPath:path error:nil];
    for (NSString *item in tempArray) {
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:item value:nil];
        [self.datas addObject:element];
    }
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGFloat space = AdaptedWidth(10.f);//间隙
    NSInteger count = 4;//一行显示个数
    CGRect bounds = self.view.bounds;
    CGSize itemSize = CGSizeZero;
    itemSize.width = (bounds.size.width - (count + 2) * space)/count;
    itemSize.height = itemSize.width + space * 2;
    self.flowLayout.minimumLineSpacing = space;
    self.flowLayout.minimumInteritemSpacing = space;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(space, space, space, space);
    self.flowLayout.itemSize = itemSize;
}
#pragma mark - lazy load
- (NSMutableArray<KKLabelModel *> *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRandomColor];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
@end
