//
//  KKPickerAlert.h
//  CHHomeDec
//
//  Created by 程恒盛 on 2019/3/27.
//  Copyright © 2019 Herson. All rights reserved.
//

#import "KKUIBasePresentController.h"
#import "KKInputToolBar.h"

typedef void(^KKPickerAlertConfirmBlock)(NSInteger index);

@interface KKPickerAlert : KKUIBasePresentController<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic,   copy) NSArray <NSString *> *titles;
@property (nonatomic, assign) NSInteger index;//当前选中index
@property (nonatomic,   copy) KKPickerAlertConfirmBlock confirmBlock;
@property (nonatomic, strong) KKInputToolBar *inputToolBar;//输入框

//标准初始化
- (instancetype)initWithTitles:(NSArray<NSString *> *)titles;
//刷新
- (void)updateTitles:(NSArray<NSString *> *)titles;
@end


