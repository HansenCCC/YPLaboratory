//
//  YPIconBuildManager.m
//  YPLaboratory
//
//  Created by Hansen on 2023/6/15.
//

#import "YPIconBuildManager.h"
#import <Photos/Photos.h>

@implementation YPIconBuildManager

+ (instancetype)shareInstance {
    static YPIconBuildManager *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[YPIconBuildManager alloc] init];
        [m resetIconBuild];
    });
    return m;
}

- (void)resetIconBuild {
    self.iconPath = @"请选择图标文件：最佳1024 * 1024像素".yp_localizedString;
    self.betaString = @"BETA";
    self.betaColor = [UIColor whiteColor];
    self.betaBackgroundColor = [UIColor redColor];
    self.isAddBeta = NO;
}

- (void)iconBuild {
    if (TARGET_OS_SIMULATOR) {
        if(![[NSFileManager defaultManager] fileExistsAtPath:self.iconPath]){
            // 文件不存在不执行
            return;
        }
        
        NSString *dirPath = [self.iconPath stringByDeletingLastPathComponent];
        if(![[NSFileManager defaultManager] fileExistsAtPath:dirPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:NULL];
        }
        // 生成图片
        for (NSDictionary *iconInfo in [YPIconBuildManager shareInstance].icons) {
            NSString *name = iconInfo[@"name"];
            NSString *scale = iconInfo[@"scale"];
            NSValue *sizeValue = iconInfo[@"size"];
            CGSize size = CGSizeZero;
            if (sizeValue != nil) {
                size = [sizeValue CGSizeValue];
            }
            UIImage *scaledImage = [self.iconImage yp_imageWithCanvasSize:size scale:scale.integerValue];
            NSData *data = UIImagePNGRepresentation(scaledImage);
            NSString *filePath = [dirPath stringByAppendingPathComponent:name];
            [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
        }
        
        // 生成 JSON 文件
        NSString *fileName = @"Contents.json";
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
        NSData *data = [NSData dataWithContentsOfFile:path];
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
    } else {
        // 将UIImage保存到本地相册
        UIImage *image = self.iconImage;
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            // 可以根据需要设置保存的图片属性，例如调整图片大小、添加元数据等
        } completionHandler:^(BOOL success, NSError *error) {
            if (success) {
                NSLog(@"Image saved to photo library successfully.");
            } else {
                NSLog(@"Error saving image to photo library: %@", error);
            }
        }];
    }
}

- (UIImage *)iconImage {
    UIImage *image = nil;
    
    if (TARGET_OS_SIMULATOR) {
        if([[NSFileManager defaultManager] fileExistsAtPath:self.iconPath]){
            image = [[UIImage alloc] initWithContentsOfFile:self.iconPath];
        }
    } else {
        image = [UIImage yp_getDocumentImageWithImageName:self.iconPath];
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 1024.f, 1024.f);
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = image;
    
    UIView *baseView = [[UIView alloc] init];
    baseView.backgroundColor = self.betaBackgroundColor;
    CGRect f1 = CGRectMake(0, 0, 1024, 1024.f / 5.f);
    f1.origin.y = f1.size.width - f1.size.height;
    baseView.frame = f1;
    [imageView addSubview:baseView];
    
    UILabel *baseLabel = [[UILabel alloc] init];
    baseLabel.text = self.betaString;
    baseLabel.textColor = self.betaColor;
    baseLabel.font = [UIFont systemFontOfSize:160.f];
    baseLabel.textAlignment = NSTextAlignmentCenter;
    baseLabel.frame = baseView.bounds;
    [baseView addSubview:baseLabel];
    
    if (!self.isAddBeta) {
        baseView.hidden = YES;
        baseLabel.hidden = YES;
    }
    
    UIImage *iconImage = [imageView yp_screenshotsImage];
    return iconImage;
}

- (NSArray<NSDictionary *> *)icons {
    NSMutableArray *icons = [[NSMutableArray alloc] init];
    if (TARGET_OS_SIMULATOR) {
        // 模拟器
        [icons addObjectsFromArray:@[
            @{@"name":@"IconiPhone-20@2x.png",@"scale":@"2",@"size":[NSValue valueWithCGSize:CGSizeMake(20.f, 20.f)]},
            @{@"name":@"IconiPhone-20@3x.png",@"scale":@"3",@"size":[NSValue valueWithCGSize:CGSizeMake(20.f, 20.f)]},
            @{@"name":@"IconiPhone-29@2x.png",@"scale":@"2",@"size":[NSValue valueWithCGSize:CGSizeMake(29.f, 29.f)]},
            @{@"name":@"IconiPhone-29@3x.png",@"scale":@"3",@"size":[NSValue valueWithCGSize:CGSizeMake(29.f, 29.f)]},
            @{@"name":@"IconiPhone-40@2x.png",@"scale":@"2",@"size":[NSValue valueWithCGSize:CGSizeMake(40.f, 40.f)]},
            @{@"name":@"IconiPhone-40@3x.png",@"scale":@"3",@"size":[NSValue valueWithCGSize:CGSizeMake(40.f, 40.f)]},
            @{@"name":@"IconiPhone-60@2x.png",@"scale":@"2",@"size":[NSValue valueWithCGSize:CGSizeMake(60.f, 60.f)]},
            @{@"name":@"IconiPhone-60@3x.png",@"scale":@"3",@"size":[NSValue valueWithCGSize:CGSizeMake(60.f, 60.f)]},
            @{@"name":@"IconiPad-20.png",@"scale":@"1",@"size":[NSValue valueWithCGSize:CGSizeMake(20.f, 20.f)]},
            @{@"name":@"IconiPad-20@2x.png",@"scale":@"2",@"size":[NSValue valueWithCGSize:CGSizeMake(20.f, 20.f)]},
            @{@"name":@"IconiPad-29.png",@"scale":@"1",@"size":[NSValue valueWithCGSize:CGSizeMake(29.f, 29.f)]},
            @{@"name":@"IconiPad-29@2x.png",@"scale":@"2",@"size":[NSValue valueWithCGSize:CGSizeMake(29.f, 29.f)]},
            @{@"name":@"IconiPad-40.png",@"scale":@"1",@"size":[NSValue valueWithCGSize:CGSizeMake(40.f, 40.f)]},
            @{@"name":@"IconiPad-40@2x.png",@"scale":@"2",@"size":[NSValue valueWithCGSize:CGSizeMake(40.f, 40.f)]},
            @{@"name":@"IconiPad-76.png",@"scale":@"1",@"size":[NSValue valueWithCGSize:CGSizeMake(76.f, 76.f)]},
            @{@"name":@"IconiPad-76@2x.png",@"scale":@"2",@"size":[NSValue valueWithCGSize:CGSizeMake(76.f, 76.f)]},
            @{@"name":@"IconiPad-167.png",@"scale":@"1",@"size":[NSValue valueWithCGSize:CGSizeMake(167.f, 167.f)]},
            @{@"name":@"IconAppStore-1024.png",@"scale":@"1",@"size":[NSValue valueWithCGSize:CGSizeMake(1024.f, 1024.f)]},
        ]];
    } else {
        // 真机
        [icons addObjectsFromArray:@[
            @{@"name":@"IconAppStore-1024.png",@"scale":@"1",@"size":[NSValue valueWithCGSize:CGSizeMake(1024.f, 1024.f)]},
        ]];
    }
    return icons;
}

@end

