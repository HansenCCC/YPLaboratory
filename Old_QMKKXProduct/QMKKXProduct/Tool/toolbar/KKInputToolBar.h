//
//  KKInputToolBar.h
//  CHHomeDec
//  确认取消工具栏
//  Created by 程恒盛 on 2019/3/27.
//  Copyright © 2019 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKUIFlowLayoutButton.h"

typedef void(^KKInputToolBarActionBlock)(NSInteger index);

@interface KKInputToolBar : UIView
@property (strong, nonatomic) KKUIFlowLayoutButton *sureBtn;//确定
@property (strong, nonatomic) KKUIFlowLayoutButton *cancelBtn;//取消
@property (copy  , nonatomic) KKInputToolBarActionBlock whenClickBlock;

@end

