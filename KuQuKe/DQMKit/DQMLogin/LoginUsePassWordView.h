//
//  LoginUsePassWordView.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/24.
//  Copyright © 2019 kuquke. All rights reserved.
//

//用密码登入
#import <UIKit/UIKit.h>
#import "JXCategoryListContainerView.h"

NS_ASSUME_NONNULL_BEGIN
@class LoginUsePassWordView;
@protocol LoginUsePassWordViewDelegate <NSObject>

@optional

- (void)LoginUsePassWordView:(LoginUsePassWordView *)loginUsePassWordView DidClickLoginButton:(UIButton *)button;

- (void)LoginUsePassWordView:(LoginUsePassWordView *)loginUsePassWordView DidClickRegisterButton:(UIButton *)button;

- (void)LoginUsePassWordView:(LoginUsePassWordView *)loginUsePassWordView DidClickSearchButton:(UIButton *)button;

@end

@interface LoginUsePassWordView : UIView <JXCategoryListContentViewDelegate>

@property (nonatomic,weak) id<LoginUsePassWordViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
