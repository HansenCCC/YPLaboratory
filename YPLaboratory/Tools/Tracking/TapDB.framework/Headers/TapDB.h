#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef struct LoginType{
    NSString *loginType;
}TapDBLoginType;


/*
自定义登录方式：
TapDBLoginType customLoginType = {@"custom"};
*/
FOUNDATION_EXPORT TapDBLoginType const TapDBLoginTypeTapTap;
FOUNDATION_EXPORT TapDBLoginType const TapDBLoginTypeWeiXin;
FOUNDATION_EXPORT TapDBLoginType const TapDBLoginTypeQQ;
FOUNDATION_EXPORT TapDBLoginType const TapDBLoginTypeTourist;
FOUNDATION_EXPORT TapDBLoginType const TapDBLoginTypeApple;
FOUNDATION_EXPORT TapDBLoginType const TapDBLoginTypeZhifubao;
FOUNDATION_EXPORT TapDBLoginType const TapDBLoginTypeFacebook;
FOUNDATION_EXPORT TapDBLoginType const TapDBLoginTypeGoogle;
FOUNDATION_EXPORT TapDBLoginType const TapDBLoginTypeTwitter;
FOUNDATION_EXPORT TapDBLoginType const TapDBLoginTypePhoneNumber;

#define TapDBSDK               @"TapDB"
#define TapDBSDK_VERSION_NUMBER @"31805002"
#define TapDBSDK_VERSION        @"3.18.5.1"
//版本号
static NSString *const TAPDB_VERSION = TapDBSDK_VERSION;

typedef NS_ENUM(NSInteger, TapDBRegion)
{
    TapDBRegionTypeCN ,
    TapDBRegionTypeIO
};

@interface TapDB : NSObject
/**
 Controls the access to IDFA
 If not explicitly set, the default is NO
 */
@property (class, nonatomic, assign, getter=isAdvertiserIDCollectionEnabled) BOOL advertiserIDCollectionEnabled;

/**
 * 是否打开日志输出
 * enbale : YES 打开 NO 关闭
 */
+ (void)enableLog:(BOOL)enable;

/**
 * 调用该接口修改数据发送的域名，有特殊需要时调用，调用必须位于初始化之前
 * 域名必须是https://abc.example.com/的格式，不能为空
 */
+ (void)setHost:(NSString *)host;

/**
 * 调用该接口修改自定义事件数据发送的域名，有特殊需要时调用，调用必须位于初始化之前
 * 域名必须是https://abc.example.com/的格式，不能为空
 */
+ (void)setCustomEventHost:(NSString *)host;

+ (void)onStart:(NSString *)appId channel:(nullable NSString *)channel version:(nullable NSString *)gameVersion;
/**
 * 初始化，尽早调用
 * appId: 注册游戏时获得的APP ID
 * channel: 分包渠道名称，可为空
 * gameVersion: 游戏版本，可为空，为空时，自动获取游戏安装包的版本（Xcode配置中的Version）
 * properties: 自定义属性
 */
+ (void)onStart:(NSString *)appId channel:(nullable NSString *)channel version:(nullable NSString *)gameVersion properties:(nullable NSDictionary *)properties;

+ (void)onStartWithClientId:(NSString *)clientId channel:(nullable NSString *)channel version:(nullable NSString *)gameVersion;

//sm
+ (void)onStartWithClientId:(NSString *)clientId channel:(nullable NSString *)channel version:(nullable NSString *)gameVersion isCN:(BOOL)isCN DEPRECATED_MSG_ATTRIBUTE("use onStartWithClientId:channel:version:region:properties");

/**
 * 初始化，尽早调用
 * clientId: TapTap登录sdk后台页面 client id
 * channel: 分包渠道名称，可为空
 * gameVersion: 游戏版本，可为空，为空时，自动获取游戏安装包的版本（Xcode配置中的Version）
 * properties: 自定义属性
 */
+ (void)onStartWithClientId:(NSString *)clientId channel:(nullable NSString *)channel version:(nullable NSString *)gameVersion properties:(nullable NSDictionary *)properties;

/**
 * 初始化，尽早调用
 * clientId: TapTap登录sdk后台页面 client id
 * channel: 分包渠道名称，可为空
 * gameVersion: 游戏版本，可为空，为空时，自动获取游戏安装包的版本（Xcode配置中的Version）
 * region: 区域
 * properties: 自定义属性
 */
+ (void)onStartWithClientId:(NSString *)clientId channel:(nullable NSString *)channel version:(nullable NSString *)gameVersion region:(TapDBRegion) region properties:(nullable NSDictionary *)properties;

+ (void)setUser:(NSString *)userId;

+ (void)setUser:(NSString *)userId properties:(nullable NSDictionary *)properties;
/// 对外隐藏接口
+ (void)setUser:(NSString *)userId loginType:(TapDBLoginType)loginType;

/// 记录一个用户（不是游戏角色！！！！），需要保证唯一性
/// @param userId 用户ID。不同用户需要保证ID的唯一性
/// @param loginType 登录方式
/// @param properties 自定义属性
+ (void)setUser:(NSString *)userId loginType:(TapDBLoginType)loginType properties:(nullable NSDictionary *)properties;

/**
 登出清理用户
 */
+ (void)clearUser;
/**
 * 目前TapDB SDK仅支持单实例模式，如果多次调用onStart方法，只有最初传入的appid生效。调用该函数可以获取生效的信息
 * 返回值：包含appId和channel的NSDictionary，对应的value均可能为nil
 */
+ (NSDictionary *)getStartInfo;

/// 获取当前的设备标识
+ (NSString *)getDeviceId;

/**
 * 设置用户等级，初次设置时或升级时调用
 * level: 等级
 */
+ (void)setLevel:(NSInteger)level;

/**
 * 设置用户服务器，初次设置或更改服务器的时候调用
 * server: 服务器
 */
+ (void)setServer:(NSString *)server;

/// 设置用户名
/// @param name 必传，长度大于0并小于等于256，用户名
+ (void)setName:(NSString *)name;

+ (void)onChargeSuccess:(nullable NSString *)orderId product:(nullable NSString *)product amount:(NSInteger)amount currencyType:(nullable NSString *)currencyType payment:(nullable NSString *)payment;

/**
 * 充值成功时调用
 * orderId: 订单ID，可为空
 * product: 产品名称，可为空
 * amount: 充值金额（单位分，即无论什么币种，都需要乘以100）
 * currencyType: 货币类型，可为空，参考：人民币 CNY，美元 USD；欧元 EUR
 * payment: 支付方式，可为空，如：支付宝
 * properties: 事件属性，需要在控制后台预先进行配置,值为长度大于0并小于等于256的字符串或绝对值小于1E11的浮点数
 */
+ (void)onChargeSuccess:(nullable NSString *)orderId product:(nullable NSString *)product amount:(NSInteger)amount currencyType:(nullable NSString *)currencyType payment:(nullable NSString *)payment properties:(nullable NSDictionary *)properties;
/**
 * 自定义事件
 * eventName: 事件代码，需要在控制后台预先进行配置
 * properties: 事件属性，需要在控制后台预先进行配置,值为长度大于0并小于等于256的字符串或绝对值小于1E11的浮点数
 */
+ (void)trackEvent:(NSString *)eventName properties:(NSDictionary *)properties;

/**
 * 自定义事件,即将弃用，请使用trackEvent接口
 * eventCode: 事件代码，需要在控制后台预先进行配置
 * properties: 事件属性，需要在控制后台预先进行配置,值为长度大于0并小于等于256的字符串或绝对值小于1E11的浮点数
 */
+ (void)onEvent:(NSString *)eventCode properties:(NSDictionary *)properties DEPRECATED_MSG_ATTRIBUTE("已弃用，请按文档迁移到trackEvent接口");

#pragma mark - operation
/// 初始化设备属性操作
/// @param properties 属性字典
+ (void)deviceInitialize:(NSDictionary *)properties;

/// 更新设备属性操作
/// @param properties 属性字典
+ (void)deviceUpdate:(NSDictionary *)properties;

/// 设备属性增加操作
/// @param properties 属性字典 暂时只支持数字属性
+ (void)deviceAdd:(NSDictionary *)properties;

/// 初始化用户属性操作
/// @param properties 属性字典
+ (void)userInitialize:(NSDictionary *)properties;

/// 更新用户属性操作
/// @param properties 属性字典
+ (void)userUpdate:(NSDictionary *)properties;

/// 用户属性增加操作
/// @param properties 属性字典 暂时只支持数字属性
+ (void)userAdd:(NSDictionary *)properties;


#pragma mark - properties
/// 添加静态事件属性，每个事件都将会发送
/// @param staticProperties 属性字典
+ (void)registerStaticProperties:(NSDictionary *)staticProperties;

/// 删除添加的静态事件属性
+ (void)clearStaticProperties;

/// 删除添加的某个静态事件属性
/// @param propertyName 属性Key
+ (void)unregisterStaticProperty:(NSString *)propertyName;

/// 添加动态事件属性，每次发送事件会调用dynamicPropertiesCaculator
/// @param dynamicPropertiesCaculator 动态属性回调，需返回希望上传的属性字典
+ (void)registerDynamicProperties:(NSDictionary* (^)(void))dynamicPropertiesCaculator;

//是否在 TapDB 使用 Themis
+ (void)enableThemis:(bool) enable;

@end

NS_ASSUME_NONNULL_END
