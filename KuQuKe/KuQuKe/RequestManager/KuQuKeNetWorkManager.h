//
//  KuQuKeNetWorkManager.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/15.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KuQuKeNetWorkManager : NSObject


/**
 创建单利
 */
+ (instancetype)sharedInstance;

/**
 接口测试demo
 */
+ (QMURLSessionTask *)GET_KuqukeWithParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 获取签到列表
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 uid  int  必需  无  用户唯一id
 */
+ (QMURLSessionTask *)GET_kuqukeSignIndex:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 信息接口统一
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 uid  int  必需  1  用户id
 */
+ (QMURLSessionTask *)GET_getIndexConfig:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 登入
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 deviceid  string  必需  无  设备唯一id
 phonetype  int  必需  无  1安卓 2IOS
 */
+ (QMURLSessionTask *)POST_Kuqukelogin:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;

/**
 现金签到
 */
+ (QMURLSessionTask *)POST_CheckIn:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 任务列表(含专属任务)
 get kuquke.yiyunrj.xyz/task/getTaskList
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 type	int	必需	1	1应用赚 2游戏赚
 uid	int	必需	1	用户id
 num	int	必需	10	每页数量
 page	int	必需	1	请求页数
 */
+ (QMURLSessionTask *)GET_getTaskListParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 获取用户基本信息
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 uid  int  必需  无  用户唯一id
 */
+ (QMURLSessionTask *)GET_UserInfoParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 关于我们
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 uid  int  必需  1  用户id
 */
+ (QMURLSessionTask *)GET_aboutUsParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 大转盘列表信息
 get kuquke.yiyunrj.xyz/User/turntableList
 
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 */
+ (QMURLSessionTask *)GET_turntableListParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;

/**
 大转盘抽奖
 post kuquke.yiyunrj.xyz/User/turntable
 
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 uid  int  必需  无  用户唯一id
 */
+ (QMURLSessionTask *)POST_turntable:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 分享页面基本信息
 get kuquke.yiyunrj.xyz/User/shareInfo
 
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 uid  int  必需  无  用户唯一id
 */
+ (QMURLSessionTask *)GET_shareInfoParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;



/**
 任务详情V2
 get kuquke.yiyunrj.xyz/task/taskDetailV2
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 id	int	必需	1	任务id
 uid	int	必需	1	用户id
 nowtype	int	必需	1	nowtype = 3 专属任务nowtype = 2 正在进行中nowtype = 1 新参加的
 */
+ (QMURLSessionTask *)GET_taskDetailV2Params:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;



/**
 图片上传
 post kuquke.yiyunrj.xyz/api/upload/taskImgUpload
 
 参数  类型  必需/可选  默认  描述
 file  图片文件  必需  1  图片文件
 */
+ (QMURLSessionTask *)POST_taskImgUploadParams:(NSDictionary *)params uploadWithImage:(UIImage *)image filename:(NSString *)filename name:(NSString *)name View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure showHUD:(BOOL)showhud networkstatus:(BOOL)netstatus showError:(BOOL)showError checkLoginStatus:(BOOL)checkLoginStatus;




/**
 提交任务
 post kuquke.yiyunrj.xyz/task/addTaskOk
 
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 id  int  必需  1  任务id
 uid  int  必需  无  用户id
 applyid  int  必需  1  参加id，详情中会有返回
 account  string  必需  无  账号
 mobile  string  必需  1  手机号
 code  string  必需  无  验证吗
 img  string  必需  无  图片
 */
+ (QMURLSessionTask *)POST_addTaskOkParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 开始任务
 post kuquke.yiyunrj.xyz/task/taskStart
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 id	int	必需	1	任务id
 uid	int	必需	无	用户id
 */
+ (QMURLSessionTask *)POST_taskStartParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 更新用户信息
 post kuquke.yiyunrj.xyz/User/updateUserInfo
 
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 type  int  必需  1  识别字段，提交对应修改
 data  string  必需  无  需要修改的值
 */
+ (QMURLSessionTask *)POST_updateUserInfoParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 正在进行中的任务列表
 get kuquke.yiyunrj.xyz/task/nowTaskList
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 type	int	必需	1	1应用赚 2游戏赚
 uid	int	必需	1	用户id
 num	int	必需	10	每页数量
 page	int	必需	1	请求页数
 */
+ (QMURLSessionTask *)GET_nowTaskListParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;

/**
 记录列表  消息中心
 get kuquke.yiyunrj.xyz/user/messageLog
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 type	int	必需	1	1应用赚 2游戏赚
 uid	int	必需	1	用户id
 num	int	必需	10	每页数量
 page	int	必需	1	请求页数
 */
+ (QMURLSessionTask *)GET_messageLogParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 提现申请判断
 post kuquke.yiyunrj.xyz/User/isWithdrawal
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	无	用户唯一id
 type	int	必需	无	1支付宝提现 2微信提现
 */
+ (QMURLSessionTask *)POST_isWithdrawalParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 提现申请
 post kuquke.yiyunrj.xyz/User/withdrawal
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	无	用户唯一id
 type	int	必需	无	1支付宝提现 2微信提现
 price	string	必需	无	申请及金额
 */
+ (QMURLSessionTask *)POST_withdrawalParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;

/**
 判断用户是否有上级
 post kuquke.yiyunrj.xyz/User/checkLogin
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	无	用户唯一id
 */
+ (QMURLSessionTask *)POST_checkLoginParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 绑定密码页面
 post kuquke.yiyunrj.xyz/User/bindPage
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	无	用户唯一id
 */
+ (QMURLSessionTask *)POST_bindPageParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 提交绑定信息页面
 post kuquke.yiyunrj.xyz/User/bindPost
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	无	用户唯一id
 mobile	string	必需	无	手机号
 pswd	string	必需	无	密码1
 pswd2	string	必需	无	第二次密码
 */
+ (QMURLSessionTask *)POST_bindPostParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 我的徒弟
 get kuquke.yiyunrj.xyz/user/mySubList
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	1	用户id
 num	int	必需	10	每页数量
 page	int	必需	1	请求页数
 */
+ (QMURLSessionTask *)GET_mySubListParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;



/**
 我的收入记录
 get kuquke.yiyunrj.xyz/user/myAccountLog
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	1	用户id
 num	int	必需	10	每页数量
 page	int	必需	1	请求页数
 */
+ (QMURLSessionTask *)GET_myAccountLogParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;



/**
 我的提现
 get kuquke.yiyunrj.xyz/user/withdrawalLog
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	1	用户id
 num	int	必需	10	每页数量
 page	int	必需	1	请求页数
 */
+ (QMURLSessionTask *)GET_withdrawalLogParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;

/**
 获取客服URL
 get kuquke.yiyunrj.xyz/Index/getKefuUrl
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	无	用户id
 */
+ (QMURLSessionTask *)GET_getKefuUrlParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 手机/ID密码登录
 post kuquke.yiyunrj.xyz/User/bindLogin
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 mobile	sting	必需	无	用户的手机号/ID
 password	sting	必需	无	用户密码
 */
+ (QMURLSessionTask *)POST_bindLoginParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;

/**
 找回密码
 post kuquke.yiyunrj.xyz/User/findPassword
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 mobile	sting	必需	无	用户的手机号
 */
+ (QMURLSessionTask *)POST_findPasswordParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;
	
	
	

/**
 进行中的任务

 get kuquke.yiyunrj.xyz/task/getBakList
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 type	int	必需	1	1应用赚 2游戏赚
 uid	int	必需	1	用户id
 num	int	必需	10	每页数量
 page	int	必需	1	请求页数
 */
+ (QMURLSessionTask *)GET_getBakListParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;

	
	
	
/**
 公告列表
 get kuquke.yiyunrj.xyz/index/noticeList
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 num	int	必需	10	每页数量
 page	int	必需	1	请求页数
 */
+ (QMURLSessionTask *)GET_noticeListParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;

	
	
	
	
	

@end
