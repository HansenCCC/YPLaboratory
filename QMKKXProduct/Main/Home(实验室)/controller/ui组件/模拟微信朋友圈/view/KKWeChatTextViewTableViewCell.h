//
//  KKWeChatTextViewTableViewCell.h
//  QMKKXProduct
//
//  Created by Hansen on 2/12/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKWeChatTextViewTableViewCell : UITableViewCell<UITextViewDelegate>
@property (strong, nonatomic) KKLabelModel *cellModel;
@property (strong, nonatomic) KKTextView *textView;
@property (assign, nonatomic) UIEdgeInsets contentInsets;//间距
AS_SINGLETON(KKWeChatTextViewTableViewCell);
@end

