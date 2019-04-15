//
//  TaskProgressViewModel.h
//  KuQuKe
//
//  Created by Xcoder on 2019/4/15.
//  Copyright © 2019 kuquke. All rights reserved.
//
//任务进度列表

#import <Foundation/Foundation.h>

#define NotificationName_TaskProgressViewController @"NotificationName_TaskProgressViewController"

NS_ASSUME_NONNULL_BEGIN

@interface TaskProgressViewModel : NSObject <UITableViewDelegate,UITableViewDataSource>

	//当前视图控制器
	@property (nonatomic, weak) UIViewController *currentVC;
	
	//RACCommand操作：
	//获取视频列表
	@property (nonatomic, strong, readonly) RACCommand *requestVideoListCommand;

	
@end

NS_ASSUME_NONNULL_END
