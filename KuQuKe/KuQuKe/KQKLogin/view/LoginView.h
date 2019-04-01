//
//  LoginView.h
//  KuQuKe
//
//  Created by hallelujah on 2019/3/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LoginView;
@protocol LoginViewDelegate <NSObject>

- (void)LoginView:(LoginView *)loginView loginButtonClick:(UIButton *)button;

- (void)LoginView:(LoginView *)loginView passWordChangeButtonClick:(UIButton *)button;

- (void)LoginView:(LoginView *)loginView registerButtonClick:(UIButton *)button;


@end

@interface LoginView : UIView

/** 代理 */
@property(nonatomic,weak) id<LoginViewDelegate>  delegate;

//当前视图控制器
@property (nonatomic, weak) UIViewController *currentVC;


@end

NS_ASSUME_NONNULL_END
