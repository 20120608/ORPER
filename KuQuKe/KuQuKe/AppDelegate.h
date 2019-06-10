//
//  AppDelegate.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/6.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskStatusTimer.h"
#import "APPTaskingModel.h"
#import "APPTaskModel.h"
#import "EarnMoneyDetailModel.h"

#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, WXApiDelegate,TencentSessionDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, strong) TaskStatusTimer *stateTimer;
	
//传入任务id和时间后开启定时器
- (void)startearnMoneyModelTimer:(EarnMoneyDetailModel *)earnModel;
	
- (void)removeTimeTask:(NSString *)taskid;


@end

