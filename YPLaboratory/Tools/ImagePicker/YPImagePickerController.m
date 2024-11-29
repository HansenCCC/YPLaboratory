//
//  YPImagePickerController.m
//  YPLaboratory
//
//  Created by Hansen on 2023/6/21.
//

#import "YPImagePickerController.h"

@interface YPImagePickerController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation YPImagePickerController

- (instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.didCompleteCallback) {
            self.didCompleteCallback(info);
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.didCancelCallback) {
            self.didCancelCallback();
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
