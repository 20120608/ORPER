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
+(QMURLSessionTask *)GET_PDWSearchBookWithBookName:(NSDictionary *)params AndView:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
  
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


/**
 接口测试demo
 */
+(QMURLSessionTask *)GET_KuqukeWithParams:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/index/demo/%@/%@",params[@"time"],params[@"token"]];
	
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
 信息接口统一
 */
+(QMURLSessionTask *)GET_getIndexConfig:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure {
	
	NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/index/getIndexConfig/%@/%@/%@",params[@"time"],params[@"token"],params[@"uid"]];
	
	return [DQMAFNetWork method:GET
				   withchildUrl:url
					  andparams:nil
						   view:view
						 HUDMsg:@"数据统一接口"
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
+(QMURLSessionTask *)POST_Kuqukelogin:(NSDictionary *)params View:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure  {
	
//	NSString *url = [NSString stringWithFormat:@"http://kuquke.yiyunrj.xyz/User/login/%@/%@/%@/%@",params[@"time"],params[@"token"],params[@"deviceid"],params[@"phonetype"]];
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






@end
