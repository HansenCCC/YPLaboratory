//
//  UITextField+KExtension.m
//  QMKKXProduct
//
//  Created by Hansen on 1/8/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "UITextField+KExtension.h"

@implementation UITextField (KExtension)
/// 获取光标位置
- (NSRange) selectedRange{
    UITextPosition *beginning = self.beginningOfDocument;
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}

/// 设置光标位置
/// @param range 光标位置
- (void) setSelectedRange:(NSRange) range{
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}
@end
