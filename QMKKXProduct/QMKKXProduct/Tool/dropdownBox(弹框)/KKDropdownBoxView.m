//
//  KKDropdownBoxView.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/7/10.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKDropdownBoxView.h"

@interface KKDropdownBoxView ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (copy  , nonatomic) KKDropdownBoxViewBlock complete;
@property (strong, nonatomic) UIView *contentView;//
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.contentView addSubview:self.tableView];
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
- (void)showWithView:(UIView *)view{
    UIView *window = [UIApplication sharedApplication].keyWindow;
    CGRect f1 = [window convertRect:view.frame toView:window];
    f1.origin.y = f1.origin.y + view.bounds.size.height;
    f1.size.width = AdaptedWidth(100.f);
    f1.size.height = AdaptedWidth(400.f);
    self.tableView.frame = f1;
    [window addSubview:self];
}
//click tap
- (void)__whenTapGesture{
    [self removeFromSuperview];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.font = AdaptedFontSize(14.f);
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedWidth(38.f);
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
//-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGFloat startX = self.frame.origin.x;
//    CGFloat startY = self.frame.origin.y;
//    CGContextMoveToPoint(context, startX, startY);//设置起点
//    CGContextAddLineToPoint(context, startX+5, startY-5);
//    CGContextAddLineToPoint(context, startX+5, startY+5);
//    //
//    CGContextClosePath(context);
//    [self.backgroundColor setFill];
//    [self.backgroundColor setStroke];
//    CGContextDrawPath(context, kCGPathFillStroke);
//}
@end
