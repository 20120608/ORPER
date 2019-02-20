//
//  KuQuKeNetWorkManager.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/15.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "KuQuKeNetWorkManager.h"

@implementation KuQuKeNetWorkManager

/**
 单利
 */
+ (instancetype)sharedInstance {
  static KuQuKeNetWorkManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

/**
 接口测试demo
 */
+ (QMURLSessionTask *)GET_KuqukeWithParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  
  NSString *token = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:token forKey:@"token"];
  NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/index/demo",[QMSGeneralHelpers changeParamsToString:params]];
  
  return [DQMAFNetWork method:GET
                 withchildUrl:url
                    andparams:nil
                         view:view
                       HUDMsg:@"测试接口"
                      success:^(RequestStatusModel * _Nonnull reqsModel, NSDictionary * _Nonnull dataDic) {
                        if (success) {
                          success(reqsModel,dataDic);
                        }
                      }
                      unknown:^(RequestStatusModel * _Nonnull reqsModel, NSDictionary * _Nonnull dataDic) {
                        if (unknown) {
                          unknown(reqsModel,dataDic);
                        }
                      }
                      failure:^(NSError * _Nonnull error) {
                        if (failure) {
                          failure(error);
                        }
                      }
                    graceTime:3
                      showHUD:true
                networkstatus:true
             checkLoginStatus:false];
}

/**
 获取签到列表
 */
+ (QMURLSessionTask *)GET_kuqukeSignIndex:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  
  NSString *tokenString = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:tokenString forKey:@"token"];
  NSString *url = [NSString stringWithFormat:@"%@/%@",@"http://kuquke.yiyunrj.xyz/User/signIndex",[QMSGeneralHelpers changeParamsToString:params]];
  
  return  [DQMAFNetWork method:GET withchildUrl:url andparams:nil view:view HUDMsg:@"获取签到列表"
                       success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
                         if (success) {
                           success(reqsModel,dataDic);
                         }
                       }
                       unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
                         if (unknown) {
                           unknown(reqsModel,dataDic);
                         }
                       }
                       failure:^(NSError *error) {
                         if (failure) {
                           failure(error);
                         }
                       }
                     graceTime:3
                       showHUD:true
                     showError:true
                 networkstatus:true
              checkLoginStatus:false];
}


/**
 首页信息接口统一
 */
+ (QMURLSessionTask *)GET_getIndexConfig:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  NSString *token = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:token forKey:@"token"];
  NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/index/getIndexConfig",[QMSGeneralHelpers changeParamsToString:params]];
  
  return [DQMAFNetWork method:GET
                 withchildUrl:url
                    andparams:nil
                         view:view
                       HUDMsg:@" 首页信息接口统一"
                      success:^(RequestStatusModel * _Nonnull reqsModel, NSDictionary * _Nonnull dataDic) {
                        if (success) {
                          success(reqsModel,dataDic);
                        }
                      }
                      unknown:^(RequestStatusModel * _Nonnull reqsModel, NSDictionary * _Nonnull dataDic) {
                        if (unknown) {
                          unknown(reqsModel,dataDic);
                        }
                      }
                      failure:^(NSError * _Nonnull error) {
                        if (failure) {
                          failure(error);
                        }
                      }
                    graceTime:3
                      showHUD:true
                networkstatus:true
             checkLoginStatus:false];
}


/**
 登入
 */
+ (QMURLSessionTask *)POST_Kuqukelogin:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure  {
  NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:postTokenString forKey:@"token"];
  
  NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/User/login"];
  return [DQMAFNetWork method:POST
                 withchildUrl:url
                    andparams:params
                         view:view
                       HUDMsg:@"酷趣客登入"
                      success:^(RequestStatusModel * _Nonnull reqsModel, NSDictionary * _Nonnull dataDic) {
                        if (success) {
                          success(reqsModel,dataDic);
                        }
                      }
                      unknown:^(RequestStatusModel * _Nonnull reqsModel, NSDictionary * _Nonnull dataDic) {
                        if (unknown) {
                          unknown(reqsModel,dataDic);
                        }
                      }
                      failure:^(NSError * _Nonnull error) {
                        if (failure) {
                          failure(error);
                        }
                      }
                    graceTime:3
                      showHUD:true
                networkstatus:true
             checkLoginStatus:false];
}


/**
 现金签到
 */
+ (QMURLSessionTask *)POST_CheckIn:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure  {
  NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:postTokenString forKey:@"token"];
  
  NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/User/sign"];
  return [DQMAFNetWork method:POST
                 withchildUrl:url
                    andparams:params
                         view:view
                       HUDMsg:@"现金签到"
                      success:^(RequestStatusModel * _Nonnull reqsModel, NSDictionary * _Nonnull dataDic) {
                        if (success) {
                          success(reqsModel,dataDic);
                        }
                      }
                      unknown:^(RequestStatusModel * _Nonnull reqsModel, NSDictionary * _Nonnull dataDic) {
                        if (unknown) {
                          unknown(reqsModel,dataDic);
                        }
                      }
                      failure:^(NSError * _Nonnull error) {
                        if (failure) {
                          failure(error);
                        }
                      }
                    graceTime:3
                      showHUD:true
                networkstatus:true
             checkLoginStatus:false];
}



@end
