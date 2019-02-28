//
//  CheckOutAliPayViewController.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/13.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//兑换支付宝
#import "DQMBaseViewController.h"
#import "CheckOutCollectionView.h"//选择金额

NS_ASSUME_NONNULL_BEGIN

@interface CheckOutAliPayViewController : DQMBaseViewController

/** 类型 */
@property(nonatomic,assign) CheckOutThreePartType checkOutThreePartType;

@end

NS_ASSUME_NONNULL_END
