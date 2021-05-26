//
//  KKLabelModel.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/11.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKLabelModel : NSObject
@property (assign, nonatomic) BOOL isShowArrow;//是否显示Arrow default NO
@property (assign, nonatomic) BOOL isShowLine;//是否显示线条    default NO
@property (assign, nonatomic) BOOL isShowStar;//是否显示star   default NO
@property (assign, nonatomic) BOOL isCanEdit;//是否能够编辑    default NO
@property (assign, nonatomic) BOOL isEnabled;//是否允许响应事件    default YES
@property (strong, nonatomic) NSString *title;//标题
@property (strong, nonatomic) NSString *value;//内容
@property (strong, nonatomic) NSString *imageName;//图片资源
@property (assign, nonatomic) CGSize imageSize;//图片资源尺寸 默认 25*25
@property (strong, nonatomic) NSString *rightImageName;//右边图片资源 默认 0*0
@property (assign, nonatomic) CGSize rightImageSize;//右边图片资源尺寸
@property (strong, nonatomic) NSString *placeholder;//占位符
@property (strong, nonatomic) NSString *count;//未读消息
@property (strong, nonatomic) id info;//扩展
@property (assign, nonatomic) Class cellClass;//cellClass

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value;
@end

