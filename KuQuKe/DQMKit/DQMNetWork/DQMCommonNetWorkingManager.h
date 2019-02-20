//
//  DQMCommonNetWorkingManager.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/26.
//  Copyright © 2019 kuquke. All rights reserved.
//

//登入、注册、找回等常见接口  或者自己的测试等接口在这
#import <Foundation/Foundation.h>

@interface DQMCommonNetWorkingManager : NSObject

/**
 创建单利
 */
+ (instancetype)sharedInstance;

/**
 漂读网根据书名找书列表
 
 @return 书籍列表
 */
+ (QMURLSessionTask *)GET_PDWSearchBookWithBookName:(NSDictionary *)params AndView:(UIView *)view success:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))success unknown:(void(^)(RequestStatusModel *reqsModel,NSDictionary *dataDic))unknown failure:(void(^)(NSError *error))failure;



@end
