//
//  KKControlURLProtocol.h
//  MotoVPN3
//  网络监管
//  Created by Hansen on 5/12/21.
//  Copyright © 2021 力王. All rights reserved.
//

//弃用post请求丢body

#import <Foundation/Foundation.h>
//一个h5页面事情：初始化 webview -> 请求页面 -> 下载数据 -> 解析HTML -> 请求 js/css 资源 -> dom 渲染 -> 解析 JS 执行 -> JS 请求数据 -> 解析渲染 -> 下载渲染图片
@interface KKControlURLProtocol : NSURLProtocol


@end

