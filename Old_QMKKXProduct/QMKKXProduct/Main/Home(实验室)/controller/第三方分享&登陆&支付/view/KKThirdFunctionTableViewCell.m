//
//  KKThirdFunctionTableViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 6/1/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKThirdFunctionTableViewCell.h"

@interface KKThirdFunctionTableViewCell ()

@end

@implementation KKThirdFunctionTableViewCell
- (void)awakeFromNib{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setCellModel:(KKLabelModel *)cellModel{
    _cellModel = cellModel;
    if (cellModel.isEnabled) {
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:cellModel.title?:@"--"];
        self.titleLabel.attributedText = attributed;
    }else{
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:cellModel.title?:@"--"];
        [attributed addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, attributed.length)];
        self.titleLabel.attributedText = attributed;
    }
}
- (IBAction)whenAcitonClick:(UIButton *)sender {
    NSInteger index = 0;
    if (self.loginButton == sender) {
        //登录
        index = 0;
    }else if(self.shareButton == sender){
        //分享
        index = 1;
    }else if(self.payButton == sender){
        //支付
        index = 2;
    }
    if (self.whenActionClick) {
        self.whenActionClick(index);
    }
}

@end
