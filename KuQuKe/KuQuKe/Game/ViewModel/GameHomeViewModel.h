//
//  GameHomeViewModel.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/2/21.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define NotificationName_GameViewController @"NotificationName_GameViewController"

@interface GameHomeViewModel : NSObject <UITableViewDelegate,UITableViewDataSource>

//当前视图控制器
@property (nonatomic, weak) UIViewController *currentVC;

//RACCommand操作：
//获取任务列表
@property (nonatomic, strong, readonly) RACCommand *requestVideoListCommand;

@end

NS_ASSUME_NONNULL_END
