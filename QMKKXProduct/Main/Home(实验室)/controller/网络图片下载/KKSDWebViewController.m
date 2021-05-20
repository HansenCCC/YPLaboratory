//
//  KKSDWebViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/13.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKSDWebViewController.h"
#import "KKFileViewController.h"

@interface KKSDWebViewController ()
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *imagePath;//测试地址

@end

@implementation KKSDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"网络图片下载";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKButtonTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKButtonTableViewCell"];
}
- (void)reloadDatas{
    //to do
    NSArray *items = @[@"原生网络下载图片(不缓存)",
                       @"原生网络下载图片(缓存)",
                       @"原生缓存文件夹",
                       @"清空原生缓存",
                       @"SDWebImage下载图片(不缓存)",
                       @"SDWebImage下载图片(缓存)",
                       @"SDWebImage缓存文件夹",
                       @"清空SDWebImage缓存",
                       ];
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
    if([cellModel.title isEqualToString:@"清空原生缓存"]||[cellModel.title isEqualToString:@"清空SDWebImage缓存"]){
        KKButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKButtonTableViewCell"];
        cell.cellModel = cellModel;
        return cell;
    }else{
        KKLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKLabelTableViewCell"];
        cell.cellModel = cellModel;
        return cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
    WeakSelf
    KKLabelModel *cellModel = self.datas[indexPath.row];
    NSString *imagePath = self.imagePath;
    if([cellModel.title isEqualToString:@"原生网络下载图片(不缓存)"]){
        [self showLoading];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageDate = [NSData dataWithContentsOfURL:imagePath.toURL];
            UIImage *image = [UIImage imageWithData:imageDate];
            NSLog(@"%@",image);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf hideLoading];
            });
        });
    }else if([cellModel.title isEqualToString:@"原生网络下载图片(缓存)"]){
        [self showLoading];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSData *imageDate = [NSData dataWithContentsOfURL:imagePath.toURL];
            UIImage *image = [UIImage imageWithData:imageDate];
            NSLog(@"%@",image);
            NSString *fileName = [imagePath stringByReplacingOccurrencesOfString:@"/" withString:@""];
            //本地沙盒目录
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"qmkkxImages"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf hideLoading];
                //判断文件是否存在，不存直接创建
                BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:nil];
                if(!isDirExist){
                    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
                }
                NSString *filePath = [path stringByAppendingPathComponent:fileName];
                //将取得的图片写入本地的沙盒中
                BOOL success = [imageDate writeToFile:filePath  atomically:YES];
                if (success){
                    [weakSelf showSuccessWithMsg:@"本地图片缓存成功！"];
                }else{
                    [weakSelf showError:@"本地图片缓存失败！"];
                }
            });
        });
    }else if([cellModel.title isEqualToString:@"SDWebImage下载图片(不缓存)"]){
        MBProgressHUD *hud = (MBProgressHUD *)[self showCustomIcon:nil message:cellModel.title isWindow:NO timer:60];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        //剖析sdweb，SDWebImageDownloaderHighPriority优先下载，不缓存
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:imagePath.toURL options:SDWebImageDownloaderHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            CGFloat expectedSizeCopy = expectedSize;
            CGFloat receivedSizeCopy = receivedSize;
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.progress = receivedSizeCopy/expectedSizeCopy;
            });
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            [MBProgressHUD hideHUD];
            if(finished){
                [weakSelf showSuccessWithMsg:@"图片请求成功！"];
            }else{
                [weakSelf showError:error.domain];
            }
        }];
    }else if([cellModel.title isEqualToString:@"SDWebImage下载图片(缓存)"]){
        MBProgressHUD *hud = (MBProgressHUD *)[self showCustomIcon:nil message:cellModel.title isWindow:NO timer:60];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        //剖析sdweb，SDWebImageRetryFailed优先下载，不缓存
        [[SDWebImageManager sharedManager] loadImageWithURL:imagePath.toURL options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            CGFloat expectedSizeCopy = expectedSize;
            CGFloat receivedSizeCopy = receivedSize;
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.progress = receivedSizeCopy/expectedSizeCopy;
            });
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            [MBProgressHUD hideHUD];
            if(finished){
                [weakSelf showSuccessWithMsg:@"图片请求成功！"];
            }else{
                [weakSelf showError:error.domain];
            }
        }];
    }else if([cellModel.title isEqualToString:@"原生缓存文件夹"]){
        KKFileViewController *vc = [[KKFileViewController alloc] init];
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] ;
        vc.filePath = path;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([cellModel.title isEqualToString:@"清空原生缓存"]){
        [KKAlertViewController showAlertDeleteImagesWithComplete:^(KKAlertViewController *controler, NSInteger index) {
            if (index == 1) {
                //to do
                [weakSelf showSuccessWithMsg:@"操作执行完成！"];
            }
            [controler dismissViewControllerCompletion:nil];
        }];
    }else if([cellModel.title isEqualToString:@"SDWebImage缓存文件夹"]){
        //生成磁盘缓存路径
        //default为sdwebview默认储存地址
        NSString *filePath = [[SDImageCache sharedImageCache] makeDiskCachePath:@"default"];
        KKFileViewController *vc = [[KKFileViewController alloc] init];
        vc.filePath = filePath;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([cellModel.title isEqualToString:@"清空SDWebImage缓存"]){
        [KKAlertViewController showAlertDeleteSDWebImagesWithComplete:^(KKAlertViewController *controler, NSInteger index) {
            if (index == 1) {
                //清空磁盘
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                    //to do
                    [weakSelf showSuccessWithMsg:@"操作执行完成！"];
                }];
                //清空内存
                [[SDImageCache sharedImageCache] clearMemory];
            }
            [controler dismissViewControllerCompletion:nil];
        }];
    }
}
- (NSString *)imagePath{
    return @"https://raw.githubusercontent.com/HansenCCC/QMKKXProduct/master/%E9%A2%84%E8%A7%88%E5%9B%BE1.png";
}
@end
