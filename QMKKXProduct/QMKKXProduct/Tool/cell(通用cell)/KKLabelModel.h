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
@property (assign, nonatomic) BOOL isCanEdit;//是否能够编辑    default NO
@property (strong, nonatomic) NSString *title;//标题
@property (strong, nonatomic) NSString *value;//内容
@property (strong, nonatomic) NSString *imageName;//图片资源
@property (strong, nonatomic) NSString *placeholder;//占位符
@property (strong, nonatomic) id info;//扩展

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value;
@end

