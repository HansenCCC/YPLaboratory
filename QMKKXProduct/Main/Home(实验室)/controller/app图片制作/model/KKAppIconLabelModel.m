//
//  KKAppIconLabelModel.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/12.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKAppIconLabelModel.h"

@implementation KKAppIconLabelModel
- (UIImage *)originIconImage{
    UIImage *image = nil;
    if([[NSFileManager defaultManager] fileExistsAtPath:self.filePath]){
        image = [[UIImage alloc] initWithContentsOfFile:self.filePath];
    }
    return image;
}
- (UIImage *)iconImage{
    if(!_iconImage){
        _iconImage = self.originIconImage;
    }
    return _iconImage;
}
- (void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage;
}
@end
