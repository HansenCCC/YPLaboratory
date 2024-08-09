//
//  KKAdaptiveImagesViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 9/25/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKAdaptiveImagesViewController.h"
#import "KKAdaptiveImageTableViewCell.h"

@interface KKAdaptiveImagesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <NSString *>*datas;

@end

@implementation KKAdaptiveImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"自适应图片高度";
    self.view.backgroundColor = KKColor_FFFFFF;
    self.datas = [[NSMutableArray alloc] init];
    [self setupSubvuews];
    [self updateDatas];
}
- (void)setupSubvuews{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //
    self.tableView.backgroundColor = KKColor_FFFFFF;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[KKAdaptiveImageTableViewCell class] forCellReuseIdentifier:@"KKAdaptiveImageTableViewCell"];
}
- (void)updateDatas{
    [self.datas removeAllObjects];
    //to do
    NSArray *items = @[@"http://d.ifengimg.com/w448_h248_q100/e0.ifengimg.com/10/2019/0403/B64DB51EAECED52BEED1D2E707EFFF5C0CB1C858_size96_w899_h505.jpeg",@"http://d.ifengimg.com/w448_h248_q100/e0.ifengimg.com/04/2019/0403/B6BC5672DF2E36CBA371640273EB9D366F17950F_size109_w1078_h718.jpeg",@"http://d.ifengimg.com/w448_h248_q100/p2.ifengimg.com/2019_14/F298E9962F5E7B988E61ADB37FCABF007ADCF13F_w723_h362.jpg",@"http://d.ifengimg.com/w448_h248_q100/e0.ifengimg.com/06/2019/0403/D3B5B1447A5A1F0B4705F59874CDF859714CF0C6_size623_w3000_h2000.jpeg",@"http://d.ifengimg.com/w448_h248_q100/p1.ifengimg.com/2019_14/46912C918543EA819F79156587E317B74C802242_w750_h376.png",@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1020705746,2295168391&fm=26&gp=0.jpg",@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3231005548,635944634&fm=26&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2961974070,137066290&fm=26&gp=0.jpg",@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1768092885,618751527&fm=26&gp=0.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3054638224,4132759364&fm=26&gp=0.jpg"
    ];
    for (NSString *value in items) {
        [self.datas addObject:value];
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
    NSString *cellModel = self.datas[indexPath.row];
    KKAdaptiveImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKAdaptiveImageTableViewCell"];
    [cell.contentImageView kk_setImageWithUrl:cellModel placeholderImage:kPlaceholder1r1 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if ((cacheType == SDImageCacheTypeNone||cacheType == SDImageCacheTypeDisk)&&!error) {
            //刚从网络请求下来的资源图片 -> 刷新当前cell
            [cell kk_reloadCurrentTableViewCell];
        }else{
            //存在内存或者本地文件中的资源
        }
    }];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKAdaptiveImageTableViewCell *cell = [KKAdaptiveImageTableViewCell sharedInstance];
    NSString *imagePath = self.datas[indexPath.row];
    cell.contentImageView.image = nil;
    [cell.contentImageView kk_setImageWithUrl:imagePath];
    UIImage *image = cell.contentImageView.image;
    if (image) {
        CGSize imageSize = [image sizeWithMinRelativeSize:CGSizeMake(tableView.bounds.size.width - AdaptedWidth(10.f), 0)];
        return imageSize.height + AdaptedWidth(10.f);
    }
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
#pragma mark - action
@end
