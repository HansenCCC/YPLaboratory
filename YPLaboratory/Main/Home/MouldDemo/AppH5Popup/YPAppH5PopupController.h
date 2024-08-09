//
//  YPAppH5PopupController.h
//  YPLaboratory
//
//  Created by Hansen on 2023/6/29.
//

#import <YPUIKit/YPUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPAppH5PopupController : YPPopupController

@property (nonatomic, copy) NSString *h5Title;
@property (nonatomic, strong) NSURLRequest *request;

@end

NS_ASSUME_NONNULL_END
