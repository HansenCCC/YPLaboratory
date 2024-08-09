//
//  KKDropdownBoxView.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/7/10.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKDropdownBoxView.h"

@interface KKDropdownBoxTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation KKDropdownBoxTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    f1.origin.x = AdaptedWidth(10.f);
    f1.size = [self.titleLabel sizeThatFits:CGSizeZero];
    f1.origin.y = (bounds.size.height - f1.size.height)/2.0;
    self.titleLabel.frame = f1;
}
@end

@interface KKDropdownBoxView ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (copy  , nonatomic) KKDropdownBoxViewBlock complete;
@property (strong, nonatomic) UIView *contentView;//
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property (strong, nonatomic) UIImageView *tableViewBackgroundView;

@end

@implementation KKDropdownBoxView
//标准初始化
- (instancetype)initWithTitles:(NSArray <NSString *>*)titles withComplete:(KKDropdownBoxViewBlock) complete{
    if (self = [self init]) {
        self.type = KKDropdownBoxViewTypeAuto;
        self.titles = titles;
        self.complete = complete;
        [self setupSubview];
    }
    return self;
}
- (void)setupSubview{
    //
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    [self addSubview:self.contentView];
    //
    self.tableViewBackgroundView = [[UIImageView alloc] init];
    self.tableViewBackgroundView.userInteractionEnabled = YES;
    UIImage *image = UIImageWithName(@"kk_icon_menu");
    //UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
    //UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图片
    UIEdgeInsets insets = UIEdgeInsetsMake(image.size.height/4.0, image.size.width/4.0, image.size.height/4.0, image.size.width/4.0);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    self.tableViewBackgroundView.image = image;
    [self.contentView addSubview:self.tableViewBackgroundView];
    //
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = KKColor_CLEAR;
    [self.tableView registerClass:[KKDropdownBoxTableViewCell class] forCellReuseIdentifier:@"KKDropdownBoxTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableViewBackgroundView addSubview:self.tableView];
    //
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__whenTapGesture)];
    [self.contentView addGestureRecognizer:self.tapGesture];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    UIView *window = [UIApplication sharedApplication].keyWindow;
    CGRect bounds = window.bounds;
    self.frame = bounds;
    //
    self.contentView.frame = bounds;
}
- (void)setTitles:(NSArray<NSString *> *)titles{
    _titles = titles;
    [self.tableView reloadData];
}
//click tap
- (void)__whenTapGesture{
    [self removeFromSuperview];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKDropdownBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKDropdownBoxTableViewCell"];
    cell.titleLabel.text = self.titles[indexPath.row];
    cell.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.titleLabel.font = AdaptedFontSize(12.f);
    cell.backgroundColor = KKColor_CLEAR;
    [cell layoutSubviews];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedWidth(30.f);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.complete) {
        self.complete(indexPath.row);
    }
    [self removeFromSuperview];
}
#pragma mark - draw
- (void)dealloc{
    NSLog(@"释放了");
}

#pragma mark - public
/// 展示view的下拉框
/// @param rect 展示的位置和展示大小
/// @param view 要被展示的view
- (void)showViewCenter:(CGRect)rect toView:(UIView *)view{
    UIView *window = [UIApplication sharedApplication].keyWindow;
    CGRect f1 = [view convertRect:view.bounds toView:window];
    f1.size = rect.size;
    f1.origin.y += rect.origin.y;
    f1.origin.x += rect.origin.x;
    self.tableViewBackgroundView.frame = f1;
    //
    CGRect f2 = self.tableViewBackgroundView.bounds;
    UIEdgeInsets insets = UIEdgeInsetsMake(AdaptedWidth(10), AdaptedWidth(5), AdaptedWidth(5), AdaptedWidth(5));
    f2 = UIEdgeInsetsInsetRect(f2, insets);
    self.tableView.frame = f2;
    [window addSubview:self];
}
@end
