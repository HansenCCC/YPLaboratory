//
//  KKColorPickAlert.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/12.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKUIBasePresentController.h"
#import "KKPickerAlert.h"

@interface LWUIColorPickerViewCellView  :UIView
@property (readonly, nonatomic) UIView *colorView;
@property (readonly, nonatomic) UILabel *titleLabel;
@property (strong  , nonatomic) UIColor *selectedColor;
@end

@interface KKColorPickAlert : KKPickerAlert

@end

