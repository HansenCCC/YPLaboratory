//
//  KKDatePickerAlert.h
//  CHHomeDec
//
//  Created by 程恒盛 on 2019/4/1.
//  Copyright © 2019 Herson. All rights reserved.
//

#import "KKUIBasePresentController.h"

typedef void(^KKDatePickerAlertConfirmBlock)(NSDate *date);

@interface KKDatePickerAlert : KKUIBasePresentController
@property (nonatomic,   copy) KKDatePickerAlertConfirmBlock confirmBlock;
@property (nonatomic, strong) KKInputToolBar *inputToolBar;//输入框
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;//pickerModel

- (instancetype)initWithDate:(NSDate *)date;
@end

