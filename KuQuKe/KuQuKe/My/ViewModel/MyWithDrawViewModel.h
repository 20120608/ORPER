//
//  MyWithDrawViewModel.h
//  KuQuKe
//
//  Created by hallelujah on 2019/3/3.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//支出视图模型
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define NotificationName_MyWithdrawViewController @"NotificationName_MyWithdrawViewController"

@interface MyWithDrawViewModel : NSObject <UITableViewDelegate,UITableViewDataSource>

//当前视图控制器
@property (nonatomic, weak) UIViewController *currentVC;

//RACCommand操作：
//获取视频列表
@property (nonatomic, strong, readonly) RACCommand *requestVideoListCommand;

@end

NS_ASSUME_NONNULL_END
