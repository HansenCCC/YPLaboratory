//
//  YPQRCodeScanCaptureSessionView.m
//  YPLaboratory
//
//  Created by Hansen on 2023/7/1.
//

#import "YPQRCodeScanCaptureSessionView.h"

@interface YPQRCodeScanCaptureSessionView () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureMetadataOutput *metadataOutput;
@property (nonatomic, strong) UIImageView *scanView;
@property (nonatomic, strong) NSMutableArray *metadataObjects;

@end

@implementation YPQRCodeScanCaptureSessionView

- (instancetype)init {
    if ([super init]) {
#if TARGET_IPHONE_SIMULATOR

#else
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self.metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            [self.metadataOutput setMetadataObjectTypes:@[
                AVMetadataObjectTypeQRCode,
                AVMetadataObjectTypeEAN13Code,
                AVMetadataObjectTypeEAN8Code,
                AVMetadataObjectTypeCode128Code
            ]];
        }
#endif
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self addSubview:self.scanView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startMovingAnimation];
    });
}

- (void)startMovingAnimation {
    self.scanView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.5
                          delay:0
                        options:UIViewAnimationOptionRepeat
                     animations:^{
        self.scanView.transform = CGAffineTransformMakeTranslation(0, self.bounds.size.height - self.scanView.bounds.size.height);
    } completion:nil];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    f1.size = [self.scanView.image yp_sizeWithMaxRelativeSize:CGSizeMake(bounds.size.width - 60.f, 0)];
    f1.origin.x = (bounds.size.width - f1.size.width) / 2.f;
    self.scanView.frame = f1;
}

- (AVCaptureOutput *)output {
    return self.metadataOutput;
}

- (AVCaptureMetadataOutput *)metadataOutput {
    if (!_metadataOutput) {
        _metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    }
    return _metadataOutput;
}

- (UIImageView *)scanView {
    if (!_scanView) {
        _scanView = [[UIImageView alloc] init];
        _scanView.contentMode = UIViewContentModeScaleAspectFit;
        _scanView.image = [[UIImage imageNamed:@"yp_icon_scanline"] yp_imageWithTintColor:[UIColor yp_blueColor]];
    }
    return _scanView;
}

- (NSMutableArray *)metadataObjects {
    if (!_metadataObjects) {
        _metadataObjects = [[NSMutableArray alloc] init];
    }
    return _metadataObjects;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if ([metadataObjects count] > 0) {
        if (self.metadataObjects.count == 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self handleMetadataObjects];
            });
        }
        for (AVMetadataMachineReadableCodeObject *objc in metadataObjects) {
            if ([objc isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
                AVMetadataMachineReadableCodeObject *string = objc;
                if (![self.metadataObjects containsObject:string.stringValue]) {
                    [self.metadataObjects addObject:string.stringValue];
                }
            }
        }
    }
}

- (void)handleMetadataObjects {
    [[YPShakeManager shareInstance] tapShake];
    [self stopRunning];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"当前识别二维码有 %lu 个", (unsigned long)self.metadataObjects.count] preferredStyle:UIAlertControllerStyleAlert];
    for (NSString *string in self.metadataObjects) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:string style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = string;
            [YPAlertView alertText:[NSString stringWithFormat:@"'%@' %@",string?:@"",@"文本已复制".yp_localizedString]];
            [[UIViewController yp_topViewController] dismissViewControllerAnimated:YES completion:nil];
            [[YPShakeManager shareInstance] longPressShake];
        }];
        [alert addAction:alertAction];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"重新扫描" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.metadataObjects removeAllObjects];
        [self startRunning];
        [[YPShakeManager shareInstance] tapShake];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[UIViewController yp_topViewController] dismissViewControllerAnimated:YES completion:nil];
        [[YPShakeManager shareInstance] tapShake];
    }]];
    [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
}

@end
