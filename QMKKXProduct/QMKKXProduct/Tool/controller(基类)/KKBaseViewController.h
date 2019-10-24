//
//  KKBaseViewController.h
//  FanRabbit
//
//  Created by 程恒盛 on 2019/5/28.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKBaseViewController : UIViewController
//@interface KKBaseViewController : LSBaseViewController
@property (nonatomic,   strong) UIImage *backBtnImage;//返回按钮图片
@property (nonatomic, readonly) UIButton *backButton;

//构造backItem
- (void)setupNavBackItem;
- (void)setupNavBackItemConfig;
//back点击回调
- (void)backItemClick;
@end

