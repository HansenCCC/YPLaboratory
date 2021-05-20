//
//  KKImagePickerController.m
//  FanRabbit
//
//  Created by 程恒盛 on 2019/6/3.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KKImagePickerController.h"

@interface KKImagePickerController ()

@end

@implementation KKImagePickerController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        //在iOS13中，modalPresentationStyle的默认值是UIModalPresentationAutomatic，而在iOS12以下的版本，默认值是UIModalPresentationFullScreen，这就导致了在iOS13中present出来的页面没法全屏。
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    
}
@end
