//
//  KKTextFieldViewController.m
//  KKLAFProduct
//
//  Created by Hansen on 9/2/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKTextFieldViewController.h"

@interface KKTextFieldViewController ()<UITextViewDelegate>
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) KKTextField *textView;
@property (strong, nonatomic) UILabel *countLabel;
@property (assign, nonatomic) BOOL isAllowReturn;//是否允许换行 默认NO

@end

@implementation KKTextFieldViewController
- (instancetype)init{
    if (self = [super init]) {
        self.isAllowReturn = NO;
        self.maxCount = 99999;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = KKColor_F0F0F0;
    [self setupSubviews];
}
- (void)setupSubviews{
    //
    [self.view addSubview:self.contentView];
    //
    [self.contentView addSubview:self.textView];
    //
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 26)];
    button.layer.cornerRadius = 4.f;
    button.backgroundColor = KKColor_0000FF;
    [button setTitleColor:KKColor_FFFFFF forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(whenClickComplete) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (self.isAllowReturn) {
        self.textView.clearButtonMode = UITextFieldViewModeNever;
        self.textView.rightView = self.countLabel;
        self.textView.rightViewMode = UITextFieldViewModeAlways;
        self.countLabel.text = @(self.maxCount - self.textView.text.length).stringValue;
    }else{
        self.textView.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
}
- (void)whenClickComplete{
    if (self.whenComplete) {
        self.whenComplete(self.textView.text);
    }
    [self backItemClick];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect bounds = self.view.bounds;
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        insets = self.view.safeAreaInsets;
    }
    bounds = UIEdgeInsetsInsetRect(bounds,insets);
    CGRect f1 = bounds;
    f1.origin.x = AdaptedWidth(16.f);
    f1.origin.y += AdaptedWidth(16.f);
    //    f1.origin.y = AdaptedWidth(18.f) + SafeAreaTopHeight;
    f1.size.width = bounds.size.width - f1.origin.x * 2;
    if (self.isAllowReturn) {
        f1.size.height = AdaptedWidth(100.f);
    }else{
        f1.size.height = AdaptedWidth(44.f);
    }
    self.contentView.frame = f1;
    CGRect f2 = self.contentView.bounds;
    if (self.isAllowReturn) {
        f2.origin.y = AdaptedWidth(5.f);
        f2.origin.x = AdaptedWidth(10.f);
        f2.size.height = f1.size.height - 2 * f2.origin.y;
        f2.size.width = f1.size.width - 2 * f2.origin.x;
    }else{
        f2.origin.y = AdaptedWidth(5.f);
        f2.origin.x = AdaptedWidth(10.f);
        f2.size.height = f1.size.height - 2 * f2.origin.y;
        f2.size.width = f1.size.width - 2 * f2.origin.x;
    }
    self.textView.frame = f2;
}
#pragma mark - lazy load
- (KKTextField *)textView{
    if(!_textView){
        _textView = [[KKTextField alloc] init];
        _textView.font = AdaptedFontSize(16.f);
        _textView.textColor = KKColor_000000;
        WeakSelf
        _textView.whenShouldChangeCharactersInRange = ^BOOL(UITextField *textView, NSRange range, NSString *text) {
            if (text.length == 0) {
                return YES;
            }
            NSInteger maxCount = weakSelf.maxCount;
            UITextRange *markedTextRange = textView.markedTextRange;
            if (markedTextRange) {
                return YES;
            }
            if (textView.text.length + text.length - range.length> maxCount) {
                return NO;
            }
            if ([text isEqualToString:@"\n"]) {
                return NO;
            }
            return YES;
        };
        _textView.whenDidEditing = ^(UITextField *textField) {
            NSInteger maxCount = weakSelf.maxCount;
            UITextRange *markedTextRange = textField.markedTextRange;
            if (textField.text.length > maxCount&&markedTextRange == nil) {
                weakSelf.textView.text = [textField.text substringWithRange:NSMakeRange(0, maxCount)];
            }
            weakSelf.countLabel.text = @(weakSelf.maxCount - weakSelf.textView.text.length).stringValue;
        };
    }
    return _textView;
}
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = KKColor_FFFFFF;
        _contentView.layer.cornerRadius = AdaptedWidth(4.f);
        _contentView.clipsToBounds = YES;
        _contentView.layer.borderWidth = 0.5;
        _contentView.layer.borderColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0].CGColor;
        _contentView.layer.cornerRadius = AdaptedWidth(4.f);
    }
    return _contentView;
}
- (UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [UILabel labelWithFont:AdaptedFontSize(14.f) textColor:KKColor_CCCCCC];
        _countLabel.frame = CGRectMake(0, 0, 25, 20);
    }
    return _countLabel;
}
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.textView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:KKColor_999999}];
}
- (void)setValue:(NSString *)value{
    _value = value;
    self.textView.text = value;
}
@end
