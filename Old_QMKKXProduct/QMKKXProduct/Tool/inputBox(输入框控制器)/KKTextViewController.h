//
//  KKTextViewController.h
//  Bee
//
//  Created by 程恒盛 on 2019/10/22.
//  Copyright © 2019 南京. All rights reserved.
//

#import "KKBaseViewController.h"

@interface KKTextViewController : KKBaseViewController
@property (assign, nonatomic) NSInteger maxCount;//字体字数  默认为 999999
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSString *placeholder;//占位符
@property (copy  , nonatomic) void (^whenComplete)(NSString *value);//点击保存回调
@property (assign, nonatomic) BOOL isAllowReturn;//是否允许换行 默认YES
@end
