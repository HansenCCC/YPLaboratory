//
//  YPPageRouterModule+Idea.m
//  YPLaboratory
//
//  Created by Hansen on 2023/6/6.
//

#import "YPPageRouterModule+Idea.h"
#import "YPIconBuildManager.h"
#import "YPModuleImageCell.h"
#import "YPPageRouterModule+Update.h"

@implementation YPPageRouterModule (Idea)

+ (NSArray *)IdeaRouters_IconBuild {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = [YPIconBuildManager shareInstance].iconPath?:@"";
        element.type = YPPageRouterTypeTableCell;
        element.cellHeight = 100.f;
        element.cellClass = [YPModuleImageCell class];
        element.extend = [YPIconBuildManager shareInstance].iconImage;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            if (TARGET_OS_SIMULATOR) {
                // 模拟器处理方式
                YPSingleLineInputViewController *vc = [[YPSingleLineInputViewController alloc] init];
                vc.text = router.content;
                vc.title = @"输入 app icon 路径".yp_localizedString;
                vc.placeholder = [YPIconBuildManager shareInstance].iconPath?:@"";
                vc.maxLength = 1000;
                vc.didCompleteCallback = ^(NSString * _Nonnull text) {
                    [YPIconBuildManager shareInstance].iconPath = text;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self yp_reloadCurrentModuleControl];
                    });
                };
                [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
            } else {
                // 真机处理方式
                YPImagePickerController *imagePicker = [[YPImagePickerController alloc] init];
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.didCompleteCallback = ^(NSDictionary<UIImagePickerControllerInfoKey,id> * _Nonnull images) {
                    UIImage *selectedImage = images[UIImagePickerControllerOriginalImage];
                    NSString *fileName = [UIImage yp_saveImageToDocument:selectedImage];
                    [YPIconBuildManager shareInstance].iconPath = fileName;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self yp_reloadCurrentModuleControl];
                    });
                };
                [[UIViewController yp_topViewController] presentViewController:imagePicker animated:YES completion:nil];
            }
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"Beta 文字".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPIconBuildManager shareInstance].betaString?:@"";
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            YPSingleLineInputViewController *vc = [[YPSingleLineInputViewController alloc] init];
            vc.text = router.content;
            vc.title = @"修改 Beta 文字".yp_localizedString;
            vc.placeholder = @"Beta 文字".yp_localizedString;
            vc.maxLength = 10;
            vc.didCompleteCallback = ^(NSString * _Nonnull text) {
                [YPIconBuildManager shareInstance].betaString = text;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self yp_reloadCurrentModuleControl];
                });
            };
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"Beta 文字颜色".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [UIColor yp_hexStringFromColor:[YPIconBuildManager shareInstance].betaColor];
        NSArray *colors = [UIColor yp_allColors];
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSUInteger currentIndex = [colors indexOfObject:router.content];
            YPColorPickerAlert *alert = [YPColorPickerAlert popupWithOptions:colors completeBlock:^(NSInteger index) {
                router.content = colors[index];
                [YPIconBuildManager shareInstance].betaColor = [UIColor yp_colorWithHexString:router.content];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self yp_reloadCurrentModuleControl];
                });
            }];
            alert.currentIndex = currentIndex;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"Beta 背景颜色".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [UIColor yp_hexStringFromColor:[YPIconBuildManager shareInstance].betaBackgroundColor];
        NSArray *colors = [UIColor yp_allColors];
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSUInteger currentIndex = [colors indexOfObject:router.content];
            YPColorPickerAlert *alert = [YPColorPickerAlert popupWithOptions:colors completeBlock:^(NSInteger index) {
                router.content = colors[index];
                [YPIconBuildManager shareInstance].betaBackgroundColor = [UIColor yp_colorWithHexString:router.content];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self yp_reloadCurrentModuleControl];
                });
            }];
            alert.currentIndex = currentIndex;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"重置图标制作".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [[YPIconBuildManager shareInstance] resetIconBuild];
            [self yp_reloadCurrentModuleControl];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"添加 BETA".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [YPIconBuildManager shareInstance].isAddBeta = YES;
            [self yp_reloadCurrentModuleControl];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"移除 BETA".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [YPIconBuildManager shareInstance].isAddBeta = NO;
            [self yp_reloadCurrentModuleControl];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"制作 App 图标".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

+ (NSArray *)IdeaRouters_IconBuild_Setup {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    for (NSDictionary *iconInfo in [YPIconBuildManager shareInstance].icons) {
        NSString *name = iconInfo[@"name"];
        NSString *scale = iconInfo[@"scale"];
        NSValue *sizeValue = iconInfo[@"size"];
        CGSize size = CGSizeZero;
        if (sizeValue != nil) {
            size = [sizeValue CGSizeValue];
        }
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = name?:@"";
        element.type = YPPageRouterTypeTableCell;
        CGFloat cellHeight = MAX(44.f, size.height * scale.integerValue);
        cellHeight = MIN(cellHeight, 150.f);
        element.cellHeight = cellHeight;
        element.cellClass = [YPModuleImageCell class];
        element.extend = [[YPIconBuildManager shareInstance].iconImage yp_imageWithCanvasSize:size scale:scale.integerValue];
        [dataList addObject:element];
    }
    if (TARGET_OS_SIMULATOR) {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"生成到当前文件夹".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [[YPIconBuildManager shareInstance] iconBuild];
        };
        [dataList addObject:element];
    } else {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"保存到相册（一张1024）".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [[YPIconBuildManager shareInstance] iconBuild];
        };
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

@end
