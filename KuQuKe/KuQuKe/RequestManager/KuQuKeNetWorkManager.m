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
	
[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];

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
+ (QMURLSessionTask *)GET_getTaskListParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  [params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
  [params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];

  NSString *token = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:token forKey:@"token"];
  NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/task/getTaskList",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"type",@"uid",@"num",@"page"]]];
  
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
+ (QMURLSessionTask *)GET_taskDetailV2Params:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  [params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
  [params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
  NSString *token = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:token forKey:@"token"];
  
  NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/task/taskDetailV2",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"id",@"uid",@"nowtype"]]];
  
  return [DQMAFNetWork method:GET
                 withchildUrl:url
                    andparams:nil
                         view:view
                       HUDMsg:@"任务详情"
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
 图片上传
 post kuquke.yiyunrj.xyz/api/upload/taskImgUpload
 
 参数  类型  必需/可选  默认  描述
 file  图片文件  必需  1  图片文件
 */
+ (QMURLSessionTask *)POST_taskImgUploadParams:(NSDictionary *)params uploadWithImage:(UIImage *)image filename:(NSString *)filename name:(NSString *)name View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure showHUD:(BOOL)showhud networkstatus:(BOOL)netstatus showError:(BOOL)showError checkLoginStatus:(BOOL)checkLoginStatus {
  
  return [DQMAFNetWork uploadWithImage:image
                          withchildUrl:@"http://kuquke.yiyunrj.xyz/api/upload/taskImgUpload"
                             andparams:params
                              filename:filename
                                  name:name
                                  view:view
                                HUDMsg:@"图片上传"
                               success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
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
                               } graceTime:1000 showHUD:false networkstatus:false showError:true checkLoginStatus:false];
  
}


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
+ (QMURLSessionTask *)POST_addTaskOkParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  
  [params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
  [params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
  NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:postTokenString forKey:@"token"];
  
  NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/task/addTaskOk"];
  return [DQMAFNetWork method:POST
                 withchildUrl:url
                    andparams:params
                         view:view
                       HUDMsg:@"提交任务"
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
 开始任务
 post kuquke.yiyunrj.xyz/task/taskStart
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 id	int	必需	1	任务id
 uid	int	必需	无	用户id

 */
+ (QMURLSessionTask *)POST_taskStartParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
	NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:postTokenString forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/task/taskStart"];
	return [DQMAFNetWork method:POST
				   withchildUrl:url
					  andparams:params
						   view:view
						 HUDMsg:@"开始任务"
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
 更新用户信息
 post kuquke.yiyunrj.xyz/User/updateUserInfo
 
 参数  类型  必需/可选  默认  描述
 time  int  必需  无  时间戳(用于判断请求是否超时)
 token  string  必需  无  确定来访者身份
 type  int  必需  1  识别字段，提交对应修改
 data  string  必需  无  需要修改的值
 */
+ (QMURLSessionTask *)POST_updateUserInfoParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  
  [params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
  [params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
  
  NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
  [params setValue:postTokenString forKey:@"token"];
  
  NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/User/updateUserInfo"];
  return [DQMAFNetWork method:POST
                 withchildUrl:url
                    andparams:params
                         view:view
                       HUDMsg:@"更新用户信息"
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
+ (QMURLSessionTask *)GET_nowTaskListParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
	NSString *token = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:token forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/task/nowTaskList",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"type",@"uid",@"num",@"page"]]];
	
	return [DQMAFNetWork method:GET
				   withchildUrl:url
					  andparams:nil
						   view:view
						 HUDMsg:@"正在进行中的任务"
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
+ (QMURLSessionTask *)GET_messageLogParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure  {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
	NSString *token = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:token forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/user/messageLog",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"type",@"uid",@"num",@"page"]]];
	
	return [DQMAFNetWork method:GET
				   withchildUrl:url
					  andparams:nil
						   view:view
						 HUDMsg:@"记录列表"
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
 提现申请判断
 post kuquke.yiyunrj.xyz/User/isWithdrawal
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	无	用户唯一id
 type	int	必需	无	1支付宝提现 2微信提现
 */
+ (QMURLSessionTask *)POST_isWithdrawalParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
	
	NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:postTokenString forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/User/isWithdrawal"];
	return [DQMAFNetWork method:POST
				   withchildUrl:url
					  andparams:params
						   view:view
						 HUDMsg:@"提现申请判断"
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
 提现申请
 post kuquke.yiyunrj.xyz/User/withdrawal
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	无	用户唯一id
 type	int	必需	无	1支付宝提现 2微信提现
 price	string	必需	无	申请及金额
 */
+ (QMURLSessionTask *)POST_withdrawalParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure  {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
	
	NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:postTokenString forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/User/withdrawal"];
	return [DQMAFNetWork method:POST
				   withchildUrl:url
					  andparams:params
						   view:view
						 HUDMsg:@"提现申请"
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
 判断用户是否有上级
 post kuquke.yiyunrj.xyz/User/checkLogin
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	无	用户唯一id
 */
+ (QMURLSessionTask *)POST_checkLoginParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
	
	NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:postTokenString forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/User/checkLogin"];
	
	return [DQMAFNetWork method:POST
				   withchildUrl:url
					  andparams:params
						   view:view
						 HUDMsg:@"提现申请"
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
					  showError:false
				  networkstatus:true
			   checkLoginStatus:false];
}


/**
 绑定密码页面
 post kuquke.yiyunrj.xyz/User/bindPage
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	无	用户唯一id
 */
+ (QMURLSessionTask *)POST_bindPageParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
	
	NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:postTokenString forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/User/bindPage"];
	
	return [DQMAFNetWork method:POST
				   withchildUrl:url
					  andparams:params
						   view:view
						 HUDMsg:@"绑定密码"
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
					  showError:false
				  networkstatus:true
			   checkLoginStatus:false];
}


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
+ (QMURLSessionTask *)POST_bindPostParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
	
	NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:postTokenString forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/User/bindPost"];
	
	return [DQMAFNetWork method:POST
				   withchildUrl:url
					  andparams:params
						   view:view
						 HUDMsg:@"提交绑定信息"
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
					  showError:false
				  networkstatus:true
			   checkLoginStatus:false];
}

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
+ (QMURLSessionTask *)GET_mySubListParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
	NSString *token = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:token forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/user/mySubList",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"uid",@"num",@"page"]]];
	
	return [DQMAFNetWork method:GET
				   withchildUrl:url
					  andparams:nil
						   view:view
						 HUDMsg:@"我的徒弟"
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
 我的收入记录
 get kuquke.yiyunrj.xyz/user/myAccountLog
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	1	用户id
 num	int	必需	10	每页数量
 page	int	必需	1	请求页数
 */
+ (QMURLSessionTask *)GET_myAccountLogParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
	NSString *token = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:token forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/user/myAccountLog",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"uid",@"num",@"page"]]];
	
	return [DQMAFNetWork method:GET
				   withchildUrl:url
					  andparams:nil
						   view:view
						 HUDMsg:@"我的收入记录"
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
 我的提现
 get kuquke.yiyunrj.xyz/user/withdrawalLog
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	1	用户id
 num	int	必需	10	每页数量
 page	int	必需	1	请求页数
 */
+ (QMURLSessionTask *)GET_withdrawalLogParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
	NSString *token = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:token forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/user/withdrawalLog",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"uid",@"num",@"page"]]];
	
	return [DQMAFNetWork method:GET
				   withchildUrl:url
					  andparams:nil
						   view:view
						 HUDMsg:@"我的提现"
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
 获取客服URL
 get kuquke.yiyunrj.xyz/Index/getKefuUrl
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 uid	int	必需	无	用户id
 */
+ (QMURLSessionTask *)GET_getKefuUrlParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
	NSString *token = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:token forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/Index/getKefuUrl",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"uid"]]];
	
	return [DQMAFNetWork method:GET
				   withchildUrl:url
					  andparams:nil
						   view:view
						 HUDMsg:@"我的提现"
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
 手机/ID密码登录
 post kuquke.yiyunrj.xyz/User/bindLogin
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 mobile	sting	必需	无	用户的手机号/ID
 password	sting	必需	无	用户密码
 */
+ (QMURLSessionTask *)POST_bindLoginParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	
	NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:postTokenString forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/User/bindLogin"];
	
	return [DQMAFNetWork method:POST
				   withchildUrl:url
					  andparams:params
						   view:view
						 HUDMsg:@"手机/ID密码登录"
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
					  showError:true
				  networkstatus:true
			   checkLoginStatus:false];
}

/**
 找回密码
 post kuquke.yiyunrj.xyz/User/findPassword
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 mobile	sting	必需	无	用户的手机号
 */
+ (QMURLSessionTask *)POST_findPasswordParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	
	NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:postTokenString forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/User/findPassword"];
	
	return [DQMAFNetWork method:POST
				   withchildUrl:url
					  andparams:params
						   view:view
						 HUDMsg:@"找回密码"
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
					  showError:true
				  networkstatus:true
			   checkLoginStatus:false];
}
	
	
	
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
+ (QMURLSessionTask *)GET_getBakListParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
	NSString *token = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:token forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/task/getBakList",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"type",@"uid",@"num",@"page"]]];
	
	return [DQMAFNetWork method:GET
				   withchildUrl:url
					  andparams:nil
						   view:view
						 HUDMsg:@"进行中的任务"
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
 公告列表
 get kuquke.yiyunrj.xyz/index/noticeList
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 num	int	必需	10	每页数量
 page	int	必需	1	请求页数
 */
+ (QMURLSessionTask *)GET_noticeListParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	NSString *token = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:token forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"%@%@",@"http://kuquke.yiyunrj.xyz/index/noticeList",[QMSGeneralHelpers changeParamsToString:params keySortArray:@[@"time",@"token",@"num",@"page"]]];
	
	return [DQMAFNetWork method:GET
				   withchildUrl:url
					  andparams:nil
						   view:view
						 HUDMsg:@"公告列表"
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
 参加任务的时间
 post kuquke.yiyunrj.xyz/task/getJoinTime
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 tid	int	必需	1	任务id
 uid	int	必需	无	用户id
 */
+ (QMURLSessionTask *)POST_getJoinTime:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure{
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];

	NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:postTokenString forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/task/getJoinTime"];
	
	return [DQMAFNetWork method:POST
				   withchildUrl:url
					  andparams:params
						   view:view
						 HUDMsg:@"上传时间"
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
					  showError:true
				  networkstatus:true
			   checkLoginStatus:false];
}


/**
 任务（含专属状态变化）
 post kuquke.yiyunrj.xyz/task/addExclusiveTaskOk
 
 参数	类型	必需/可选	默认	描述
 time	int	必需	无	时间戳(用于判断请求是否超时)
 token	string	必需	无	确定来访者身份
 id	int	必需	1	任务id
 uid	int	必需	无	用户id
 applyid	int	必需	1	参加id，详情中会有返回
 nowstatus	int	必需	无	状态1.完成任务 6任务超时 2领取奖励
 */
+ (QMURLSessionTask *)POST_addExclusiveTaskOk:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	[params setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[params setValue:GET_USERDEFAULT(USERID) forKey:@"uid"];
	
	NSString *postTokenString = [QMSGeneralHelpers md5Codesign:params];
	[params setValue:postTokenString forKey:@"token"];
	
	NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/task/addExclusiveTaskOk"];
	
	return [DQMAFNetWork method:POST
				   withchildUrl:url
					  andparams:params
						   view:view
						 HUDMsg:@"任务(含专属状态变化)"
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
					  showError:true
				  networkstatus:true
			   checkLoginStatus:false];
}

@end
