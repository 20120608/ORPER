//
//  EarnMoneyForRegisterViewController.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

//注册赚钱
//   pod 'MWPhotoBrowser', '~> 2.1.2'
#import "DQMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EarnMoneyForRegisterViewController : DQMBaseViewController

/** 需要的任务ID */
@property(nonatomic,copy) NSString          *taskID;
/** 参加的任务的ID 点击开始任务才会有 */
@property(nonatomic,copy) NSString          *applyid;


@end

NS_ASSUME_NONNULL_END
