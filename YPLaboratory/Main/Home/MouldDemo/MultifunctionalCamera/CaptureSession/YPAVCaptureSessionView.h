//
//  YPAVCaptureSessionView.h
//  YPUIKit-ObjC
//
//  Created by Hansen on 2023/6/30.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPAVCaptureSessionView : UIView <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, readonly) AVCaptureSession *session;
@property (nonatomic, readonly) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, readonly) AVCaptureDevice *device;
@property (nonatomic, readonly) AVCaptureDeviceInput *input;
@property (nonatomic, readonly) AVCaptureOutput *output;

@property (nonatomic, assign) AVCaptureDevicePosition devicePosition;//前后摄像头 default 后
@property (nonatomic, assign) AVCaptureSessionPreset sessionPreset;//画质
/*AVCaptureSessionPresetLow,AVCaptureSessionPresetHigh,AVCaptureSessionPresetPhoto,AVCaptureSessionPresetMedium,AVCaptureSessionPreset352x288,AVCaptureSessionPreset640x480,AVCaptureSessionPreset1280x720,AVCaptureSessionPreset1920x1080,AVCaptureSessionPreset3840x2160,AVCaptureSessionPresetiFrame960x540,AVCaptureSessionPresetInputPriority,AVCaptureSessionPresetiFrame1280x720*/
@property (nonatomic, assign) AVCaptureFlashMode flashMode;//闪光模式
@property (nonatomic, assign) BOOL showFocusView;//对焦功能 default NO

/// 根据前后置位置拿到相应的摄像头设备
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position;

/// 开始取景
-(void)startRunning;

/// 结束取景
- (void)stopRunning;

@end

NS_ASSUME_NONNULL_END

