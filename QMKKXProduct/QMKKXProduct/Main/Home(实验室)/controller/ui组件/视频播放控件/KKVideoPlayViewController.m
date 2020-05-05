//
//  KKVideoPlayViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 1/17/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKVideoPlayViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"
#import "KKAVPlayerViewController.h"

@interface KKVideoPlayViewController ()
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKVideoPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"iOS播放视频";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    [self.tableView registerClass:[KKAdaptiveTableViewCell class] forCellReuseIdentifier:@"KKAdaptiveTableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    //构造cell
    NSArray *items = @[@"AVPlayer\n\n优点:接近底层，自定义U更加灵活。\n缺点:不自带控制U，使用繁琐。\n使用:继承于NSOject,无法单独显示播放的视频，需要借助AVPlayerL ayer,添加图层到需要显示展示的图层上才能显示视频。",@"AVPlayerVlewController\n\n优点:自带播放控制UI，使用方便。\n缺点:不能自定义UI。\n使用：1.继承于UIViewController,作为视图控制器弹出播放界面，也可以添加View的方式播放。2.需要设置成员变量AVPlayer,来创建AVPlayerViewController。3.iOS9.0之后，弃用旧播放器，建议使用。",@"MPMoviePlayerController\n\n优点:自带播放控制的U(进度条，暂停播放等)。\n缺点:使用繁琐，需要将视频视图添加到其他视图上。\n使用:1.需要导入MediaPlayer Framework。2.继承于NSObject而非视图控制器，不能直接push弹出。3.内部包含一个展示视频内容的View,只有将其添加到其他控制器的View上才可以显示视频。4.播放器的播放状态是以通知的方式告知外界的。",@"MPMoviePlayerViewController\n\n优点:1.自带播放控制U，使用方便\n缺点:1.不能自定义UI。2.只能全屏播放视频。\n使用:1.需要导入MediaPlayer.Framework。2.继承于UIViewCotoller,可以push弹出。"];
    for (NSString *item in items) {
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:item value:nil];
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
    KKAdaptiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKAdaptiveTableViewCell"];
    cell.contentLabel.text = cellModel.title;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datas[indexPath.row];
    NSString *value = cellModel.title;
    KKAdaptiveTableViewCell *cell = [KKAdaptiveTableViewCell sharedInstance];
    cell.bounds = [UIScreen mainScreen].bounds;
    cell.contentLabel.text = value;
    CGSize size = [cell sizeThatFits:CGSizeMake(cell.bounds.size.width, 0)];
    CGFloat height = size.height;
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        [self mainQueueTableView:tableView didSelectRowAtIndexPath:indexPath];
    });
}
- (void)mainQueueTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    KKAVPlayerViewController *vc = [[KKAVPlayerViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - aciton
@end
