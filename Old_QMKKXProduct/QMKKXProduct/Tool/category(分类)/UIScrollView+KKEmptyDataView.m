//
//  UIScrollView+KKEmptyDataView.m
//  Bee
//
//  Created by 程恒盛 on 2019/10/21.
//  Copyright © 2019 南京. All rights reserved.
//

#import "UIScrollView+KKEmptyDataView.h"
static NSString *UIScrollViewEmptyView = @"UIScrollViewEmptyView";;

@implementation UIScrollView (KKEmptyDataView)
- (KKEmptyDataView *)emptyView{
    KKEmptyDataView *view = objc_getAssociatedObject(self, &UIScrollViewEmptyView);
    if (!view) {
        view = [[KKEmptyDataView alloc] init];
        [self addSubview:view];
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.width.height.equalTo(self);
        }];
        [self setEmptyView:view];
    }
    return view;
}
- (void)setEmptyView:(UIView *)emptyView{
    objc_setAssociatedObject(self, &UIScrollViewEmptyView,
                             emptyView,
                             OBJC_ASSOCIATION_ASSIGN);
}
- (void)showEmptyDataView{
    self.emptyView.hidden = NO;
    self.emptyView.emptyImageView.image = UIImageWithName(@"kk_icon_iconempty");
}
- (void)showSearchEmptyDataView{
    self.emptyView.hidden = NO;
    self.emptyView.emptyImageView.image = UIImageWithName(@"kk_icon_iconsearchempty");
}
- (void)showNetworkFailView{
    self.emptyView.hidden = NO;
    self.emptyView.emptyImageView.image = UIImageWithName(@"kk_icon_iconfail");
}
- (void)hiddenDisplayView{
    KKEmptyDataView *view = self.emptyView;
    view.hidden = YES;
}
@end
