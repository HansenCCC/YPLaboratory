//
//  KKTextFieldViewController.h
//  KKLAFProduct
//
//  Created by Hansen on 9/2/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKBaseViewController.h"

@interface KKTextFieldViewController : KKBaseViewController
@property (assign, nonatomic) NSInteger maxCount;//字体字数  默认为 999999
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSString *placeholder;//占位符
@property (copy  , nonatomic) void (^whenComplete)(NSString *value);//点击保存回调

@end

