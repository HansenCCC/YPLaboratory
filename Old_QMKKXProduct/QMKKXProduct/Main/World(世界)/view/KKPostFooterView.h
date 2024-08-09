//
//  KKPostFooterView.h
//  KKLAFProduct
//
//  Created by Hansen on 8/25/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKPostFooterView : UIView
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSAttributedString *attributedText;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) void (^whenTapAciton)(NSInteger index);
@end

