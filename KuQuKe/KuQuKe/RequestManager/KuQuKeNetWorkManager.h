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
 获取天气信息
 */
+(QMURLSessionTask *)GETWeather:(NSDictionary *)params AndView:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure CheckLoginStatus:(BOOL)checkstatus;

@end
