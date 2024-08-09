//
//  KKAiteTextField.h
//  QMKKXProduct
//
//  Created by Hansen on 1/10/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>


/// 艾特model
@interface KKAiteModel : NSObject
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *createDate;
- (instancetype)initWithUserId:(NSString *)userId nickname:(NSString *)nickname;
@end


/// 艾特Textfield
@interface KKAiteTextField : UITextField<UITextFieldDelegate>
@property (strong, nonatomic) UIColor *highlightColor;//高亮颜色 默认yellowColor
@property (strong, nonatomic) UIColor *normalColor;//普通颜色 默认whiteColor

/// 艾特人
/// @param aiteModel 艾特model
- (void)addAiteWithAiteModel:(KKAiteModel *)aiteModel;
/// 获取艾特model
- (NSArray <KKAiteModel *>*)getAiteUserIds;
/// 获取评论content
- (NSString *)getAiteContent;
@end

