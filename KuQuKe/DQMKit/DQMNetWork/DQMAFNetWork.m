//
//  DQMAFNetWork.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/15.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMAFNetWork.h"



@implementation DQMAFNetWork


/** 单利 */
+ (DQMAFNetWork *)sharedDQMAFNetWork
{
  static DQMAFNetWork *handler = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    handler = [[DQMAFNetWork alloc] init];
  });
  return handler;
}

/**
 基本请求
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
networkstatus:(BOOL)netstatus {
  
  if (method == POST) {
    //进行post请求
   return [QMBaseNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",BASEURL,childUrl] params:params showView:view showmsg:msg success:^(id response) {
      NSDictionary *dataDic = kJSON(response);
      RequestStatusModel *reqsModel = [RequestStatusModel mj_objectWithKeyValues:dataDic];
      
      switch ([reqsModel.code intValue]) {
        case 200:
        {
          if (success) {
            success(reqsModel,dataDic);
          }
        }
          break;
        case 999://登入过期
        {
          [view makeToast:([reqsModel.msg length] == 0 ? @"登入状态失效!请重新登入。" : reqsModel.msg)];
          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //            PDLoginViewController *loginVC = [[PDLoginViewController alloc] init];
            //            [viewController presentViewController:loginVC animated:true completion:^{
            //
            //            }];
          });
        }
          break;
        default://不成功,也不是登入过期
        {
          unknown(reqsModel,dataDic);
        }
          break;
      }
      
    } fail:^(NSError *error) {
      if (failure) {
        failure(error);
      }
    } graceTime:graceTime showHUD:showhud networkstatus:netstatus];
    
  } else if (method == GET) {
    //进行get请求
    return [QMBaseNetworking getWithUrl:[NSString stringWithFormat:@"%@%@",BASEURL,childUrl] params:params showView:view showmsg:msg success:^(id response) {
      NSDictionary *dataDic = kJSON(response);
      RequestStatusModel *reqsModel = [RequestStatusModel mj_objectWithKeyValues:dataDic];
      
      switch ([reqsModel.code intValue]) {
        case 200:
        {
          if (success) {
            success(reqsModel,dataDic);
          }
        }
          break;
        case 999://登入过期
        {
          [view makeToast:([reqsModel.msg length] == 0 ? @"登入状态失效!请重新登入。" : reqsModel.msg)];
          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //            PDLoginViewController *loginVC = [[PDLoginViewController alloc] init];
            //            [viewController presentViewController:loginVC animated:true completion:^{
            //
            //            }];
          });
        }
          break;
        default://不成功,也不是登入过期
        {
          unknown(reqsModel,dataDic);
        }
          break;
      }
      
    } fail:^(NSError *error) {
      if (failure) {
        failure(error);
      }
    } graceTime:graceTime showHUD:showhud networkstatus:netstatus];
    
  }
  
  NSAssert(NO, @"get post没有传参");
  return nil;
}



@end



@implementation RequestStatusModel


@end
