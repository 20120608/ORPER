//
//  MyExclusiveTaskViewModel.h
//  KuQuKe
//
//  Created by hallelujah on 2019/3/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//专属任务视图模型
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define NotificationName_MyExclusiveTaskViewController @"NotificationName_MyExclusiveTaskViewController"

@interface MyExclusiveTaskViewModel : NSObject <UITableViewDelegate,UITableViewDataSource>

//当前视图控制器
@property (nonatomic, weak) UIViewController *currentVC;

//RACCommand操作：
//获取任务列表
@property (nonatomic, strong, readonly) RACCommand *requestVideoListCommand;


@end

NS_ASSUME_NONNULL_END
