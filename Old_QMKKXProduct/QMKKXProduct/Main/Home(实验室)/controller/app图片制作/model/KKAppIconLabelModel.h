//
//  KKAppIconLabelModel.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/12.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKLabelModel.h"


@interface KKAppIconLabelModel : KKLabelModel{
    UIImage *_iconImage;
}
@property(strong,  nonatomic) NSString *filePath;
@property(strong,  nonatomic) UIImage *iconImage;
@property(readonly,nonatomic) UIImage *originIconImage;

@end

