//
//  YPCameraCaptureSessionView.m
//  YPLaboratory
//
//  Created by Hansen on 2023/7/28.
//

#import "YPCameraCaptureSessionView.h"

@interface YPCameraCaptureSessionView () <AVCapturePhotoCaptureDelegate>

@property (nonatomic, strong) AVCapturePhotoOutput *photoOutput;

@end

@implementation YPCameraCaptureSessionView

- (instancetype)init {
    if ([super init]) {
#if TARGET_IPHONE_SIMULATOR

#else
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettings];
            [self.photoOutput capturePhotoWithSettings:settings delegate:self];
        }
#endif
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (AVCaptureOutput *)output {
    return self.photoOutput;
}

- (AVCapturePhotoOutput *)photoOutput {
    if (!_photoOutput) {
        _photoOutput = [[AVCapturePhotoOutput alloc] init];
    }
    return _photoOutput;
}

#pragma mark - AVCapturePhotoCaptureDelegate

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(NSError *)error {
    NSLog(@"%@",error);
}

@end
