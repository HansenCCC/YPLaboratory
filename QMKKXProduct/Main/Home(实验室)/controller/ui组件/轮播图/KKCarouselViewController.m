//
//  KKCarouselViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 11/26/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKCarouselViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"
#import "KKCarouselViewCollectionViewCell.h"//轮播cell

@interface KKCarouselViewController ()<KKCarouselViewDelegate>
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) KKCarouselView *carouseHeadView;
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *carouseDatas;

@end

@implementation KKCarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"轮播图";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    //
    CGRect bounds = self.view.bounds;
    self.carouseHeadView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.width * (1.0/2.0));
    self.carouseHeadView.pageControl.hidden = NO;
    self.carouseHeadView.allowAutoNextPage = YES;
    self.carouseHeadView.timeInterval = 3.0f;
    self.tableView.tableHeaderView = self.carouseHeadView;
    [self.carouseHeadView.collectionView registerNib:[UINib nibWithNibName:@"KKCarouselViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"KKCarouselViewCollectionViewCell"];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    //构造cell
    NSArray *items = [UIFont familyNames];
    for (NSString *item in items) {
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:item value:nil];
        [self.datas addObject:element];
    }
    [self.tableView reloadData];
    //
    [self.carouseDatas removeAllObjects];
    NSArray *items2 = @[@"http://d.ifengimg.com/w448_h248_q100/e0.ifengimg.com/10/2019/0403/B64DB51EAECED52BEED1D2E707EFFF5C0CB1C858_size96_w899_h505.jpeg",@"http://d.ifengimg.com/w448_h248_q100/e0.ifengimg.com/04/2019/0403/B6BC5672DF2E36CBA371640273EB9D366F17950F_size109_w1078_h718.jpeg",@"http://d.ifengimg.com/w448_h248_q100/p2.ifengimg.com/2019_14/F298E9962F5E7B988E61ADB37FCABF007ADCF13F_w723_h362.jpg",@"http://d.ifengimg.com/w448_h248_q100/e0.ifengimg.com/06/2019/0403/D3B5B1447A5A1F0B4705F59874CDF859714CF0C6_size623_w3000_h2000.jpeg",@"http://d.ifengimg.com/w448_h248_q100/p1.ifengimg.com/2019_14/46912C918543EA819F79156587E317B74C802242_w750_h376.png",];
    for (NSString *item in items2) {
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:nil value:item];
        [self.carouseDatas addObject:element];
    }
    [self.carouseHeadView reloadData];
    
}
#pragma mark - lazy load
- (NSMutableArray<KKLabelModel *> *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}
- (NSMutableArray<KKLabelModel *> *)carouseDatas{
    if (!_carouseDatas) {
        _carouseDatas = [[NSMutableArray alloc] init];
    }
    return _carouseDatas;
}
- (KKCarouselView *)carouseHeadView{
    if (!_carouseHeadView) {
        _carouseHeadView = [[KKCarouselView alloc] initWithDelegate:self];
    }
    return _carouseHeadView;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datas[indexPath.row];
    KKLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKLabelTableViewCell"];
    cell.cellModel = cellModel;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedWidth(44.f);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //to do
}
#pragma mark - KKCarouselViewDelegate
- (UICollectionViewCell *)kkCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.carouseDatas[indexPath.row];
    KKCarouselViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKCarouselViewCollectionViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"indexPath.row=%ld",(long)indexPath.row];
    [cell.imageView kk_setImageWithUrl:cellModel.value placeholderImage:kPlaceholder2r1];
    return cell;
}
- (NSInteger)kkCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.carouseDatas.count;
}
- (CGSize)kkCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize cellSize = collectionView.bounds.size;
    return cellSize;
}
@end
