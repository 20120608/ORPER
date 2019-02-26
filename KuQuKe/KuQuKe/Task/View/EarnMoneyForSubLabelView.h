//
//  EarnMoneyForSubLabelView.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//


//用来展示子标题的第一个View  一个图标和N个标签
#import <UIKit/UIKit.h>
#import "EarnMoneyDetailModel.h"//模型

NS_ASSUME_NONNULL_BEGIN

@interface EarnMoneyForSubLabelView : UIView

/** 数据 */
@property(nonatomic,strong) EarnMoneyDetailModel          *earnModel;


@end

NS_ASSUME_NONNULL_END
