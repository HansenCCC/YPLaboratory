//
//  KKWeChatMomentsViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 1/14/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKWeChatMomentsViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"
#import "KKWeChatMomentsTableViewCell.h"

@interface KKWeChatMomentsViewController ()
@property (strong, nonatomic) NSMutableArray <KKWeChatMomentsModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKWeChatMomentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"模拟微信朋友圈";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    //微信朋友圈cell
    [self.tableView registerClass:[KKWeChatMomentsTableViewCell class] forCellReuseIdentifier:@"KKWeChatMomentsTableViewCell"];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    //构造cell
    NSArray *items = [UIFont familyNames];
    for (NSString *item in items) {
        KKWeChatMomentsModel *element = [[KKWeChatMomentsModel alloc] init];
        element.nickname = item;
        element.contentValue = @"石器盒子上线以来，注册用户3w左右，日活最高达3k人次。从线上用户反馈来说，用户体验极好。自物品交易、金币交易和拍卖功能上线后，收益成果显著。目前Bee的用户较少，但是我一直都在关注Bee的用户体验和上线反馈率，非常期待Bee能够像其他游戏分发平台那样做大做强。石器盒子上线以来，注册用户3w左右，日活最高达3k人次。从线上用户反馈来说，用户体验极好。自物品交易、金币交易和拍卖功能上线后，收益成果显著。目前Bee的用户较少，但是我一直都在关注Bee的用户体验和上线反馈率，非常期待Bee能够像其他游戏分发平台那样做大做强。";
        element.timestampDate = @"两天前";
        element.likes = @[[[KKWeChatMomentsLikeModel alloc] initWithId:@"1" userName:@"张三"],[[KKWeChatMomentsLikeModel alloc] initWithId:@"2" userName:@"李四"],[[KKWeChatMomentsLikeModel alloc] initWithId:@"2" userName:@"李四"],[[KKWeChatMomentsLikeModel alloc] initWithId:@"2" userName:@"李四"],[[KKWeChatMomentsLikeModel alloc] initWithId:@"2" userName:@"李四"],[[KKWeChatMomentsLikeModel alloc] initWithId:@"2" userName:@"李四"],[[KKWeChatMomentsLikeModel alloc] initWithId:@"2" userName:@"李四"],[[KKWeChatMomentsLikeModel alloc] initWithId:@"2" userName:@"李四"],[[KKWeChatMomentsLikeModel alloc] initWithId:@"2" userName:@"李四"],[[KKWeChatMomentsLikeModel alloc] initWithId:@"2" userName:@"李四"],[[KKWeChatMomentsLikeModel alloc] initWithId:@"2" userName:@"李四"],[[KKWeChatMomentsLikeModel alloc] initWithId:@"2" userName:@"李四"],];
        element.comments = @[[[KKWeChatMomentsCommentModel alloc] initWithId:@"1" userName:@"张三" content:@"你发的这个我看过"]];
        element.images = @[@"https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2462146637,4274174245&fm=26&gp=0.jpg",@"https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2348957240,2361878970&fm=26&gp=0.jpg",@"https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1906469856,4113625838&fm=26&gp=0.jpg",];
        [self.datas addObject:element];
    }
    [self.tableView reloadData];
}
#pragma mark - lazy load
- (NSMutableArray<KKWeChatMomentsModel *> *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKWeChatMomentsModel *cellModel = self.datas[indexPath.row];
    KKWeChatMomentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKWeChatMomentsTableViewCell"];
    cell.cellModel = cellModel;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKWeChatMomentsModel *cellModel = self.datas[indexPath.row];
    KKWeChatMomentsTableViewCell *cell = [KKWeChatMomentsTableViewCell sharedInstance];
    cell.bounds = tableView.bounds;
    cell.cellModel = cellModel;
    CGFloat height = CGRectGetMaxY(cell.likesView.frame);
    return height + AdaptedWidth(10.f);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //to do
}
#pragma mark - aciton
@end
