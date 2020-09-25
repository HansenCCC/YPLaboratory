//
//  KKAiteTextView.h
//  KKLAFProduct
//
//  Created by Hansen on 7/26/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKTextView.h"
#import "KKAiteTextField.h"


@interface KKAiteTextView : KKTextView<UITextViewDelegate>
@property (strong, nonatomic) UIColor *highlightColor;//高亮颜色 默认yellowColor
@property (strong, nonatomic) UIColor *normalColor;//普通颜色 默认whiteColor
@property (strong, nonatomic) void (^whenNeedUpdateHeight)(KKTextView *textView);
@property (strong, nonatomic) void (^whenNeedReturn)(KKTextView *textView);
@property (nonatomic, readonly) BOOL isEditing;//是否在编辑状态

/// 艾特人
/// @param aiteModel 艾特model
- (void)addAiteWithAiteModel:(KKAiteModel *)aiteModel;
/// 获取艾特model
- (NSArray <KKAiteModel *>*)getAiteUserIds;
/// 获取评论content
- (NSString *)getAiteContent;

@end
