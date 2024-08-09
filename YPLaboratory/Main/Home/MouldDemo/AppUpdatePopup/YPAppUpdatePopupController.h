//
//  YPAppUpdatePopupController.h
//  YPLaboratory
//
//  Created by Hansen on 2023/6/27.
//

#import <YPUIKit/YPUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPAppUpdatePopupController : YPPopupController

@property (nonatomic, copy) NSString *updateTitle;
@property (nonatomic, copy) NSString *updateContent;
@property (nonatomic, assign) BOOL forceUpdate;

@end

NS_ASSUME_NONNULL_END
