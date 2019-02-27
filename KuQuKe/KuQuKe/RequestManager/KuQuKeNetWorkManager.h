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
 获取任务列表
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 type  int  必需  1  1应用赚 2游戏赚
 uid  int  必需  1  用户id
 num  int  必需  10  每页数量
 page  int  必需  1  请求页数

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
 任务详情
 get kuquke.yiyunrj.xyz/task/taskDetail
 
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 id  int  必需  1  任务id
 uid  int  必需  1  用户id
 */
+ (QMURLSessionTask *)GET_taskDetailParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;



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



@end
