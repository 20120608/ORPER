//
//  MyMoneyAndStdentsView.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/9.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//个人中心余额 收益  学徒
#import <UIKit/UIKit.h>
#import "UserDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@class MyMoneyAndStdentsView;
@protocol MyMoneyAndStdentsViewDelegate <NSObject>

-(void)myMoneyAndStdentsView:(MyMoneyAndStdentsView *)menuView destVc:(Class)destVc didSelect:(NSInteger)index;

@end

@interface MyMoneyAndStdentsView : UIView

/** 代理 */
@property(nonatomic,weak) id<MyMoneyAndStdentsViewDelegate>          delegate;

/** 模型 */
@property(nonatomic,strong) UserDetailModel          *userModel;

@end

NS_ASSUME_NONNULL_END
