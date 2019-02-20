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
 获取签到列表
 */
+ (QMURLSessionTask *)GET_kuqukeSignIndex:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 接口测试demo
 */
+ (QMURLSessionTask *)GET_KuqukeWithParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 信息接口统一
 */
+ (QMURLSessionTask *)GET_getIndexConfig:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


/**
 登入
 */
+ (QMURLSessionTask *)POST_Kuqukelogin:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;

/**
 现金签到
 */
+ (QMURLSessionTask *)POST_CheckIn:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;


@end
