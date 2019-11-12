//
//  KKColorPickAlert.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/12.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKColorPickAlert.h"

@interface LWUIColorPickerViewCellView ()
@property (strong, nonatomic) UIView *colorView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation LWUIColorPickerViewCellView
-(instancetype)init{
    if (self = [super init]) {
        self.colorView = [[UIView alloc] init];
        self.colorView.layer.borderColor = [UIColor blackColor].CGColor;
        self.colorView.layer.borderWidth = 1;
        [self addSubview:self.colorView];
        //
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:23.5];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.titleLabel];
    }
    return  self;
}
- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    self.colorView.backgroundColor = selectedColor;
    //
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    //color
    CGRect f1 = bounds;
    f1.size.height = 10;
    f1.size.width = 32;
    f1.origin.y = (bounds.size.height-f1.size.height)/2;
    f1.origin.x = 20;
    self.colorView.frame = f1;
    //title
    CGRect f2 = bounds;
    f2.origin.x = CGRectGetMaxX(f1)+5;
    f2.size.width = bounds.size.width-f2.origin.x-5;
    self.titleLabel.frame = f2;
}
@end

@interface KKColorPickAlert ()

@end

@implementation KKColorPickAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    LWUIColorPickerViewCellView *cell = (LWUIColorPickerViewCellView *)view;
    if (!cell||[cell isKindOfClass:[LWUIColorPickerViewCellView class]]) {
        cell = [[LWUIColorPickerViewCellView alloc] init];
    }
    NSDictionary *dic = [UIColor commonColors];
    cell.titleLabel.text = self.titles[row];
    cell.selectedColor = [dic objectForKey:self.titles[row]];
    return cell;
}
@end
