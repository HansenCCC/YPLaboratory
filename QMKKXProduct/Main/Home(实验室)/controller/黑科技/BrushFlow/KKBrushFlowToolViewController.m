//
//  KKBrushFlowToolViewController.m
//  QMKKXProduct
//
//  Created by shinemo on 2021/9/10.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKBrushFlowToolViewController.h"
#import "KKBrushFlowToolCollectionViewCell.h"

@interface KKBrushFlowToolViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign) NSInteger requestCount;

@end

@implementation KKBrushFlowToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
    self.requestCount = 0;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
}

- (void)backItemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.whenRequestComplete) {
        self.whenRequestComplete(self.requestCount);
    }
}

#pragma mark - getters
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[KKBrushFlowToolCollectionViewCell class] forCellWithReuseIdentifier:@"KKBrushFlowToolCollectionViewCell"];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 5.f;
        _flowLayout.minimumInteritemSpacing = 5.f;
        _flowLayout.itemSize = CGSizeMake(70.f, 70.f);
    }
    return _flowLayout;
}
 
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KKBrushFlowToolCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKBrushFlowToolCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:rand()%255/255.f green:rand()%255/255.f blue:rand()%255/255.f alpha:1];
    [cell.webView loadRequest:[NSURLRequest requestWithURL:self.urlString.toURL]];
    //
    WeakSelf
    cell.whenCompleteBlock = ^(BOOL success) {
        weakSelf.requestCount ++;
        NSLog(@"%ld",(long)weakSelf.requestCount);
        if (weakSelf.requestCount >= 50){
            [weakSelf backItemClick];
        }
    };
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
}

@end
