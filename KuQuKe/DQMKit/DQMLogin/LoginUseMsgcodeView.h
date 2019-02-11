//
//  LoginUseMsgcodeView.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/24.
//  Copyright © 2019 kuquke. All rights reserved.
//

//用短信登入
#import <UIKit/UIKit.h>
#import "JXCategoryListContainerView.h"

NS_ASSUME_NONNULL_BEGIN

@class LoginUseMsgcodeView;
@protocol LoginUseMsgcodeViewDelegate <NSObject>

@optional

- (void)LoginUseMsgcodeView:(LoginUseMsgcodeView *)loginUseMsgcodeView DidClickSendCodeButton:(UIButton *)button;

- (void)LoginUseMsgcodeView:(LoginUseMsgcodeView *)loginUseMsgcodeView DidClickLoginButton:(UIButton *)button;

@end

@interface LoginUseMsgcodeView : UIView <JXCategoryListContentViewDelegate>

@property (nonatomic,weak) id<LoginUseMsgcodeViewDelegate>  delegate;

/** 倒计时 */
@property(nonatomic,assign) int          countDown;




@end

NS_ASSUME_NONNULL_END
