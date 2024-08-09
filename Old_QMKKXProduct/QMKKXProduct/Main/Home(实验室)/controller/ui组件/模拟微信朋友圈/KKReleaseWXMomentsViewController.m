//
//  KKReleaseWXMomentsViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 2/12/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKReleaseWXMomentsViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"
#import "KKWeChatTextViewTableViewCell.h"
#import "KKWeChatImageListTableViewCell.h"
#import "KKWeChatMomentsModel.h"

@interface KKReleaseWXMomentsViewController ()
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKReleaseWXMomentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[KKWeChatTextViewTableViewCell class] forCellReuseIdentifier:@"KKWeChatTextViewTableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[KKWeChatImageListTableViewCell class] forCellReuseIdentifier:@"KKWeChatImageListTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    [self setupNavBackItemConfig];
    //left
    CGFloat backButtonHeight = 40.f;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, backButtonHeight , backButtonHeight)];
    backButton.titleLabel.font = AdaptedFontSize(17.f);
    [backButton setTitleColor:KKColor_000000 forState:UIControlStateNormal];
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    backButton.clipsToBounds = YES;
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backButton addTarget:self action:@selector(whenLeftClickAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    //right
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, backButtonHeight * 2, backButtonHeight)];
    rightButton.titleLabel.font = AdaptedFontSize(17.f);
    [rightButton setTitleColor:KKColor_FFFFFF forState:UIControlStateNormal];
    rightButton.backgroundColor = KKColor_49C469;
    [rightButton setTitle:@"发表" forState:UIControlStateNormal];
    rightButton.layer.cornerRadius = 5.f;
    rightButton.clipsToBounds = YES;
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [rightButton addTarget:self action:@selector(whenRightClickAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    //完全透明
    [self.navigationController.navigationBar setNavigationBarTransparency:YES];
    //不显示条线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
//left
- (void)whenLeftClickAction{
    //to do
    [self dismissViewControllerAnimated:YES completion:nil];
}
//right
- (void)whenRightClickAction{
    //to do
    NSArray *images;
    NSString *content;
    for (KKLabelModel *model in self.datas) {
        if ([model.title isEqualToString:@"想法"]) {
            content = model.value;
            //to do
            NSArray *items = @[
                @"每次我一个人走夜路都好害怕，天这么黑，我这么美，真怕别人看不见啊。",
                @"谁说“念念不忘，必有回响”，喜欢的人从没搭理过我，想一夜暴富，也从没实现过。",
                @"有个员工买了个杯子，上面印着“我要涨工资”，每每开会都要把这几个字冲着老板。终于有一天，老板也买了个杯子，上面写着“滚蛋”！",
                @"每次在街上看见很瘦的人，我都想分些肉给她，因为我有一颗善良的心。",
                @"大家都是：情不知所起，一往而深；唯独我不一样，我是：钱不知所去，一贫如洗。",
                @"逛商场要走时门口保安喊我：“等一下，你衣服鼓鼓囊囊的装了什么？”我愤怒地掀起大衣吼：“是肉，是肉！我自己的。”",
                @"那些过不去的坎，还不都是因为你腿短！",
                @"别人都是笑起来很好看，但是你却不一样，你是看起来很好笑。",
                @"永远不要和父母吵架，因为你吵不赢的时候只有挨骂，当你吵得赢的时候只有挨打。",
                @"有钱有脸叫男神，有钱没脸叫老公，有脸没钱叫蓝颜，至于没钱没脸的，对不起你是个好人……啊，多么痛的领悟！",
                @"长得丑但身材好是一种什么体验？”“背看倾国倾城，正看忧国忧民。",
                @"扪心自问，如果你是别人，你愿意和自己搞对象么？”“想都不敢想，哪有这种福气！",
                @"有些女人穿丝袜，显得身材好。还有一些女人穿丝袜，显得丝袜质量好。",
            ];
            //随机
            long rand = (random() * @([NSDate date].timeIntervalSince1970).intValue)%items.count;
            content = items[rand];
        }else if ([model.title isEqualToString:@"图片"]) {
            NSMutableArray *items = [[NSMutableArray alloc] init];
            for (UIImage *image in model.info) {
                [items addObject:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201303%2F16%2F173710lvx470i4348z6i6z.jpg&refer=http%3A%2F%2Fattach.bbs.miui.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1624172590&t=3ac6e04d3208dfd8f6c7acbee1f52a6a"];
                NSLog(@"#%@",image);
            }
            images = [items copy];
        }
    }
    //获取数据库朋友圈信息
    NSString *tableName = @"kk_wechat_moments";
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"kk_common.db"];
    KKDatabase *database = [KKDatabase databaseWithPath:dbPath];
    //
    KKWeChatMomentsModel *element = [[KKWeChatMomentsModel alloc] init];
    element.iconUrl = @"https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1640434779,3971610929&fm=26&gp=0.jpg";
    element.nickname = @"在当地较为英俊的男子";
    element.contentValue = content;
    element.timestampDate = [NSString stringWithFormat:@"%@",[NSDate date]];
    element.images = images;
    BOOL success = [database insertTableWithTableName:tableName contents:@{@"json":element.mj_JSONString}];
    if (success) {
        [self whenLeftClickAction];
    }else{
        [self showError:[NSString stringWithFormat:@"发布失败\n%@",database.lastErrorMessage]];
    }
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    //构造cell
    {
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:@"想法" value:nil];
        element.placeholder = @"这一刻的想法...";
        [self.datas addObject:element];
    }
    {
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:@"图片" value:nil];
        [self.datas addObject:element];
    }
    [self.tableView reloadData];
}
#pragma mark - lazy load
- (NSMutableArray<KKLabelModel *> *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datas[indexPath.row];
    if (indexPath.row == 0) {
        KKWeChatTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKWeChatTextViewTableViewCell"];
        cell.cellModel = cellModel;
        cell.contentInsets = UIEdgeInsetsMake(AdaptedWidth(44.f), AdaptedWidth(44.f), AdaptedWidth(10.f), AdaptedWidth(44.f));
        return cell;
    }else if (indexPath.row == 1) {
        KKWeChatImageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKWeChatImageListTableViewCell"];
        cell.cellModel = cellModel;
        cell.contentInsets = UIEdgeInsetsMake(AdaptedWidth(44.f), AdaptedWidth(44.f), AdaptedWidth(44.f), AdaptedWidth(44.f));
        //更新高度
        cell.whenNeedUpdateHeight = ^{
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        };
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datas[indexPath.row];
    if (indexPath.row == 0) {
        return AdaptedWidth(144.f);
    }else if (indexPath.row == 1) {
        KKWeChatImageListTableViewCell *cell = [KKWeChatImageListTableViewCell sharedInstance];
        cell.bounds = tableView.bounds;
        cell.cellModel = cellModel;
        cell.contentInsets = UIEdgeInsetsMake(AdaptedWidth(44.f), AdaptedWidth(44.f), AdaptedWidth(44.f), AdaptedWidth(44.f));
        [cell layoutSubviews];
        CGFloat height = CGRectGetMaxY(cell.collectionView.frame);
        return height;
    }
    return AdaptedWidth(44.f);
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
#pragma mark - aciton
@end
