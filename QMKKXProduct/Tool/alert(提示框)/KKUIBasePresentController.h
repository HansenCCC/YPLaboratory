//
//  KKUIBasePresentController.h
//  lwui
//
//  Created by 程恒盛 on 2019/3/27.
//  Copyright © 2019 力王. All rights reserved.
//

#import "KKPresentAnimation.h"
#import "KKBaseViewController.h"
typedef NS_ENUM(NSInteger,KKUIBasePresentType) {
    KKUIBaseMiddlePresentType,
    KKUIBaseBottomPresentType
};
typedef void (^KKUIBaseColseCompletionBlock)(void);

@interface KKUIBasePresentController : KKBaseViewController
//属性
@property (nonatomic, strong) UIView *contentView;//自定义view容器
@property (nonatomic, assign) BOOL canTouchBeginMove;//是否允许点击时退出
@property (nonatomic, assign) KKUIBasePresentType type;//弹出方式
@property (nonatomic, strong) UIColor *maskColor;//弹出后蒙版的颜色  默认为黑色0.5透明度

//回调
@property (nonatomic, copy) KKUIBaseColseCompletionBlock colseCompletionAction;//弹窗关闭后的回调
@property (nonatomic, copy) KKUIBaseColseCompletionBlock screenClickAction;//点击蒙版的回调

//标准初始化
- (instancetype)initWithPresentType:(KKUIBasePresentType) type;
//弹框消失  completion  完成的回调
- (void)dismissViewControllerCompletion:(void (^)(void))completion;
@end

