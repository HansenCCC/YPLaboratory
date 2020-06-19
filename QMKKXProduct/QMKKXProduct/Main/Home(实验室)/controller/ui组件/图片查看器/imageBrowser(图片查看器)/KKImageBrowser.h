//
//  KKImageBrowser.h
//  QMKKXProduct
//
//  Created by Hansen on 6/17/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKImageBrowserCell.h"

@interface KKImageBrowser : UIView
@property (strong, nonatomic) NSArray <KKImageBrowserModel *> *images;
@property (assign, nonatomic) NSInteger index;//当前下标，下标不能大于image.count

//展示
- (void)show;
@end


