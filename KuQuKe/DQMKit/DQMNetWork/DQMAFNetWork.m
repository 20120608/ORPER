//
//  DQMAFNetWork.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/15.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMAFNetWork.h"
#import "DQMTabBarController.h"//分栏
#import "DQMLoginViewController.h"//登入页

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
           checkLoginStatus:(BOOL)checkLoginStatus {
  
//  单利
 DQMAFNetWork *netWork = [DQMAFNetWork sharedDQMAFNetWork];
  NSString *URLString;
  if ([childUrl rangeOfString:@"http"].location != NSNotFound) {
    URLString = childUrl;
  } else {
    URLString = [NSString stringWithFormat:@"%@%@",BASEURL,childUrl];
  }
  if (method == POST) {
    //进行post请求
    return [QMBaseNetworking postWithUrl:URLString params:params showView:view showmsg:msg success:^(id response) {
      NSDictionary *dataDic = kJSON(response);
      RequestStatusModel *reqsModel = [RequestStatusModel mj_objectWithKeyValues:dataDic];
      
      switch ([reqsModel.status intValue]) {
        case 200:
        {
          if (success) {
            success(reqsModel,dataDic);
          }
        }
          break;
        case 999://登入过期
        {
          if (checkLoginStatus) {
            [view makeToast:([reqsModel.msg length] == 0 ? @"登入状态失效!请重新登入。" : reqsModel.msg)];
          }
          if (checkLoginStatus && !netWork.loging) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              netWork.loging = true;
              UIViewController *visibleVc = [QMSGeneralHelpers visibleViewControllerInNavi];
              UIViewController *currentVc = [QMSGeneralHelpers topViewControllerInNavi];
              if (currentVc != nil && ![visibleVc isKindOfClass: [DQMLoginViewController class]]) {
                DQMLoginViewController *loginVc = [[DQMLoginViewController alloc] initWithTitle:@"登录"];
                [currentVc presentViewController:loginVc animated:true completion:^{
                  netWork.loging = false;
                }];
              }
            });
          } else {
            unknown(reqsModel,dataDic);
          }
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
    return [QMBaseNetworking getWithUrl:URLString params:params showView:view showmsg:msg success:^(id response) {
      NSDictionary *dataDic = kJSON(response);
      RequestStatusModel *reqsModel = [RequestStatusModel mj_objectWithKeyValues:dataDic];
      
      switch ([reqsModel.status intValue]) {
        case 200:
        {
          if (success) {
            success(reqsModel,dataDic);
          }
        }
          break;
        case 999://登入过期
        {
          if (checkLoginStatus) {
            [view makeToast:([reqsModel.msg length] == 0 ? @"登入状态失效!请重新登入。" : reqsModel.msg)];
          }
          if (checkLoginStatus && !netWork.loging) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              netWork.loging = true;
              UIViewController *visibleVc = [QMSGeneralHelpers visibleViewControllerInNavi];
              UIViewController *currentVc = [QMSGeneralHelpers topViewControllerInNavi];
              //NSLog(@"currentVc %@  currentVc %@",[currentVc class],[visibleVc class]);
              if (currentVc != nil && ![visibleVc isKindOfClass: [DQMLoginViewController class]]) {
                DQMLoginViewController *loginVc = [[DQMLoginViewController alloc] initWithTitle:@"登录"];
                [currentVc presentViewController:loginVc animated:true completion:^{
                  netWork.loging = false;
                }];
              }
            });
          } else {
            unknown(reqsModel,dataDic);
          }
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
  
 return [DQMAFNetWork method:method withchildUrl:childUrl andparams:params view:view HUDMsg:msg success:success unknown:unknown failure:failure graceTime:graceTime showHUD:showhud networkstatus:netstatus checkLoginStatus:false];
  
}



@end



@implementation RequestStatusModel


@end
