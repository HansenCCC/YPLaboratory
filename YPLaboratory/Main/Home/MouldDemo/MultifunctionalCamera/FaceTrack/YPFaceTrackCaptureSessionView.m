//
//  YPFaceTrackCaptureSessionView.m
//  YPLaboratory
//
//  Created by Hansen on 2023/7/22.
//

#import "YPFaceTrackCaptureSessionView.h"

@interface YPFaceTrackCaptureSessionView () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureMetadataOutput *metadataOutput;

@end

@implementation YPFaceTrackCaptureSessionView

- (instancetype)init {
    if ([super init]) {
#if TARGET_IPHONE_SIMULATOR

#else
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.devicePosition = AVCaptureDevicePositionFront;
            [self.metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            [self.metadataOutput setMetadataObjectTypes:@[
                AVMetadataObjectTypeFace
            ]];
        }
#endif
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {

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

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    for (UIView *view in self.subviews) {
        if (view.tag == 1000) {
            [view removeFromSuperview];
        }
    }
    
    for (AVMetadataFaceObject *faceObject in metadataObjects) {
        if ([faceObject isKindOfClass:[AVMetadataFaceObject class]]) {
            AVMetadataFaceObject *transformFaceObject = (AVMetadataFaceObject *)[self.previewLayer transformedMetadataObjectForMetadataObject:faceObject];
            UIView *faceView = [[UIView alloc] init];
            faceView.tag = 1000;
            faceView.frame = transformFaceObject.bounds;
            faceView.layer.borderWidth = 1.5f;
            faceView.layer.borderColor = [UIColor yellowColor].CGColor;
            [self addSubview:faceView];
        }
    }
}

@end
