//
//  KKBrushFlowToolCollectionViewCell.h
//  QMKKXProduct
//
//  Created by Hansen on 2021/9/10.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKBrushFlowToolCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, copy)  void (^whenCompleteBlock)(BOOL success);

@end

NS_ASSUME_NONNULL_END
