//
//  QMBaseNetWorking.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/15.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "QMBaseNetWorking.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"


static NSMutableArray *tasks;
@implementation QMBaseNetworking


/**
 创建单利
 */
+ (QMBaseNetworking *)sharedQMBaseNetWorking
{
  static QMBaseNetworking *handler = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    handler = [[QMBaseNetworking alloc] init];
  });
  return handler;
}


/**
 创建管理数组单利
 */
+(NSMutableArray *)tasks{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    tasks = [[NSMutableArray alloc] init];//请求任务的数组 用于取消任务
  });
  return tasks;
}


/**
 get请求方法,block回调

 @param url 请求连接，根路径
 @param params 参数
 @param view 显示在那个View上
 @param msg hud消息
 @param success 请求成功返回数据
 @param fail 请求失败
 @param showHUD  是否显示HUD
 @param shownetwork 网络状态
 */
+(QMURLSessionTask *)getWithUrl:(NSString *)url
                         params:(NSDictionary *)params
                       showView:(UIView *)view
                        showmsg:(NSString *)msg
                        success:(QMResponseSuccess)success
                           fail:(QMResponseFail)fail
                      graceTime:(NSTimeInterval)graceTime
                        showHUD:(BOOL)showHUD
                  networkstatus:(BOOL)shownetwork {
  return [self baseRequestType:1 url:url params:params showView:view showmsg:msg success:success fail:fail graceTime:graceTime showHUD:showHUD networkstatus:shownetwork];
}
/**
 post请求方法,block回调
 
 @param url 请求连接，根路径
 @param params 参数
 @param view 显示在那个View上
 @param msg hud消息
 @param success 请求成功返回数据
 @param fail 请求失败
 @param showHUD  是否显示HUD
 @param shownetwork 网络状态
 */
+(QMURLSessionTask *)postWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                        showView:(UIView *)view
                         showmsg:(NSString *)msg
                         success:(QMResponseSuccess)success
                            fail:(QMResponseFail)fail
                       graceTime:(NSTimeInterval)graceTime
                         showHUD:(BOOL)showHUD
                   networkstatus:(BOOL)shownetwork {
  return [self baseRequestType:2 url:url params:params showView:view showmsg:msg success:success fail:fail graceTime:graceTime showHUD:showHUD networkstatus:shownetwork];
}



/**
 get post都走这里
 */
+(QMURLSessionTask *)baseRequestType:(NSUInteger)type
                                 url:(NSString *)url
                              params:(NSDictionary *)params
                            showView:(UIView *)view
                             showmsg:(NSString *)msg
                             success:(QMResponseSuccess)success
                                fail:(QMResponseFail)fail
                           graceTime:(NSTimeInterval)graceTime
                             showHUD:(BOOL)showHUD
                       networkstatus:(BOOL)shownetwork
{
  NSLog(@"请求地址----%@\n    请求参数----%@",url,params);
  if (url==nil) {
    return nil;
  }
  
  //全局遮罩
  MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
  if (showHUD==true || showHUD == YES) {
    msg =  msg == nil ? @"loding..." :msg;
    [view addSubview:hud];
    hud.detailsLabel.text = msg;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = QMHexColor(@"4D4D4D");
    hud.graceTime = graceTime;//宽恕时间
    hud.minShowTime = 0.5;//最短显示时间
    hud.removeFromSuperViewOnHide = true;//从图层关系中移除
    [hud showAnimated:true];
  }
  
  //检查地址中是否有中文
  NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
  AFHTTPSessionManager *manager = [self getAFManager];
  //请求头设置sessionId  token
  NSString *sessionId = [kUserDefaults objectForKey:@"sessionId"];
  if (sessionId != nil) {
    [manager.requestSerializer setValue:sessionId forHTTPHeaderField:kHTTPHeaderField];
  }
  //设置Header
  if(GET_USERDEFAULT(USER_TOKEN) != nil){
    [manager.requestSerializer setValue:GET_USERDEFAULT(USER_TOKEN) forHTTPHeaderField:@"token"];
  }
	
	[manager.requestSerializer setValue: [NSString stringWithFormat:@"Bearer %@", GET_USERDEFAULT(USER_TOKEN)] forHTTPHeaderField:@"Authorization"];
	
  QMURLSessionTask *sessionTask = nil;
  
  if (type == 1) {
    //get请求的创建
    sessionTask = [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
      
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      if (showHUD==YES || showHUD == true) {
        [hud hideAnimated:true];
      }
      if (success) {
        success(responseObject);
      }
      [[self tasks] removeObject:sessionTask];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      NSLog(@"error=%@",error);
      if (showHUD==YES || showHUD == true) {
        [hud hideAnimated:true];
      }
      if (fail) {
        fail(error);
      }
      [[self tasks] removeObject:sessionTask];
    }];
    
    
  } else {
    
    //post请求的创建
    sessionTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
      
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      if (showHUD == YES || showHUD == true) {
        [hud hideAnimated:true];
      }
      if (success) {
        success(responseObject);
      }
      [[self tasks] removeObject:sessionTask];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      NSLog(@"error=%@",error);
      if ( showHUD == YES || showHUD == true) {
        [hud hideAnimated:true];
      }
      if (fail) {
        //网络检查
        if ([QMBaseNetworking sharedQMBaseNetWorking].networkStats == StatusNotReachable && shownetwork) {
          [view makeToast:@"网络错误!"];
        } else {
          fail(error);
        }
      }
      [[self tasks] removeObject:sessionTask];
    }];
    
    
  }
  
  if (sessionTask) {
    [[self tasks] addObject:sessionTask];
  }
  return sessionTask;
}





/**
 上传图片

 @param image 图片文件
 @param url 上传路径
 @param filename 文件名
 @param name 名称
 @param params 参数
 @param view 视图
 @param msg hud消息
 @param progress 进度
 @param success 成功回调
 @param fail 失败回调
 @param showHUD 是否显示hud
 @param shownetwork 是否展示网络状态
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
                       networkstatus:(BOOL)shownetwork
{
  
  NSLog(@"请求地址----%@\n    请求参数----%@",url,params);
  if (url==nil) {
    return nil;
  }
  
  if (showHUD==YES || showHUD == true) {
    
  }
  
  //检查地址中是否有中文
  NSString *urlStr = [NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
  
  AFHTTPSessionManager *manager = [self getAFManager];
  [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];

  __block QMURLSessionTask *sessionTask = [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    //压缩图片
    NSData *imageData = UIImageJPEGRepresentation(image, 0.15);
    if (imageData.length >= 1000000) { imageData = UIImageJPEGRepresentation(image, 0.1);}
    NSString *imageFileName = filename;
    if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
      NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
      formatter.dateFormat = @"yyyyMMddHHmmss";
      NSString *str = [formatter stringFromDate:[NSDate date]];
      imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
    }
    
    // 上传图片，以文件流的格式
    [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
    
  } progress:^(NSProgress * _Nonnull uploadProgress) {
    NSLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
    if (progress) {
      progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
    }
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"上传图片成功 = %@", responseObject);
    if (showHUD==YES || showHUD == true) {

    }
    if (success) {
      success(responseObject);
    }
    
    [[self tasks] removeObject:sessionTask];
    
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"error=%@",error);
    if ( showHUD == YES || showHUD == true) {
    }
    if (fail) {
      //网络检查
      if ([QMBaseNetworking sharedQMBaseNetWorking].networkStats == StatusNotReachable && shownetwork) {
        [view makeToast:@"网络错误！"];
      } else {
        fail(error);
      }
    }
    
    [[self tasks] removeObject:sessionTask];
    
  }];
  
  
  if (sessionTask) {
    [[self tasks] addObject:sessionTask];
  }
  
  return sessionTask;
  
}







/**
 下载文件
 */
+ (QMURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             showView:(UIView *)view
                              showmsg:(NSString *)msg
                             progress:(QMDownloadProgress)progressBlock
                              success:(QMResponseSuccess)success
                              failure:(QMResponseFail)fail
                              showHUD:(BOOL)showHUD
                        networkstatus:(BOOL)shownetwork {
  NSLog(@"请求地址----%@\n    ",url);
  if (url==nil) {
    return nil;
  }
  
  MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
  if (showHUD==YES) {
    [view addSubview:hud];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = QMHexColor(@"4D4D4D");
    hud.graceTime = 3;
    [hud showAnimated:true];
  }
  
  NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
  AFHTTPSessionManager *manager = [self getAFManager];
  
  QMURLSessionTask *sessionTask = nil;
  
  sessionTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
    NSLog(@"下载进度--%.1f",1.0 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
    //回到主线程刷新UI
    dispatch_async(dispatch_get_main_queue(), ^{
      if (progressBlock) {
        progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
      }
    });
    
  } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
    if (!saveToPath) {
      
      NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
      NSLog(@"默认路径--%@",downloadURL);
      return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
      
    }else{
      return [NSURL fileURLWithPath:saveToPath];
      
    }
    
  } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
    NSLog(@"下载文件成功");
    if (showHUD==YES || showHUD == true) {
      [hud hideAnimated:true];
      //            [MBProgressHUD hideHUDForView:view animated:false];
    }
    [[self tasks] removeObject:sessionTask];
    
    if (error == nil) {
      if (success) {
        success([filePath path]);//返回完整路径
      }
      
    } else {
      if (fail) {
        fail(error);
      }
    }
    
    
    
  }];
  
  //开始启动任务
  [sessionTask resume];
  if (sessionTask) {
    [[self tasks] addObject:sessionTask];
  }
  
  return sessionTask;
  
  
}

/**
 AFNetworking的一些参数设置
 */
+(AFHTTPSessionManager *)getAFManager{
  [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
  
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  
  manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
  manager.requestSerializer.timeoutInterval=10;
  manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                            @"text/html",
                                                                            @"text/json",
                                                                            @"text/plain",
                                                                            @"text/javascript",
                                                                            @"text/xml",
                                                                            @"image/*"]];
  return manager;
  
}

#pragma makr - 开始监听网络连接

+ (void)startMonitoring {
  // 1.获得网络监控的管理者
  AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
  // 2.设置网络状态改变后的处理
  [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    // 当网络状态改变了, 就会调用这个block
    switch (status) {
      case AFNetworkReachabilityStatusUnknown: // 未知网络
        NSLog(@"未知网络");
        [QMBaseNetworking sharedQMBaseNetWorking].networkStats = StatusUnknown;
        break;
      case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
        NSLog(@"没有网络");
        [QMBaseNetworking sharedQMBaseNetWorking].networkStats = StatusNotReachable;
        break;
      case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
        NSLog(@"手机自带网络");
        [QMBaseNetworking sharedQMBaseNetWorking].networkStats = StatusReachableViaWWAN;
        break;
      case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
        NSLog(@"WIFI");
        [QMBaseNetworking sharedQMBaseNetWorking].networkStats = StatusReachableViaWiFi;
        NSLog(@"WIFI--%lu",(unsigned long)[QMBaseNetworking sharedQMBaseNetWorking].networkStats);
        break;
    }
  }];
  [mgr startMonitoring];
}


/**
 字符串UTF-8转码
 */
+(NSString *)strUTF8Encoding:(NSString *)str{
  return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
}
@end
