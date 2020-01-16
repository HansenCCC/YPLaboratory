//
//  KKQRCodeScanViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 1/3/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKQRCodeScanViewController.h"
#import "KKQRCodeSessionView.h"
#import "KKQRCodeView.h"

@interface KKQRCodeScanViewController ()
@property (strong, nonatomic) KKQRCodeView *qrCodeView;
@property (strong, nonatomic) KKQRCodeSessionView *sessionView;
@end

@implementation KKQRCodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"二维码扫码";
    [self setupSubview];
    //刷选布局
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self viewDidLayoutSubviews];
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在iPhone的“设置”-“隐私”-“相机”功能中，找到“Bee”打开相机访问权限" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //to do
            }];
            [alert addAction:alertAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    });
}
- (void)setupSubview{
    //
    self.view.backgroundColor = [UIColor whiteColor];
    [self.sessionView startRunning];
    //
    self.qrCodeView = [[KKQRCodeView alloc] init];
    [self.sessionView addSubview:self.qrCodeView];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //
    CGRect bounds = self.view.bounds;
    self.sessionView.frame = bounds;
    self.qrCodeView.frame = bounds;
    //
    CGRect f1 = bounds;
    f1.size = CGSizeMake(bounds.size.width*3/4, bounds.size.width*3/4);
    f1.origin.x = (bounds.size.width - f1.size.width)/2;
    f1.origin.y = (bounds.size.height - f1.size.height)/2;
    self.qrCodeView.maskViewFrame = f1;
    //
    //设置扫描区域
    CGRect f2 = [self.sessionView.previewLayer metadataOutputRectOfInterestForRect:f1];
    ((AVCaptureMetadataOutput *)self.sessionView.output).rectOfInterest = f2;
}
#pragma mark - lazy load
-(KKQRCodeSessionView *)sessionView{
    if (!_sessionView) {
        _sessionView = [[KKQRCodeSessionView alloc] init];
        _sessionView.showFocusView = NO;//取消点击对焦功能
        WeakSelf
        _sessionView.whenFinish = ^(AVMetadataObject *codeObject) {
            AVMetadataMachineReadableCodeObject *string = (AVMetadataMachineReadableCodeObject *)codeObject;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"扫描的内容是：%@",string.stringValue] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //to do
                [weakSelf.sessionView startRunning];
            }];
            [alert addAction:alertAction];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        };
        [self.view addSubview:_sessionView];
    }
    return _sessionView;
}
@end
