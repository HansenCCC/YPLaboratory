//
//  UIScrollView+KKEmptyDataView.h
//  Bee
//
//  Created by 程恒盛 on 2019/10/21.
//  Copyright © 2019 南京. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKEmptyDataView.h"

@interface UIScrollView (KKEmptyDataView)
@property (assign, nonatomic) KKEmptyDataView *emptyView;
//显示空数据view
- (void)showEmptyDataView;
//显示搜索空数据view
- (void)showSearchEmptyDataView;
//显示网络错误试图
- (void)showNetworkFailView;

//隐藏空数据|网络错误 view
- (void)hiddenDisplayView;




@end

