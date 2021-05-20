//
//  NSMutableAttributedString+KExtension.h
//  QMKKXProduct
//
//  Created by Hansen on 1/10/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
//缓存参数
UIKIT_EXTERN NSAttributedStringKey const NSAttributedInfoAttributeName;

@interface NSMutableAttributedString (KExtension)
//缓存参数
@property (strong, nonatomic) NSString *attributedInfo;

@end

