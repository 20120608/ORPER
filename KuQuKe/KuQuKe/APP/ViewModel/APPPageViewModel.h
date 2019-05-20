//
//  APPPageViewModel.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/2/20.
//  Copyright © 2019 kuquke. All rights reserved.
//

//应用首页视图模型
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define NotificationName_APPViewController @"NotificationName_APPViewController"

@class APPViewController;
@interface APPPageViewModel : NSObject <UITableViewDelegate,UITableViewDataSource>

//当前视图控制器
@property (nonatomic, weak) APPViewController *currentVC;

//RACCommand操作：
//获取任务列表
@property (nonatomic, strong, readonly) RACCommand *requestVideoListCommand;


@end

NS_ASSUME_NONNULL_END
