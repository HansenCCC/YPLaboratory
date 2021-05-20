//
//  KKTextViewController.m
//  Bee
//
//  Created by 程恒盛 on 2019/10/22.
//  Copyright © 2019 南京. All rights reserved.
//

#import "KKTextViewController.h"

@interface KKTextViewController ()<UITextViewDelegate>
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) KKTextView *textView;
@property (strong, nonatomic) UILabel *countLabel;

@end

@implementation KKTextViewController
- (instancetype)init{
    if (self = [super init]) {
        self.isAllowReturn = YES;
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
    //
    self.countLabel.text = @(self.maxCount - self.textView.text.length).stringValue;
    [self.view addSubview:self.countLabel];
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
        f1.size.height = AdaptedWidth(150.f);
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
    //
    CGRect f3 = bounds;
    f3.origin.x = f1.origin.x + f2.origin.x;
    f3.origin.y = CGRectGetMaxY(f1) + AdaptedWidth(10.f);
    f3.size = [self.countLabel sizeThatFits:CGSizeZero];
    self.countLabel.frame = f3;
}
#pragma mark - lazy load
- (KKTextView *)textView{
    if(!_textView){
        _textView = [[KKTextView alloc] init];
        _textView.font = AdaptedFontSize(16.f);
        _textView.textColor = KKColor_000000;
        _textView.delegate = self;
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
    self.textView.placeholderColor = KKColor_999999;
    self.textView.placeholder = placeholder;
}
- (void)setValue:(NSString *)value{
    _value = value;
    self.textView.text = value;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (text.length == 0) {
        return YES;
    }
    NSInteger maxCount = self.maxCount;
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
}
- (void)textViewDidChange:(UITextView *)textView{
    NSInteger maxCount = self.maxCount;
    UITextRange *markedTextRange = textView.markedTextRange;
    if (textView.text.length > maxCount&&markedTextRange == nil) {
        self.textView.text = [textView.text substringWithRange:NSMakeRange(0, maxCount)];
    }
    self.countLabel.text = @(self.maxCount - self.textView.text.length).stringValue;
    [self viewDidLayoutSubviews];
}

@end
