//
//  KKAiteTextView.m
//  KKLAFProduct
//
//  Created by Hansen on 7/26/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKAiteTextView.h"
#import "KKAiteTextView+KExtension.h"

@interface KKAiteTextView ()
@property (strong, nonatomic) UIFont *temFont;
@property (assign, nonatomic) CGSize temContentSize;
@property (nonatomic, assign) BOOL isEditing;//是否在编辑状态

@end

@implementation KKAiteTextView
- (instancetype)init{
    if (self = [super init]) {
        [self initConfig];
        self.delegate = self;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initConfig];
        self.delegate = self;
    }
    return self;
}
- (void)initConfig{
    //初始化赋值默认值
    self.highlightColor = [UIColor yellowColor];
    self.normalColor = [UIColor whiteColor];
}
- (void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor;
    self.textColor = normalColor;
}
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.temFont = font;
}
- (void)setContentSize:(CGSize)contentSize{
    [super setContentSize:contentSize];
    if (self.temContentSize.height == contentSize.height) {
        //高度没有变化不更新
    }else{
        if(self.whenNeedUpdateHeight){
            self.whenNeedUpdateHeight(self);
        }
    }
    self.temContentSize = contentSize;
}
//艾特人
- (void)addAiteWithAiteModel:(KKAiteModel *)aiteModel{
    UIColor *foregroundColor = self.highlightColor;
    NSRange range = self.selectedRange;
    NSString *jsonAiteString = [NSString stringWithFormat:@"<remind data=%@/>",aiteModel.mj_JSONString];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //艾特拼接参数
    NSMutableAttributedString *attachText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"@%@",aiteModel.nickname]];
    NSRange attachTextRange = NSMakeRange(0, attachText.length);
    [attachText addAttributes:@{NSForegroundColorAttributeName:foregroundColor} range:attachTextRange];
    [attachText addAttributes:@{NSAttributedInfoAttributeName:jsonAiteString} range:attachTextRange];
    //拼接
    [attributeString insertAttributedString:attachText atIndex:range.length + range.location];
    self.attributedText = [[NSAttributedString alloc] initWithAttributedString:attributeString];
    NSRange selectedRange = NSMakeRange(range.length + range.location + attachText.length, 0);
    self.selectedRange = selectedRange;
    self.font = self.temFont;
    [self updatePlaceholderViewHidden];
}
/// 获取艾特model
- (NSArray <KKAiteModel *>*)getAiteUserIds{
    NSArray *aites = [KKAiteTextView transformAitesByAttributed:self.attributedText];
    return aites;
}
/// 获取评论content
- (NSString *)getAiteContent{
    NSString *value = [KKAiteTextView transformStringByAttributed:self.attributedText];
    return value;
}
#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    //to do
    self.isEditing = NO;
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    //to do
    self.isEditing = YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    //中文拼音预输入
    if (textView.markedTextRange == nil){
        //没有点击出现的汉字,一直在点击键盘
        textView.attributedText = textView.attributedText;
        //每次编辑转化文本
        NSRange selectedRange = self.selectedRange;
        UIColor *defaultColor = self.normalColor;
        UIColor *foregroundColor = self.highlightColor;
        NSString *value = [self.class transformStringByAttributed:self.attributedText];
        NSAttributedString *attributeString = [self.class transformAttributedByString:value highlightColor:foregroundColor normalColor:defaultColor];
        self.attributedText = attributeString;
        self.selectedRange = selectedRange;
    }else{
        //预输入时，不做操作
    }
    self.font = self.temFont;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if (self.whenNeedReturn) {
            self.whenNeedReturn(self);
        }
        return NO;
    }
    //获取textfield
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithAttributedString:textView.attributedText];
    //要替换的attribute
    NSMutableAttributedString *rangeAtt = [[NSMutableAttributedString alloc] initWithAttributedString:[attributeString attributedSubstringFromRange:range]];
    if (rangeAtt.attributedInfo) {
        __block NSRange selectedRange = self.selectedRange;
        [attributeString enumerateAttributesInRange:NSMakeRange(0, attributeString.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithAttributedString:[attributeString attributedSubstringFromRange:range]];
            if ([attributed.attributedInfo isEqual:rangeAtt.attributedInfo]) {
                [attributeString deleteCharactersInRange:range];
                selectedRange.location = range.location;
                selectedRange.length = 0;
            }
        }];
        textView.attributedText = attributeString;
        textView.selectedRange = selectedRange;
        return NO;
    }
    return YES;
}

#pragma mark - UITextFieldDelegate
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    //to do
//}
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    //to do
//}
//- (void)textFieldDidEditing:(UITextField *)textField{
//    //中文拼音预输入
//    if (textField.markedTextRange == nil){
//        //没有点击出现的汉字,一直在点击键盘
//        textField.attributedText = textField.attributedText;
//        //每次编辑转化文本
//        NSRange selectedRange = self.selectedRange;
//        UIColor *defaultColor = self.normalColor;
//        UIColor *foregroundColor = self.highlightColor;
//        NSString *value = [self.class transformStringByAttributed:self.attributedText];
//        NSAttributedString *attributeString = [self.class transformAttributedByString:value highlightColor:foregroundColor normalColor:defaultColor];
//        self.attributedText = attributeString;
//        self.selectedRange = selectedRange;
//    }else{
//        //预输入时，不做操作
//    }
//}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    //获取textfield
//    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithAttributedString:textField.attributedText];
//    //要替换的attribute
//    NSMutableAttributedString *rangeAtt = [[NSMutableAttributedString alloc] initWithAttributedString:[attributeString attributedSubstringFromRange:range]];
//    if (rangeAtt.attributedInfo) {
//        __block NSRange selectedRange = self.selectedRange;
//        [attributeString enumerateAttributesInRange:NSMakeRange(0, attributeString.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
//            NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithAttributedString:[attributeString attributedSubstringFromRange:range]];
//            if ([attributed.attributedInfo isEqual:rangeAtt.attributedInfo]) {
//                [attributeString deleteCharactersInRange:range];
//                selectedRange.location = range.location;
//                selectedRange.length = 0;
//            }
//        }];
//        textField.attributedText = attributeString;
//        textField.selectedRange = selectedRange;
//        return NO;
//    }
//    return YES;
//}
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
//    return YES;
//}
@end
