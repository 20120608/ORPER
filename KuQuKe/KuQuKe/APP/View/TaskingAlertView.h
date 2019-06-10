//
//  TaskingAlertView.h
//  KuQuKe
//
//  Created by Xcoder on 2019/4/22.
//  Copyright © 2019 kuquke. All rights reserved.
//
//进行中的任务弹窗

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class EarnMoneyDetailModel;
@class APPViewController;
@class MyExclusiveTaskViewController;
@interface TaskingAlertView : UIView

/** 任务模型 */
@property(nonatomic,strong) EarnMoneyDetailModel *earnMoneyModel;

//当前视图控制器
@property (nonatomic, weak) APPViewController *currentVC;
@property (nonatomic, weak) MyExclusiveTaskViewController *currentVC2;


- (void)showAnimation;

@end

NS_ASSUME_NONNULL_END
