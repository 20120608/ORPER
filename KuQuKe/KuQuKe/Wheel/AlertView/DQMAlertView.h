//
//  DQMAlertView.h
//  KuQuKe
//
//  Created by hallelujah on 2019/3/7.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DQMAlertView;
@protocol DQMAlertViewDelegate <NSObject>

- (void)DQMAlertView:(DQMAlertView *)alertView DidSelectInvitation:(NSString *)codeString;

- (void)DQMAlertView:(DQMAlertView *)alertView DidSelectIndexPath:(NSIndexPath *)indexPath;

@end

@interface DQMAlertView : UIView
/** 代理 */
@property(nonatomic,weak) id<DQMAlertViewDelegate>          delegate;

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
