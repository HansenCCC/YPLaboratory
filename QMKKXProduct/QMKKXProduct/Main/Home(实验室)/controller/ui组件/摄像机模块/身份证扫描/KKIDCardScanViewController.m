//
//  KKIDCardScanViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/7/1.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKIDCardScanViewController.h"

@interface KKIDCardScanViewController ()
@property(nonatomic, strong) UIButton *takePhotoButton;
@property(nonatomic, strong) KKUIFlowLayoutButton *sureButton;
@property(nonatomic, strong) KKUIFlowLayoutButton *againButton;
@property(nonatomic, strong) UIButton *backButtonCopy;
@property(nonatomic, strong) UIImageView *scanBackGroundImageView;
@property(nonatomic, strong) KKIDCardScanBackgroundView *backgroundView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, assign) BOOL isTakePhoto;
@property(nonatomic, strong) UIImage *selectImage;
@end

@implementation KKIDCardScanViewController
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isTakePhoto = YES;
    [self setupSubview];
    [self updateSubview];
}
- (void)setupSubview{
    //
    self.sessionView.devicePosition = AVCaptureDevicePositionBack;
    self.sessionView.previewLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeRight;//调整设备朝向
    [self.sessionView startRunning];
    [self.view addSubview:self.sessionView];
    //
    self.backgroundView = [[KKIDCardScanBackgroundView alloc] init];
    [self.sessionView addSubview:self.backgroundView];
    
    self.takePhotoButton = [[UIButton alloc] init];
    self.takePhotoButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.takePhotoButton setImage:UIImageWithName(@"kk_icon_takePhoto") forState:UIControlStateNormal];
    [self.takePhotoButton addTarget:self action:@selector(__takePhotoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sessionView addSubview:self.takePhotoButton];
    
    self.sureButton = [[KKUIFlowLayoutButton alloc] init];
    [self.sureButton setTitleColor:KKColor_FFFFFF forState:UIControlStateNormal];
    self.sureButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.sureButton.interitemSpacing = 5;
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    self.sureButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.sureButton.imageSize = CGSizeMake(60.f, 60.f);
    self.sureButton.contentStyle = KKUIFlowLayoutButtonContentStyleVertical;
    [self.sureButton setImage:UIImageWithName(@"iq_icon_captureSure") forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(__sureButtonnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sessionView addSubview:self.sureButton];
    
    self.againButton = [[KKUIFlowLayoutButton alloc] init];
    self.againButton.interitemSpacing = 5;
    [self.againButton setTitleColor:KKColor_FFFFFF forState:UIControlStateNormal];
    self.againButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.againButton setTitle:@"重拍" forState:UIControlStateNormal];
    self.againButton.imageSize = CGSizeMake(60.f, 60.f);
    self.againButton.contentStyle = KKUIFlowLayoutButtonContentStyleVertical;
    self.againButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.againButton setImage:UIImageWithName(@"iq_icon_captureAgain") forState:UIControlStateNormal];
    [self.againButton addTarget:self action:@selector(__againButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sessionView addSubview:self.againButton];
    
    self.backButtonCopy = [[UIButton alloc] init];
    self.backButtonCopy.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.backButtonCopy setImage:UIImageWithName(@"kk_icon_cancelBack") forState:UIControlStateNormal];
    [self.backButtonCopy addTarget:self action:@selector(__backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sessionView addSubview:self.backButtonCopy];
    //
    self.scanBackGroundImageView = [[UIImageView alloc] init];
    [self.scanBackGroundImageView setImage: UIImageWithName(@"kk_icon_frame")];
    [self.sessionView addSubview:self.scanBackGroundImageView];
    //
    self.titleLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:18.f] textColor:KKColor_FFFFFF];
    self.titleLabel.text = @"请将人像面放到框内，并调整好光线";
    [self.sessionView addSubview:self.titleLabel];
}
- (void)__backButtonAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)__takePhotoAction{
    //拍照
    [self.sessionView takePhoto];
}
- (void)__againButtonAction{
    self.isTakePhoto = YES;
    [self updateSubview];
    //再次拍照
    [self.sessionView startRunning];
}
- (void)__sureButtonnAction{
    //确定
    if (self.whenFinsh) {
        self.whenFinsh(self.selectImage);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    //
    CGRect bounds = self.view.bounds;
    self.sessionView.frame = bounds;
    //
    CGRect f1 = bounds;
    f1.size = CGSizeMake(60, 60);
    f1.origin.y = (bounds.size.height - f1.size.height)/2;
    f1.origin.x = bounds.size.width - f1.size.width - 30;
    self.takePhotoButton.frame = f1;
    //
    CGRect f5 = f1;
    f5.size = CGSizeMake(60, 85);
    f5.origin.y = (bounds.size.height - f1.size.height)/2 - f1.size.height;
    self.sureButton.frame = f5;
    //
    CGRect f6 = f5;
    f6.origin.y = (bounds.size.height - f1.size.height)/2;
    f6.origin.y = (bounds.size.height - f1.size.height)/2 + f1.size.height;
    self.againButton.frame = f6;
    //
    CGRect f2 = bounds;
    f2.size = CGSizeMake(44, 44);
    f2.origin = CGPointMake(24, 24);
    self.backButtonCopy.frame = f2;
    //
    CGRect f3 = bounds;
    f3.size.height = bounds.size.height - 54 * 2;
    CGSize f3_size = self.scanBackGroundImageView.image.size;
    f3.size.width = f3.size.height/f3_size.height * f3_size.width;
    f3.size = CGSizeMake(430, 268);
    f3.origin.x = (bounds.size.width - f3.size.width)/2;
    f3.origin.y = (bounds.size.height - f3.size.height)/2;
    self.scanBackGroundImageView.frame= f3;
    //
    self.backgroundView.frame = bounds;
    self.backgroundView.transparentFrame = f3;
    //
    CGRect f4 = bounds;
    f4.size = [self.titleLabel sizeThatFits:CGSizeZero];
    f4.origin.y = bounds.size.height - f4.size.height - 20.f;
    f4.origin.x = (bounds.size.width - f4.size.width)/2;
    self.titleLabel.frame = f4;
}
-(CGRect)effectiveRect{
    return  self.scanBackGroundImageView.frame;
}

#pragma mark - lazy load
-(KKPhotoSessionView *)sessionView{
    if (!_sessionView) {
        _sessionView = [[KKPhotoSessionView alloc] init];
        self.view.transform = CGAffineTransformRotate(self.view.transform, M_PI/2.0);
        WeakSelf
        _sessionView.whenTakePhoto = ^(UIImage *photo){
            [weakSelf.sessionView stopRunning];
            UIImage *image = photo;
            image = [UIImage fixOrientation:image];
            //
            CGRect bounds = weakSelf.sessionView.bounds;
            CGSize scaledSize = bounds.size;
            CGSize imageSize = image.size;
            if(bounds.size.width>bounds.size.height != imageSize.width>imageSize.height){
                scaledSize.width = bounds.size.height;
                scaledSize.height = bounds.size.width;
            }
            image = [image cropImageToFitAspectRatioSize:scaledSize];
            CGFloat scale  = image.size.width/bounds.size.height;
            CGRect effectiveRect = CGRectMake(weakSelf.effectiveRect.origin.y * scale, weakSelf.effectiveRect.origin.x * scale, weakSelf.effectiveRect.size.height * scale, weakSelf.effectiveRect.size.width * scale);
            image = [image cropImageWithRect:effectiveRect];
            // 写入相册
            if (weakSelf.shouldWriteToSavedPhotos) {
                UIImageWriteToSavedPhotosAlbum(image, weakSelf, nil, NULL);
            }
            //
            weakSelf.isTakePhoto = NO;
            [weakSelf updateSubview];
            weakSelf.selectImage = image;
        };
    }
    return _sessionView;
}
- (void)updateSubview{
    self.sureButton.hidden = self.isTakePhoto;
    self.againButton.hidden = self.isTakePhoto;
    self.takePhotoButton.hidden = !self.isTakePhoto;
}
@end
