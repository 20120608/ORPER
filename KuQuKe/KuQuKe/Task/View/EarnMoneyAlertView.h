//
//  EarnMoneyAlertView.h
//  KuQuKe
//
//  Created by hallelujah on 2019/3/13.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EarnMoneyAlertView;
@protocol DQMAlertViewDelegate <NSObject>

- (void)EarnMoneyAlertViewClose:(EarnMoneyAlertView *)alertView;

- (void)EarnMoneyAlertView:(EarnMoneyAlertView *)alertView DidSelectBeginButton:(UIButton *)button;
- (void)EarnMoneyAlertView:(EarnMoneyAlertView *)alertView DidSelectCloseButton:(UIButton *)button;

@end

@interface EarnMoneyAlertView : UIView
/** 代理 */
@property(nonatomic,weak) id<DQMAlertViewDelegate>          delegate;

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
