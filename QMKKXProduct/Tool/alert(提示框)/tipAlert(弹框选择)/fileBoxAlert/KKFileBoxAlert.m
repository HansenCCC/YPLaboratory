//
//  KKFileBoxAlert.m
//  QMKKXProduct
//
//  Created by Hansen on 5/26/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKFileBoxAlert.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface KKFileBoxAlert ()
@property (strong, nonatomic) UIImageView *fileImageView;
@property (strong, nonatomic) KKTextView *fileContentView;

@end

@implementation KKFileBoxAlert
- (void)setupSubViews{
    [super setupSubViews];
    //文件查看
    self.fileImageView = [[UIImageView alloc] init];
    self.fileImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.fileImageView.backgroundColor = KKColor_333333;
    [self.contentView addSubview:self.fileImageView];
    //资源查看
    self.fileContentView = [[KKTextView alloc] init];
    self.fileContentView.allowsEditingTextAttributes = NO;
    [self.contentView addSubview:self.fileContentView];
}
- (void)setFilePath:(NSString *)filePath{
    _filePath = filePath;
    NSString *fileName = filePath.lastPathComponent;
    NSString *pathExtension = [fileName pathExtension];
    //获取文件类型
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDictionary *reslut = [manager attributesOfItemAtPath:filePath error:nil];
    //
    BOOL flag = NO;//是否是图片
    if ([[NSString fileZips] containsObject:pathExtension]) {
        //压缩包
    }else if ([[NSString fileVideo] containsObject:pathExtension]) {
        //视频
    }else if ([[NSString fileImages] containsObject:pathExtension]) {
        //图片
        flag = YES;
    }else if ([[NSString fileMusics] containsObject:pathExtension]) {
        //音乐
    }else if ([[NSString fileArchives] containsObject:pathExtension]) {
        //文档
    }else if ([[NSString fileWeb] containsObject:pathExtension]) {
        //文档
    }else {
        //未知类型
    }
    if (flag) {
        //图片
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        self.fileImageView.image = [UIImage imageWithData:data];
        if (self.fileImageView.image.size.width == 0||self.fileImageView.image.size.height == 0) {
            self.fileContentView.text = [NSString stringWithFormat:@"%@",reslut];
        }
    }else{
        self.fileContentView.text = [NSString stringWithFormat:@"%@",reslut];
    }
}
- (void)displayContentWillLayoutSubviews{
    [super displayContentWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    //自动布局
    CGRect f1 = self.contentView.bounds;
    CGRect f2 = bounds;
    f2.origin.y = CGRectGetMaxY(self.titleLabel.frame) + AdaptedWidth(10.f);
    f2.origin.x = AdaptedWidth(10.f);
    f2.size.width = f1.size.width - 2 * f2.origin.x;
    f2.size = [self.fileImageView sizeThatFitsToMaxSize:CGSizeMake(f2.size.width, 0)];
    f2.size.width = f1.size.width - 2 * f2.origin.x;
    f2.origin.x = (f1.size.width - f2.size.width)/2.0;
    self.fileImageView.frame = f2;
    //
    CGRect f3 = bounds;
    f3.origin.y = CGRectGetMaxY(self.titleLabel.frame) + AdaptedWidth(10.f);
    f3.origin.x = AdaptedWidth(10.f);
    f3.size.width = f1.size.width - 2 * f3.origin.x;
    f3.size.height = AdaptedWidth(200.f);
    self.fileContentView.frame = f3;
    if (self.fileImageView.image.size.width == 0||self.fileImageView.image.size.height == 0) {
        self.displayContentView = self.fileContentView;
        self.fileImageView.hidden = YES;
        self.fileContentView.hidden = NO;
    }else{
        self.displayContentView = self.fileImageView;
        self.fileImageView.hidden = NO;
        self.fileContentView.hidden = YES;
    }
}
/**
 显示账号验证输入框
 */
+ (KKFileBoxAlert *)showAlertWithFilePath:(NSString *)filePath complete:(KKAlertViewControllerBlock )whenCompleteBlock{
    NSString *fileName = filePath.lastPathComponent;
    //
    KKFileBoxAlert *alert = [[KKFileBoxAlert alloc] initWithPresentType:KKUIBaseMiddlePresentType];
    alert.filePath = filePath;
    alert.whenCompleteBlock = whenCompleteBlock;
    alert.isOnlyOneButton = YES;
    alert.canTouchBeginMove = YES;
    alert.rightTitle = @"确定";
    alert.headTitle = fileName;
    UIViewController *vc = alert.view.topViewController;
    [vc presentViewController:alert animated:YES completion:nil];
    return alert;
}
@end
