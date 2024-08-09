//
//  KKBeeViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 6/8/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKBeeViewController.h"
#import "KKCarouselViewCollectionViewCell.h"


@interface KKBeeViewController ()<UITableViewDelegate,UITableViewDataSource,KKCarouselViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datas;
@property (strong, nonatomic) NSMutableArray *imageDatas;
@property (strong, nonatomic) KKCarouselView *carouselView;//轮播图

@end

@implementation KKBeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Bee首页样式";
    self.datas = [[NSMutableArray alloc] init];
    self.imageDatas = [[NSMutableArray alloc] init];
    [self setupSubvuews];
    [self updateDatas];
}
- (void)setupSubvuews{
    //
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //
    self.tableView.backgroundColor = KKColor_FFFFFF;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.mj_header = [KKRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(whenHeaderAciton:)];
    //
    CGFloat top = AdaptedWidth(200.f);
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, -top);
    //
    self.carouselView = [[KKCarouselView alloc] initWithDelegate:self];
    [self.carouselView.collectionView registerNib:[UINib nibWithNibName:@"KKCarouselViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"KKCarouselViewCollectionViewCell"];
    [self.tableView addSubview:self.carouselView];
}
//下拉刷新
- (void)whenHeaderAciton:(id) sender{
    [self.tableView.mj_header endRefreshing];
}
- (void)updateDatas{
    [self.datas removeAllObjects];
    [self.imageDatas removeAllObjects];
    //图片相关
    NSArray *items2 = @[@"http://d.ifengimg.com/w448_h248_q100/e0.ifengimg.com/10/2019/0403/B64DB51EAECED52BEED1D2E707EFFF5C0CB1C858_size96_w899_h505.jpeg",@"http://d.ifengimg.com/w448_h248_q100/e0.ifengimg.com/04/2019/0403/B6BC5672DF2E36CBA371640273EB9D366F17950F_size109_w1078_h718.jpeg",@"http://d.ifengimg.com/w448_h248_q100/p2.ifengimg.com/2019_14/F298E9962F5E7B988E61ADB37FCABF007ADCF13F_w723_h362.jpg",@"http://d.ifengimg.com/w448_h248_q100/e0.ifengimg.com/06/2019/0403/D3B5B1447A5A1F0B4705F59874CDF859714CF0C6_size623_w3000_h2000.jpeg",@"http://d.ifengimg.com/w448_h248_q100/p1.ifengimg.com/2019_14/46912C918543EA819F79156587E317B74C802242_w750_h376.png",];
    for (NSString *item in items2) {
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:nil value:item];
        [self.imageDatas addObject:element];
    }
    [self.carouselView reloadData];
    //列表相关
    NSArray *items = [UIFont familyNames];
    for (NSString *value in items) {
        KKLabelModel *model = [[KKLabelModel alloc] initWithTitle:value value:@""];
        [self.datas addObject:model];
    }
    [self.tableView reloadData];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
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
    return AdaptedWidth(45.f);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        [self mainQueueTableView:tableView didSelectRowAtIndexPath:indexPath];
    });
}
- (void)mainQueueTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat top = AdaptedWidth(200.f);
    CGPoint contentOffset = scrollView.contentOffset;
    contentOffset.y += (top + SafeAreaTopHeight);
    if (contentOffset.y > 0) {
        //上滑
        CGRect bounds = self.view.bounds;
        CGRect f1 = bounds;
        f1.origin.y = - top;
        f1.size.height = top;
        self.carouselView.frame = f1;
    }else{
        //下滑
        CGRect bounds = self.view.bounds;
        CGRect f1 = bounds;
        f1.origin.y = - top + contentOffset.y;
        f1.size.height = top;
        self.carouselView.frame = f1;
    }
}
#pragma mark - KKCarouselViewDelegate
- (UICollectionViewCell *)kkCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.imageDatas[indexPath.row];
    KKCarouselViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKCarouselViewCollectionViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"indexPath.row=%ld",(long)indexPath.row];
    [cell.imageView kk_setImageWithUrl:cellModel.value placeholderImage:kPlaceholder2r1];
    return cell;
}
- (NSInteger)kkCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageDatas.count;
}
- (CGSize)kkCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize cellSize = collectionView.bounds.size;
    return cellSize;
}
@end
