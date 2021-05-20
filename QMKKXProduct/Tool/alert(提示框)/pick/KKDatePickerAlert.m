//
//  KKDatePickerAlert.m
//  CHHomeDec
//
//  Created by 程恒盛 on 2019/4/1.
//  Copyright © 2019 Herson. All rights reserved.
//

#import "KKDatePickerAlert.h"
#import "KKColorHeader.h"

@interface KKDatePickerAlert ()
@property (nonatomic, strong) UIDatePicker *pickerView;

@end

@implementation KKDatePickerAlert
- (instancetype)initWithDate:(NSDate *)date{
    if (self = [self initWithPresentType:KKUIBaseMiddlePresentType]) {
        self.datePickerMode = UIDatePickerModeDate;
        self.date = date?:[NSDate date];
        //
        self.pickerView.date = self.date;
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
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
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
    [self.contentView addSubview:self.inputToolBar];
}
//设置picker view
- (void)setupPickerView {
    [self.contentView addSubview:self.pickerView];
}
- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode{
    _datePickerMode = datePickerMode;
    self.pickerView.datePickerMode = datePickerMode;
}
#pragma mark - pickder & tool
- (UIDatePicker *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIDatePicker alloc] init];
        _pickerView.backgroundColor = KKColor_F0F0F0;
        [_pickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pickerView;
}
-(void)dateChanged:(id)sender {
    //NSDate格式转换为NSString格式
    self.date = [self.pickerView date];
}
- (KKInputToolBar *)inputToolBar{
    if (!_inputToolBar) {
        _inputToolBar = [[KKInputToolBar alloc] init];
        WeakSelf
        self.inputToolBar.whenClickBlock = ^(NSInteger index) {
            [weakSelf dismissViewControllerCompletion:nil];
            if (index == 0) {
                //
            }else if(index == 1){
                if (weakSelf.confirmBlock) {
                    weakSelf.confirmBlock(weakSelf.date);
                }
            }
        };
    }
    return _inputToolBar;
}
@end
