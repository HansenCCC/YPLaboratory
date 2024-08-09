//
//  YPHTTPResponse.h
//  WTPlatformSDK
//
//  Created by Hansen on 2022/12/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


//错误代码(code)    错误描述(message)
//9    服务器返回message信息
//-101    未初始化
//-102    请求头部的user-agent不匹配
//-400    请求错误(参数不合法,请求方式不正确)
//-401    参数校验错误
//-403    拒绝访问(未登录,或用户权限不足)
//-404    请求的内容不存在
//-444    服务端维护中
//-500    服务器内部错误
//-501    服务器系统错误
//-502    服务器API错误
//-503    服务器调用太快
//-900    游客注册关闭
//-10001    Json解析异常
//1001    未登录
//1002    帐号已封禁
//1003    与验证码图片不匹配
//1004    手机验证码错误
//1005    姓名与身份证不匹配
//1006    同意身份证认证次数过多
//2000    AppKey不存在或者已封禁
//2001    服务器返回数据异常/网络未连接
//2002    无效的登录Token(登录已过期)
//2003    无效的API签名(程序错误)
//2007    游客充值关闭
//3001    用户未登录或登录已超时
//3003    注销失败
//6001    用户取消注册
//6002    用户取消登录
//7000    添加订单失败
//7001    订单参数签名错误，即order_sign参数值错误
//7002    查单超时
//7004    订单不存在
//7005    uid不统一支付失败
//7007    支付失败
//60005    熔断
//60006    限流
//91001    关闭登录
//500003    账号密码错误
//500004    错误次数过多
//500005    用户名不合法
//500006    用户名已存在
//500007    邮箱不合法
//500008    邮箱已注册
//500009    手机号码不合法
//500010    手机已存在
//500011    验证码发送失败
//500012    密码不安全，请提高密码强度
//500013    今日验证码发送次数已达上限
//500014    密码与原密码相同
//900001    未知错误

extern NSString *const kYP_RESPONESE_CODE;
extern NSString *const kYP_RESPONESE_MESSAGE;
extern NSString *const kYP_RESPONESE_TOKEN;
extern NSString *const kYP_RESPONESE_PKGTYPE;
extern NSString *const kYP_RESPONESE_VERSION;
extern NSString *const kYP_RESPONESE_PHONE_ATUO;

@interface YPHTTPResponse : NSObject

@property (nonatomic, readonly) NSInteger code;// 0 表示成功
@property (nonatomic, readonly) NSString *message;// 0 表示成功
@property (nonatomic, copy) NSDictionary *responseData;

@end

NS_ASSUME_NONNULL_END
