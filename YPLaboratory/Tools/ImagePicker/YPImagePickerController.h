//
//  YPImagePickerController.h
//  YPLaboratory
//  感觉 block 方便一点，所以我把 delegate = self，加了一些 Callback
//  Created by Hansen on 2023/6/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPImagePickerController : UIImagePickerController

@property (nonatomic, copy) void (^didCompleteCallback)(NSDictionary<UIImagePickerControllerInfoKey,id> *images);
@property (nonatomic, copy) void (^didCancelCallback)(void);

@end

NS_ASSUME_NONNULL_END

