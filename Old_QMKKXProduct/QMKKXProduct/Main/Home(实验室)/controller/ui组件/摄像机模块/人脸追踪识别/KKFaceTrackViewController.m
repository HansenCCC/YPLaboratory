//
//  KKFaceTrackViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 5/6/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKFaceTrackViewController.h"
#import "KKFaceTrackView.h"

@interface KKFaceTrackViewController ()<KKQRCodeSessionViewDelegate>
@property (strong, nonatomic) KKQRCodeSessionView *sessionView;
@property (strong, nonatomic) KKFaceTrackView *faceTrackView;
@property (copy, nonatomic) NSArray <AVMetadataFaceObject *>* faceObjects;//相机会返回人脸位置

@end

@implementation KKFaceTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"人脸追踪识别";
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
    //右边导航刷新按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(whenRightClickAction:)];
    //
    self.view.backgroundColor = [UIColor whiteColor];
    [self.sessionView startRunning];
    self.faceTrackView.previewLayer = self.sessionView.previewLayer;
}
- (void)whenRightClickAction:(id)sender{
    //切换前后摄像头
    if (self.sessionView.devicePosition == AVCaptureDevicePositionBack) {
        //设置为前置摄像头
        self.sessionView.devicePosition = AVCaptureDevicePositionFront;
    }else if(self.sessionView.devicePosition == AVCaptureDevicePositionFront){
        //设置为后置摄像头
        self.sessionView.devicePosition = AVCaptureDevicePositionBack;
    }else if(self.sessionView.devicePosition == AVCaptureDevicePositionUnspecified){
        [self showError:@"不确定当前摄像头朝向"];
    }
    //清空人脸识别框
    self.faceTrackView.faceObjects = @[];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //
    CGRect bounds = self.view.bounds;
    self.sessionView.frame = bounds;
    self.faceTrackView.frame = bounds;
}
#pragma mark - lazy load
-(KKQRCodeSessionView *)sessionView{
    if (!_sessionView) {
        _sessionView = [[KKQRCodeSessionView alloc] init];
        _sessionView.type = KKMetadataObjectTypeFace;
        _sessionView.delegate = self;
        [self.view addSubview:_sessionView];
    }
    return _sessionView;
}
- (KKFaceTrackView *)faceTrackView{
    if (!_faceTrackView) {
        _faceTrackView = [[KKFaceTrackView alloc] init];
        [self.view addSubview:_faceTrackView];
    }
    return _faceTrackView;
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSLog(@"metadataObjects%@",metadataObjects);
    self.faceTrackView.faceObjects = metadataObjects;
}
@end
