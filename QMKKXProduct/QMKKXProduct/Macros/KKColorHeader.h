//
//  KKColorHeader.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#ifndef KKColorHeader_h
#define KKColorHeader_h

#define CMCustomColor(colorStr) [UIColor colorWithHexString:colorStr]
#define KKColor_RANDOM [UIColor colorWithRandomColor]//随机
#define KKColor_CLEAR  [UIColor clearColor]//通明


//通用
#define KKColor_FFFFFF CMCustomColor(@"FFFFFF")//白色
#define KKColor_999999 CMCustomColor(@"999999")//灰色
#define KKColor_F0F0F0 CMCustomColor(@"F0F0F0")//默认背景白
#define KKColor_2C2C2C CMCustomColor(@"2C2C2C")//默认背景黑
#define KKColor_0000FF CMCustomColor(@"0000FF")//默认背景蓝
#define KKColor_000000 CMCustomColor(@"000000")//黑色



//白色 ->
#define KKColor_F3F4F6 CMCustomColor(@"F3F4F6")
#define KKColor_EEEEEE CMCustomColor(@"EEEEEE")
#define KKColor_DDE7F0 CMCustomColor(@"DDE7F0")
#define KKColor_888888 CMCustomColor(@"888888")
#define KKColor_666666 CMCustomColor(@"666666")
#define KKColor_DDDDDD CMCustomColor(@"DDDDDD")
#define KKColor_333333 CMCustomColor(@"333333")
#define KKColor_2E3032 CMCustomColor(@"2E3032")

#define KKColor_CCCCCC CMCustomColor(@"CCCCCC")
#define KKColor_DDDDDD CMCustomColor(@"DDDDDD")
#define KKColor_FFE12F CMCustomColor(@"FFE12F")
#define KKColor_FEFCEB CMCustomColor(@"FEFCEB")
//红色 ->
#define KKColor_F74245 CMCustomColor(@"F74245")
#define KKColor_F96A0E CMCustomColor(@"F96A0E")

//绿色 ->

//蓝色 ->


//other
#define KKColor_FD445F CMCustomColor(@"FD445F")
#define KKColor_BBBBBB CMCustomColor(@"BBBBBB")
#define KKColor_F7F8FA CMCustomColor(@"F7F8FA")

//微信朋友圈
#define KKColor_626787 CMCustomColor(@"626787")//昵称
#define KKColor_1A1A1A CMCustomColor(@"1A1A1A")//内容
#define KKColor_AFAFAF CMCustomColor(@"AFAFAF")//时间
#define KKColor_E5E5E5 CMCustomColor(@"E5E5E5")//线条
#define KKColor_F6F6F6 CMCustomColor(@"F6F6F6")//喜欢

#endif /* KKColorHeader_h */
