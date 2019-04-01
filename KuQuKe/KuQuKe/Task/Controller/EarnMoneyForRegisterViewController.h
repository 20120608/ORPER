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

/** 类型 */
@property(nonatomic,copy) NSString          *nowtype;

@end

NS_ASSUME_NONNULL_END
