//
//  KKSinaAiteViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 1/10/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKSinaAiteViewController.h"
#import "KKAiteTextField.h"
#import "KKAiteTextField+KExtension.h"

@interface KKSinaAiteViewController ()
@property (strong, nonatomic) KKAiteTextField *textField;
@property (strong, nonatomic) UIButton *aiteButton;
@property (strong, nonatomic) UIButton *commentButton;
@property (strong, nonatomic) UILabel *commentLabel;

@end

@implementation KKSinaAiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"模拟新浪@人";
    [self setupSubviews];
}
- (void)setupSubviews{
    [self.view addSubview:self.textField];
    [self.view addSubview:self.aiteButton];
    [self.view addSubview:self.commentButton];
    [self.view addSubview:self.commentLabel];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    CGFloat height = AdaptedWidth(40.f);
    f1.origin.x = AdaptedWidth(50.f);
    f1.origin.y = AdaptedWidth(100.f);
    f1.size.width = bounds.size.width - 2 * f1.origin.x;
    f1.size.height = height;
    self.textField.frame = f1;
    //
    CGRect f2 = bounds;
    f2.origin.x = AdaptedWidth(50.f);
    f2.origin.y = CGRectGetMaxY(f1) + AdaptedWidth(10.f);
    f2.size.width = bounds.size.width - 2 * f2.origin.x;
    f2.size.height = height;
    self.aiteButton.frame = f2;
    //
    CGRect f3 = f2;
    f3.origin.y = CGRectGetMaxY(f2) + AdaptedWidth(10.f);
    self.commentButton.frame = f3;
    //
    CGRect f4 = f3;
    f4.origin.y = CGRectGetMaxY(f3) + AdaptedWidth(10.f);
    f4.size.height = [self.commentLabel sizeThatFits:CGSizeMake(f4.size.width, 0)].height;
    self.commentLabel.frame = f4;
}
#pragma mark - action
//@张三
- (void)whenAiteClick{
    KKAiteModel *model = [[KKAiteModel alloc] initWithUserId:@"10010" nickname:@"12只张三"];
    [self.textField addAiteWithAiteModel:model];
}
//发送评论
- (void)whenCommentClick{
    NSString *value = [self.textField getAiteContent];
    NSArray *aites = [self.textField getAiteUserIds];
    NSMutableArray *userIds = [[NSMutableArray alloc] init];
    for (KKAiteModel *model in aites) {
        [userIds addObject:model.user_id];
    }
    self.commentLabel.text = [NSString stringWithFormat:@"\n\n评论内容:\n%@\n\n\n艾特列表:\n%@",value,userIds.mj_JSONString];
    [self viewWillLayoutSubviews];
}
#pragma mark - lazy load
- (KKAiteTextField *)textField{
    if (!_textField) {
        _textField = [[KKAiteTextField alloc] init];
        _textField.backgroundColor = KKColor_000000;
        _textField.textColor = KKColor_FFFFFF;
        _textField.font = AdaptedFontSize(18);
        _textField.highlightColor = KKColor_0000FF;
        _textField.normalColor = KKColor_FFFFFF;
    }
    return _textField;
}
- (UIButton *)aiteButton{
    if (!_aiteButton) {
        _aiteButton = [[UIButton alloc] init];
        [_aiteButton setTitle:@"艾特她他它" forState:UIControlStateNormal];
        _aiteButton.backgroundColor = KKColor_FFE12F;
        _aiteButton.titleLabel.font = AdaptedBoldFontSize(18);
        [_aiteButton addTarget:self action:@selector(whenAiteClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aiteButton;
}
- (UIButton *)commentButton{
    if (!_commentButton) {
        _commentButton = [[UIButton alloc] init];
        [_commentButton setTitle:@"发送评论" forState:UIControlStateNormal];
        _commentButton.backgroundColor = KKColor_F74245;
        _commentButton.titleLabel.font = AdaptedBoldFontSize(18);
        [_commentButton addTarget:self action:@selector(whenCommentClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}
- (UILabel *)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = AdaptedFontSize(12.f);
        _commentLabel.tintColor = KKColor_000000;
        _commentLabel.text = @"--";
        _commentLabel.numberOfLines = 0;
    }
    return _commentLabel;
}
@end
