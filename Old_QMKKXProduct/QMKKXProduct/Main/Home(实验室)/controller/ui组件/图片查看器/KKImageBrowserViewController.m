//
//  KKImageBrowserViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 6/17/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKImageBrowserViewController.h"
#import "KKImageBrowser.h"


@interface KKImageBrowserViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation KKImageBrowserViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"仿微信图片查看器(基于KKImageBrowser)";
    self.datas = [[NSMutableArray alloc] init];
    [self setupSubvuews];
    [self updateDatas];
}
- (void)setupSubvuews{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(AdaptedWidth(10), AdaptedWidth(10), AdaptedWidth(10), AdaptedWidth(10));
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView.bounces = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = KKColor_FFFFFF;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"KKImageViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"KKImageViewCollectionViewCell"];
}
- (void)updateDatas{
    [self.datas removeAllObjects];
    NSArray *items = @[
        @"http://d.ifengimg.com/w448_h248_q100/e0.ifengimg.com/10/2019/0403/B64DB51EAECED52BEED1D2E707EFFF5C0CB1C858_size96_w899_h505.jpeg",
        @"http://d.ifengimg.com/w448_h248_q100/e0.ifengimg.com/04/2019/0403/B6BC5672DF2E36CBA371640273EB9D366F17950F_size109_w1078_h718.jpeg",
        @"http://d.ifengimg.com/w448_h248_q100/p2.ifengimg.com/2019_14/F298E9962F5E7B988E61ADB37FCABF007ADCF13F_w723_h362.jpg",
        @"http://d.ifengimg.com/w448_h248_q100/e0.ifengimg.com/06/2019/0403/D3B5B1447A5A1F0B4705F59874CDF859714CF0C6_size623_w3000_h2000.jpeg",
        @"http://d.ifengimg.com/w448_h248_q100/p1.ifengimg.com/2019_14/46912C918543EA819F79156587E317B74C802242_w750_h376.png",
    ];
    //to do
    [self.datas addObjectsFromArray:items];
    [self.datas addObjectsFromArray:items];
    [self.datas addObjectsFromArray:items];
    [self.datas addObjectsFromArray:items];
    [self.datas addObjectsFromArray:items];
    [self.datas addObjectsFromArray:items];
    [self.datas addObjectsFromArray:items];
    [self.datas addObjectsFromArray:items];
    [self.datas addObjectsFromArray:items];
    [self.collectionView reloadData];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    self.collectionView.frame = f1;
    //
    NSInteger number = 4;
    CGFloat spaceWidth = AdaptedWidth(5.f);//cell中间距离
    CGFloat collecitonWidth = bounds.size.width - (self.flowLayout.sectionInset.left + self.flowLayout.sectionInset.right);//collectionView宽度
    self.flowLayout.minimumLineSpacing = spaceWidth;
    self.flowLayout.minimumInteritemSpacing = spaceWidth;
    //大于两张时
    self.flowLayout.itemSize = CGSizeMake((collecitonWidth - (number - 1) * spaceWidth)/number, (collecitonWidth - (number - 1) * spaceWidth)/number);
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KKImageViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKImageViewCollectionViewCell" forIndexPath:indexPath];
    NSString *imageUrl = self.datas[indexPath.row];
    [cell.imageView kk_setImageWithUrl:imageUrl];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self mainCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
    });
}
#pragma mark - action
- (void)mainCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //展示图片
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.datas.count; i ++) {
        NSString *image = self.datas[i];
        KKImageBrowserModel *model = [[KKImageBrowserModel alloc] initWithUrl:image.toURL type:KKImageBrowserImageType];
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:index];
        model.toView = cell;
        [datas addObject:model];
    }
    KKImageBrowser *view = [[KKImageBrowser alloc] init];
    view.images = datas;
    view.index = indexPath.row;
    [view show];
}
@end
