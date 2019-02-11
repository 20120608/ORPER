//
//  RACMVVMViewModel.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/25.
//  Copyright © 2019 kuquke. All rights reserved.
//


//MVVM下的ViewModel
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define NotificationName_RefreshMainVC @"NotificationName_RefreshMainVC"

@interface RACMVVMViewModel : NSObject <UITableViewDelegate,UITableViewDataSource>

//当前视图控制器
@property (nonatomic, weak) UIViewController *currentVC;

//RACCommand操作：
//获取视频列表
@property (nonatomic, strong, readonly) RACCommand *requestVideoListCommand;


@end

NS_ASSUME_NONNULL_END
