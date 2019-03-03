//
//  MyBalanceCheckOutView.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/13.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//银行提现
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MyBalanceCheckOutView;
@protocol MyBalanceCheckOutViewDelegate <NSObject>

-(void)MyBalanceCheckOutView:(MyBalanceCheckOutView *)checkOutView didSelected:(NSInteger)index;

@end

@interface MyBalanceCheckOutView : UIView

/** 价格 */
@property(nonatomic,assign) NSString          *canUseMoney;

/** 代理 */
@property(nonatomic,weak) id<MyBalanceCheckOutViewDelegate>          delegete;

//添加时候的动画
-(void)showAnimation;

@end

NS_ASSUME_NONNULL_END
