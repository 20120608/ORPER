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
  [params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];

  NSString *token = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:token forKey:@"token"];
  NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/index/demo",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token"]]];
  
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
  [params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
  [params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];

  NSString *tokenString = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:tokenString forKey:@"token"];
  NSString *url = [NSString stringWithFormat:@"%@/%@",@"http://kuquke.yiyunrj.xyz/User/signIndex",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"uid"]]];
  
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
  [params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
  [params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];

  NSString *token = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:token forKey:@"token"];
  NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/index/getIndexConfig",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"uid"]]];
  
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
  [params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
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
  [params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];

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


/**
 获取任务列表  type  int  必需  1  1应用赚 2游戏赚
 */
+ (QMURLSessionTask *)GET_getTaskListParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  [params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
  [params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];

  NSString *token = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:token forKey:@"token"];
  NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/task/taskList",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"type",@"uid",@"num",@"page"]]];
  
  return [DQMAFNetWork method:GET
                 withchildUrl:url
                    andparams:nil
                         view:view
                       HUDMsg:@"获取任务列表"
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
 获取用户基本信息
 */
+ (QMURLSessionTask *)GET_UserInfoParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  [params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
  [params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
  NSString *token = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:token forKey:@"token"];
  
  NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/User/getUserInfo",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"uid"]]];
  
  return [DQMAFNetWork method:GET
                 withchildUrl:url
                    andparams:nil
                         view:view
                       HUDMsg:@"获取基本信息"
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
 关于我们
 */
+ (QMURLSessionTask *)GET_aboutUsParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  [params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
  [params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
  NSString *token = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:token forKey:@"token"];
  
  NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/index/aboutUs",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"uid"]]];
  
  return [DQMAFNetWork method:GET
                 withchildUrl:url
                    andparams:nil
                         view:view
                       HUDMsg:@"关于我们"
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
 大转盘列表信息
 get kuquke.yiyunrj.xyz/User/turntableList
 
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 */
+ (QMURLSessionTask *)GET_turntableListParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  [params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
  NSString *token = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:token forKey:@"token"];
  
  NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/User/turntableList",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"uid"]]];
  
  return [DQMAFNetWork method:GET
                 withchildUrl:url
                    andparams:nil
                         view:view
                       HUDMsg:@"大转盘列表信息"
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
 大转盘抽奖
 post kuquke.yiyunrj.xyz/User/turntable
 
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 uid  int  必需  无  用户唯一id
 */
+ (QMURLSessionTask *)POST_turntable:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  [params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
  [params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
  NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:postTokenString forKey:@"token"];
  
  NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/User/turntable"];
  return [DQMAFNetWork method:POST
                 withchildUrl:url
                    andparams:params
                         view:view
                       HUDMsg:@"大转盘抽奖"
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
 分享页面基本信息
 get kuquke.yiyunrj.xyz/User/shareInfo
 
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 uid  int  必需  无  用户唯一id
 */
+ (QMURLSessionTask *)GET_shareInfoParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  [params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
  [params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
  NSString *token = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:token forKey:@"token"];
  
  NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/User/shareInfo",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"uid"]]];
  
  return [DQMAFNetWork method:GET
                 withchildUrl:url
                    andparams:nil
                         view:view
                       HUDMsg:@"大转盘列表信息"
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
