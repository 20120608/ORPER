//
//  DQMCommonNetWorkingManager.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/26.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMCommonNetWorkingManager.h"

@implementation DQMCommonNetWorkingManager


/**
 单利
 */
+ (instancetype)sharedInstance {
  static DQMCommonNetWorkingManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}


/**
 漂读网根据书名找书列表
 
 @return 书籍列表
 */
+ (QMURLSessionTask *)GET_PDWSearchBookWithBookName:(NSDictionary *)params AndView:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  
  return [DQMAFNetWork method:GET
                 withchildUrl:@"https://mobile.piaoduwang.cn/gridread/book/gridList"
                    andparams:params
                         view:view
                       HUDMsg:@"获取书籍列表"
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
