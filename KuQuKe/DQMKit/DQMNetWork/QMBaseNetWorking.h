//
//  QMBaseNetWorking.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/15.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, QMNetworkStatus){
  StatusUnknown           = -1,   //未知网络
  StatusNotReachable      = 0,    //没有网络
  StatusReachableViaWWAN  = 1,    //手机自带网络
  StatusReachableViaWiFi  = 2     //wifi
};


/**
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel， 取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume， 继续任务
 */
typedef NSURLSessionTask QMURLSessionTask;

//定义成功回调
typedef void( ^ QMResponseSuccess)(id response);
//定义失败回调
typedef void( ^ QMResponseFail)(NSError *error);
//定义上传进度回调
typedef void( ^ QMUploadProgress)(int64_t bytesProgress,
                                  int64_t totalBytesProgress);
//定义下载进度回调
typedef void( ^ QMDownloadProgress)(int64_t bytesProgress,
                                    int64_t totalBytesProgress);





@interface QMBaseNetworking : NSObject

/**
 *  单例
 *
 */
+ (QMBaseNetworking *)sharedQMBaseNetWorking;

/**
 *  获取网络
 */
@property (nonatomic,assign)QMNetworkStatus networkStats;

/**
 *  开启网络监测
 */
+ (void)startMonitoring;

/**
 *  get请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 *  @param showHUD 是否显示HUD
 */
+(QMURLSessionTask *)getWithUrl:(NSString *)url
                         params:(NSDictionary *)params
                       showView:(UIView *)view
                        showmsg:(NSString *)msg
                        success:(QMResponseSuccess)success
                           fail:(QMResponseFail)fail
                      graceTime:(NSTimeInterval)graceTime
                        showHUD:(BOOL)showHUD
                  networkstatus:(BOOL)shownetwork;

/**
 *  post请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 *  @param showHUD 是否显示HUD
 */
+(QMURLSessionTask *)postWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                        showView:(UIView *)view
                         showmsg:(NSString *)msg
                         success:(QMResponseSuccess)success
                            fail:(QMResponseFail)fail
                       graceTime:(NSTimeInterval)graceTime
                         showHUD:(BOOL)showHUD
                   networkstatus:(BOOL)shownetwork;

/**
 *  上传图片方法
 *
 *  @param image      上传的图片
 *  @param url        请求连接，根路径
 *  @param filename   图片的名称(如果不传则以当时间命名)
 *  @param name       上传图片时填写的图片对应的参数
 *  @param params     参数
 *  @param progress   上传进度
 *  @param success    请求成功返回数据
 *  @param fail       请求失败
 *  @param showHUD    是否显示HUD
 */
+(QMURLSessionTask *)uploadWithImage:(UIImage *)image
                                 url:(NSString *)url
                            filename:(NSString *)filename
                                name:(NSString *)name
                              params:(NSDictionary *)params
                            showView:(UIView *)view
                             showmsg:(NSString *)msg
                            progress:(QMUploadProgress)progress
                             success:(QMResponseSuccess)success
                                fail:(QMResponseFail)fail
                             showHUD:(BOOL)showHUD
                       networkstatus:(BOOL)shownetwork;

/**
 *  下载文件方法
 *
 *  @param url           下载地址
 *  @param saveToPath    文件保存的路径,如果不传则保存到Documents目录下，以文件本来的名字命名
 *  @param progressBlock 下载进度回调
 *  @param success       下载完成
 *  @param fail          失败
 *  @param showHUD       是否显示HUD
 *  @return 返回请求任务对象，便于操作
 */
+ (QMURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             showView:(UIView *)view
                              showmsg:(NSString *)msg
                             progress:(QMDownloadProgress)progressBlock
                              success:(QMResponseSuccess)success
                              failure:(QMResponseFail)fail
                              showHUD:(BOOL)showHUD
                        networkstatus:(BOOL)shownetwork;



@end
