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
          if (checkLoginStatus) {
            UINavigationController *nav = [UIApplication sharedApplication].keyWindow.rootViewController.tabBarController.selectedViewController;
            UIViewController *currentVc = (UIViewController *)[nav.viewControllers lastObject];
            if (currentVc != nil) {
              [currentVc.navigationController popViewControllerAnimated:true];
            }
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
          if (checkLoginStatus) {
            UINavigationController *nav = [UIApplication sharedApplication].keyWindow.rootViewController.tabBarController.selectedViewController;
            UIViewController *currentVc = (UIViewController *)[nav.viewControllers lastObject];
            if (currentVc != nil) {
              [currentVc.navigationController popViewControllerAnimated:true];
            }
          }
        }
          break;
        default://不成功,也不是登入过期
        {
          [view makeToast:([reqsModel.msg length] == 0 ? @"登入状态失效!请重新登入。" : reqsModel.msg)];
          if (checkLoginStatus) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              UIViewController *currentVc = [QMSGeneralHelpers currentViewController];
              if (currentVc != nil) {
                DQMLoginViewController *loginVc = [[DQMLoginViewController alloc] initWithTitle:@"登录"];
                [currentVc presentViewController:loginVc animated:true completion:nil];
              }
            });
          }
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
