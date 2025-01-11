//
//  YPDisableScreenCaptureViewController.m
//  YPLaboratory
//
//  Created by Hansen on 2024/11/4.
//

#import "YPDisableScreenCaptureViewController.h"

@interface YPDisableScreenCaptureViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation YPDisableScreenCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.textField];
    
    Class _UITextLayoutCanvasView = NSClassFromString(@"_UITextLayoutCanvasView");
    UIView *canvasView = [self.textField yp_findSubviewsOfClass:_UITextLayoutCanvasView].firstObject;
    [canvasView addSubview:self.imageView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [YPAlertView alertText:@"截屏试试，你会看不到 Logo。".yp_localizedString];
    });
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    self.textField.frame = f1;
    
    CGRect f2 = bounds;
    f2.origin.x = 50.f;
    f2.size.width = bounds.size.width - f2.origin.x * 2;
    f2.size.height = f2.size.width;
    f2.origin.y = (bounds.size.height - f2.size.height) / 2.f;
    self.imageView.frame = f2;
}

#pragma mark - setter | getters

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.secureTextEntry = YES;
        _textField.userInteractionEnabled = YES;
        _textField.delegate = self;
    }
    return _textField;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"yp_icon_1024"];
    }
    return _imageView;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

@end
