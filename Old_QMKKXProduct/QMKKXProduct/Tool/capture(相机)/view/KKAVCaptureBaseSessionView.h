//
//  KKAVCaptureBaseSessionView.h
//  自定义相机成像基类
//
//  Created by 力王 on 16/11/17.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface KKAVCaptureBaseSessionView : UIView
@property (nonatomic, readonly) AVCaptureSession *session;//session：输入输出结合在一起，并开始启动捕获设备（摄像头）
@property (nonatomic, readonly) AVCaptureVideoPreviewLayer *previewLayer;//图像预览层，实时显示捕获的图像
@property (nonatomic,   strong) AVCaptureDevice *device;//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property (nonatomic,   strong) AVCaptureDeviceInput *input;//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property (nonatomic,   strong) AVCaptureOutput *output;//输出图片
@property (nonatomic,   assign) AVCaptureDevicePosition devicePosition;//选择前后摄像头（默认为后摄像头）
@property (nonatomic,   assign) AVCaptureSessionPreset sessionPreset;//设置图片品质（默认KKAVCaptureSessionPresetPhoto）
@property (nonatomic,   assign) AVCaptureFlashMode flashMode;//闪光模式
@property (nonatomic,   assign) BOOL showFocusView;//是否显示关闭对焦功能 (默认为YES)


/**
 根据前后置位置拿到相应的摄像头

 @param position 前后摄像头枚举
 @return 设备
 */
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position;

/**
 开始取景
 */
-(void)startRunning;

/**
 结束取景
 */
- (void)stopRunning;
@end
