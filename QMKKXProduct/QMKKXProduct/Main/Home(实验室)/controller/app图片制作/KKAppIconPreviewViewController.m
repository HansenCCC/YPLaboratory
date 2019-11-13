//
//  KKAppIconPreviewViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/13.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKAppIconPreviewViewController.h"
#import "KKAppIcon.h"
#import "KKAppIconTableViewCell.h"
#import "KKAppIconLabelModel.h"

@interface KKAppIconPreviewViewController ()
@property (strong, nonatomic) NSArray <KKAppIcon *>*appIcons;
@property (strong, nonatomic) NSMutableArray <KKAppIconLabelModel *> *datas;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKAppIconPreviewViewController
- (id)initWithIconImage:(UIImage *)iconImage{
    if(self = [self init]){
        self.iconImage = iconImage;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"制作App图标";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)__onSaveButtonDidTap:(id)sender{
    NSString *dirPath = [self.iconPath stringByDeletingLastPathComponent];
    for (KKAppIcon *appIcon in self.appIcons) {
        [appIcon saveToDir:dirPath];
    }
    [KKAppIcon saveContentJsonToDir:dirPath];
}
- (void)setupSubviews{
    [self.tableView registerNib:[UINib nibWithNibName:@"KKAppIconTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKAppIconTableViewCell"];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(__onSaveButtonDidTap:)];
    self.navigationItem.rightBarButtonItem = saveItem;
}
- (void)reloadDatas{
    //比较消耗内存，建议异步处理
    [self showLoading];
    dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.appIcons = [KKAppIcon appIconListWithOriginImage:self.iconImage];
        [self.datas removeAllObjects];
        //code
        for (KKAppIcon *appIcon in self.appIcons) {
            KKAppIconLabelModel *element = [[KKAppIconLabelModel alloc] initWithTitle:appIcon.name value:nil];
            element.placeholder = appIcon.name;
            element.filePath = appIcon.name;
            element.iconImage = appIcon.scaledImage;
            [self.datas addObject:element];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self hideLoading];
        });
    });
}
#pragma mark - lazy load
- (NSMutableArray<KKAppIconLabelModel *> *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datas[indexPath.row];
    KKAppIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKAppIconTableViewCell"];
    cell.cellModel = cellModel;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKAppIconLabelModel *cellModel = self.datas[indexPath.row];
    UIImage *image = cellModel.iconImage;
    CGFloat height = MAX(AdaptedWidth(44.f), image.size.height);
    return MIN(height, AdaptedWidth(200.f));
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中状态
    
}
@end
