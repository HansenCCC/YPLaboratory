//
//  KKAppIconPreviewViewController.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/13.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKBaseViewController.h"

@interface KKAppIconPreviewViewController : KKBaseViewController
@property(nonatomic,strong) UIImage *iconImage;
@property(nonatomic,strong) NSString *iconPath;
- (instancetype)initWithIconImage:(UIImage *)iconImage;

@end

