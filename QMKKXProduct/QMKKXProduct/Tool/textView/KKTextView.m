//
//  KKTextView.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/18.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "KKTextView.h"

@interface KKTextView()
@property(strong, nonatomic) UITextView *placeholderView;//占位符
@end

@implementation KKTextView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self __myInitialization];
        //textfield font 默认尺寸
//        self.font = [UIFont systemFontOfSize:17.f];
    }
    return self;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(CGSize)sizeThatFits:(CGSize)size{
    CGSize sizeFits = [super sizeThatFits:size];
    if (self.text.length == 0) {
        if (self.placeholder.length != 0) {
            sizeFits = [self.placeholderView sizeThatFits:size];
        }
    }
    if(self.preferredMaxHeight > 0){
        sizeFits.height = MIN(sizeFits.height, self.preferredMaxHeight);
    }
    return sizeFits;
}

- (void)__myInitialization{
    self.placeholderView = [[UITextView alloc] init];
    self.placeholderView.textColor = KKColor_999999;
    self.placeholderView.userInteractionEnabled = NO;
    self.placeholderView.hidden = YES;
    [self addSubview:self.placeholderView];
    //监听输入框变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__onTextChange:) name:UITextViewTextDidChangeNotification object:self];
}
- (void)__onTextChange:(NSNotification *)sender{
    if (sender.object!=self){
        return;
    }
    [self __updatePlaceholderViewHidden];
}
- (void)__updatePlaceholderViewHidden{
    self.placeholderView.hidden = self.text.length!=0||self.placeholder.length==0;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    if(!self.placeholderView.hidden){
        CGRect f1 = bounds;
        self.placeholderView.frame = f1;
        [self sendSubviewToBack:self.placeholderView];
    }
}
#pragma mark - echo
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self.placeholderView setFont:font];
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    [super setTextAlignment:textAlignment];
    self.placeholderView.textAlignment = textAlignment;
}
- (void)setText:(NSString *)text{
    [super setText:text];
    [self __updatePlaceholderViewHidden];
}
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderView.text = placeholder;
    [self __updatePlaceholderViewHidden];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    self.placeholderView.textColor = placeholderColor;
}
- (void)setContentInset:(UIEdgeInsets)contentInset{
    [super setContentInset:contentInset];
    [self.placeholderView setContentInset:contentInset];
}
- (void)setContentSize:(CGSize)contentSize{
    CGSize oldSize = self.contentSize;
    [super setContentSize:contentSize];
    if(oldSize.height!=contentSize.height){
        if(self.whenContentHeightChange){
            self.whenContentHeightChange(self,contentSize.height);
        }
    }
}
@end
