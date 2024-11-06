//
//  YPPayInputView.h
//  YPLaboratory
//
//  Created by Hansen on 2024/11/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPPayInputView : UIView

@property (nonatomic, readonly) UITextField *textField;
@property (nonatomic, assign) BOOL secureTextEntry;

@end

NS_ASSUME_NONNULL_END
