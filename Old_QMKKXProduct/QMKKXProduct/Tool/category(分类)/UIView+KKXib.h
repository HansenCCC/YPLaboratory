//
//  UIView+KKXib.h
//  Bee
//
//  Created by 程恒盛 on 2019/10/25.
//  Copyright © 2019 南京. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KKXib)
@property (nonatomic, assign) IBInspectable CGFloat cornerRadious;
@property (nonatomic, assign) IBInspectable BOOL masksToBounds;
@property (nonatomic, strong) IBInspectable UIColor* borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

@end

