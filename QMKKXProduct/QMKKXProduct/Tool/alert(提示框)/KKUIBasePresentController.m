//
//  KKUIBasePresentController.m
//  lwui
//
//  Created by 程恒盛 on 2019/3/27.
//  Copyright © 2019 力王. All rights reserved.
//

#import "KKUIBasePresentController.h"

@interface KKUIBasePresentController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, assign) double keybordOffset;//键盘弹起时弹窗偏移的距离 默认向上偏移100
@property (nonatomic, strong) UIControl *bottomView;

@end

@implementation KKUIBasePresentController
- (instancetype)init{
    if (self = [super init]) {
        self.transitioningDelegate = self;
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        //        UIModalPresentationFullScreen =0,//由下到上,全屏覆盖
        //        UIModalPresentationPageSheet,//在portrait时是FullScreen，在landscape时和FormSheet模式一样。
        //        UIModalPresentationFormSheet,// 会将窗口缩小，使之居于屏幕中间。在portrait和landscape下都一样，但要注意landscape下如果软键盘出现，窗口位置会调整。
        //        UIModalPresentationCurrentContext,//这种模式下，presented VC的弹出方式和presenting VC的父VC的方式相同。
        //        UIModalPresentationCustom,//自定义视图展示风格,由一个自定义演示控制器和一个或多个自定义动画对象组成。符合UIViewControllerTransitioningDelegate协议。使用视图控制器的transitioningDelegate设定您的自定义转换。
        //        UIModalPresentationOverFullScreen,//如果视图没有被填满,底层视图可以透过
        //        UIModalPresentationOverCurrentContext,//视图全部被透过
        //        UIModalPresentationPopover,
        //        UIModalPresentationN
        
        //        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (instancetype)initWithPresentType:(KKUIBasePresentType)type{
    if (self = [self init]) {
        self.type = type;
    }
    return self;
}
- (void)dismissViewControllerCompletion:(void (^)(void))completion{
    [self.view resignFirstResponder];
    __weak typeof(self) weakSelf = self;
    if (weakSelf.colseCompletionAction) {
        weakSelf.colseCompletionAction();
    }
    [super dismissViewControllerAnimated:NO completion:completion];
    if (self.type == KKUIBaseMiddlePresentType) {
        
    }else{
        
    }
}
- (void)setMaskColor:(UIColor *)maskColor{
    _maskColor = maskColor;
    //
    self.bottomView.backgroundColor = maskColor;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addObserver];//添加监听
    self.bottomView = [[UIControl alloc] init];
    [self.bottomView addTarget:self action:@selector(bottomViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomView];
    self.maskColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    self.contentView =[[UIView alloc] init];
    [self.bottomView addSubview:self.contentView];
}
- (void)bottomViewClick{
    if (self.screenClickAction) {
        self.screenClickAction();
    }
    if (self.canTouchBeginMove) {
        [self dismissViewControllerCompletion:nil];
    }
}
- (void)addObserver{
    
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    self.bottomView.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size.width = CGRectGetMaxX(self.contentView.verticalDistanceView.frame);
    f2.size.height = CGRectGetMaxY(self.contentView.horizontalDistanceView.frame);
    f2.origin.x = (bounds.size.width - f2.size.width)/2;
    if (self.type == KKUIBaseMiddlePresentType) {
        f2.origin.y = (bounds.size.height - f2.size.height)/2;
    }else if(self.type == KKUIBaseBottomPresentType){
        f2.origin.y = bounds.size.height - f2.size.height;
    }
    self.contentView.frame = f2;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    KKPresentAnimation *animation = [[KKPresentAnimation alloc] init];
    animation.isPresent = NO;
    if (self.type == KKUIBaseMiddlePresentType) {
        animation.type = KKPresentAnimationTypeMiddle;
    }else if(self.type == KKUIBaseBottomPresentType){
        animation.type = KKPresentAnimationTypeBottom;
    }
    return animation;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    KKPresentAnimation *animation = [[KKPresentAnimation alloc] init];
    animation.isPresent = YES;
    if (self.type == KKUIBaseMiddlePresentType) {
        animation.type = KKPresentAnimationTypeMiddle;
    }else if(self.type == KKUIBaseBottomPresentType){
        animation.type = KKPresentAnimationTypeBottom;
    }
    return animation;
}
@end
