//
//  EarnMoneyViewModel.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/2/26.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define NotificationName_EarnMoneyForRegisterViewController @"NotificationName_EarnMoneyForRegisterViewController"

@class EarnMoneyForRegisterViewController;

@interface EarnMoneyViewModel : NSObject

//当前视图控制器
@property (nonatomic, weak) EarnMoneyForRegisterViewController *currentVC;

//RACCommand操作：
//获取视频列表
@property (nonatomic, strong, readonly) RACCommand *requestVideoListCommand;



@end

NS_ASSUME_NONNULL_END
