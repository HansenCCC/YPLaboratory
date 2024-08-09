//
//  YPCameraViewController.m
//  YPLaboratory
//
//  Created by Hansen on 2023/6/30.
//

#import "YPCameraViewController.h"
#import "YPCameraCaptureSessionView.h"

@interface YPCameraViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) YPCameraCaptureSessionView *sessionView;

@end

@implementation YPCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        return;
    }
    
    [self.view addSubview:self.sessionView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.sessionView startRunning];
    });
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    self.sessionView.frame = f1;
}

#pragma mark - getters | setters

- (YPCameraCaptureSessionView *)sessionView {
    if (!_sessionView) {
        _sessionView = [[YPCameraCaptureSessionView alloc] init];
        _sessionView.showFocusView = NO;
    }
    return _sessionView;
}

@end
