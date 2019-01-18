//
//  DQMAFNetWork.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/15.
//  Copyright © 2019 kuquke. All rights reserved.
//

//在AFNetWorking的基础上进行封装
#import <Foundation/Foundation.h>
#import "QMBaseNetWorking.h"/** 网络请求基类 */

//请求方式
typedef NS_ENUM(NSInteger,DQMNetMethod) {
  GET,
  POST,
};



@class RequestStatusModel;
@interface DQMAFNetWork : NSObject

/** 单利 */
+ (DQMAFNetWork *)sharedDQMAFNetWork;

/**
 基本请求
 @param method 请求方式
 @param childUrl 子类
 @param params 参数
 @param msg 提示消息
 @param showhud 是否需要遮罩
 @param success 成功回调
 @param unknown 有返回值但不为200
 @param failure 失败回调
 @param graceTime 宽恕时间
 @param netstatus 是否进行网络提示
 */
+(QMURLSessionTask *)method:(DQMNetMethod)method
 withchildUrl:(NSString *)childUrl
    andparams:(NSDictionary *)params
         view:(UIView *)view
       HUDMsg:(NSString *)msg
      success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success
      unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown
      failure:(void(^)(NSError *error))failure
    graceTime:(NSTimeInterval)graceTime
      showHUD:(BOOL)showhud
networkstatus:(BOOL)netstatus;

/**
 基本请求 带登入验证
 */
+(QMURLSessionTask *)method:(DQMNetMethod)method
               withchildUrl:(NSString *)childUrl
                  andparams:(NSDictionary *)params
                       view:(UIView *)view
                     HUDMsg:(NSString *)msg
                    success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success
                    unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown
                    failure:(void(^)(NSError *error))failure
                  graceTime:(NSTimeInterval)graceTime
                    showHUD:(BOOL)showhud
              networkstatus:(BOOL)netstatus
           checkLoginStatus:(BOOL)checkLoginStatus;


@end


@interface RequestStatusModel : NSObject

@property (nonatomic,copy   ) NSString     *status; /* 状态值 和后台协商 */
@property (nonatomic,copy   ) NSString     *token;  /* 类似token */
@property (nonatomic,copy   ) NSString     *code;   /* 和status类似 */
@property (nonatomic,copy   ) NSString     *message;/* 信息1 */
@property (nonatomic,copy   ) NSString     *msg;    /* 信息2 */
@property (nonatomic,strong ) NSDictionary *data;   /* 数据数组、字典 */
@property (nonatomic,strong ) NSArray      *list;   /* 数据数组、字典 */

@end


//使用示例
// /**
// 获取天气的接口
// */
//+(QMURLSessionTask *)getWeather:(NSDictionary *)params AndView:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;
//
// /**
// 获取天气的接口
// */
//+(QMURLSessionTask *)getWeather:(NSDictionary *)params AndView:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
//  return [DQMAFNetWork method:POST
//                 withchildUrl:@"/data/sk/101110101.html"
//                    andparams:params
//                         view:view
//                       HUDMsg:@"请求天气接口"
//                      success:^(RequestStatusModel * _Nonnull reqsModel, NSDictionary * _Nonnull dataDic) {
//                        if (success) {
//                          success(reqsModel,dataDic);
//                        }
//                      }
//                      unknown:^(RequestStatusModel * _Nonnull reqsModel, NSDictionary * _Nonnull dataDic) {
//                        if (unknown) {
//                          unknown(reqsModel,dataDic);
//                        }
//                      }
//                      failure:^(NSError * _Nonnull error) {
//                        if (failure) {
//                          failure(error);
//                        }
//                      }
//                    graceTime:2
//                      showHUD:true
//                networkstatus:true];
//}
