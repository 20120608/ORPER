//
//  ChickSuccessAlertView.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//


//签到成功弹窗
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChickSuccessAlertView : UIView

/** 回调 */
@property(nonatomic,copy) void(^ChickSuccessAlertViewBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
