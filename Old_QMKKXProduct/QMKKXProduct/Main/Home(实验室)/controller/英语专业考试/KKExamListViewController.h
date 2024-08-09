//
//  KKExamListViewController.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/13.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKBaseViewController.h"


@interface KKExamListViewController : KKBaseViewController


@end

@interface NSArray (Exam)

/**
 解析英语专业考试文档
 根据‘\n‘提取各个字符串
 @param fileName 放在目录下面的文件
 @return @[]
 */
+ (NSArray <NSString *>*)arrayWithStringByExamJson:(NSString *)fileName;
@end
