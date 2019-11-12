//
//  KKPickerAlert.m
//  CHHomeDec
//
//  Created by 程恒盛 on 2019/3/27.
//  Copyright © 2019 Herson. All rights reserved.
//

#import "KKPickerAlert.h"

@interface KKPickerAlert ()<UIPickerViewDelegate,UIPickerViewDataSource>

@end

@implementation KKPickerAlert
- (instancetype)initWithTitles:(NSArray<NSString *> *)titles{
    if (self = [self initWithPresentType:KKUIBaseMiddlePresentType]) {
        self.titles = titles;
        self.canTouchBeginMove = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupConfirmBar];
    [self setupPickerView];
    //傻屌动画
    self.contentView.alpha = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat presentedHeight = kPickViewHeight;
        self.contentView.transform = CGAffineTransformMakeTranslation(0, presentedHeight);
        [UIView animateWithDuration:0.3 animations:^{
            self.contentView.alpha = 1.0f;
            self.contentView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            //todo
        }];
    });
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect bounds = self.view.bounds;
    //
    CGRect f1 = bounds;
    f1.size.height = [self.inputToolBar sizeThatFits:CGSizeZero].height;
    self.inputToolBar.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size.height = kPickViewHeight;
    f2.origin.y = CGRectGetMaxY(f1);
    self.pickerView.frame = f2;
    //
    CGRect f3 = bounds;
    f3.size.height = f1.size.height + f2.size.height;
    f3.origin.y = bounds.size.height - f3.size.height;
    self.contentView.frame = f3;
}
//设置确定栏
- (void)setupConfirmBar {
    KKInputToolBar *bar = [[KKInputToolBar alloc] init];
    self.inputToolBar = bar;
    [self.contentView addSubview:bar];
    WeakSelf
    self.inputToolBar.whenClickBlock = ^(NSInteger index) {
        [weakSelf dismissViewControllerCompletion:nil];
        if (index == 0) {
            
        }else if(index == 1){
            if (weakSelf.confirmBlock) {
                weakSelf.confirmBlock(weakSelf.index);
            }
        }
    };
}
//设置picker view
- (void)setupPickerView {
    UIPickerView *p = [[UIPickerView alloc] init];
    p.backgroundColor = KKColor_F0F0F0;
    self.pickerView = p;
    p.delegate = self;
    p.dataSource = self;
    [self.contentView addSubview:p];
}
- (void)setIndex:(NSInteger)index {
    if (index < self.titles.count) {
        _index = index;
        [self.pickerView selectRow:index inComponent:0 animated:NO];
    } else {
        _index = 0;
    }
}
- (void)updateTitles:(NSArray<NSString *> *)titles{
    self.titles = titles;
    [self.pickerView reloadAllComponents];
}
#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.titles.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.titles[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.index = row;
}
@end
