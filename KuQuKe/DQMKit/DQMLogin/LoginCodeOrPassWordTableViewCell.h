//
//  LoginCodeOrPassWordTableViewCell.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/24.
//  Copyright © 2019 kuquke. All rights reserved.
//

//免密登入和密码登入
#import <UIKit/UIKit.h>
//两个内容视图
#import "LoginUseMsgcodeView.h"
#import "LoginUsePassWordView.h"
NS_ASSUME_NONNULL_BEGIN

@class LoginCodeOrPassWordTableViewCell;
@protocol LoginCodeOrPassWordTableViewCellDelegate <NSObject>

@optional

- (void)LoginCodeOrPassWordTableViewCell:(LoginCodeOrPassWordTableViewCell *)cell LoginUseMsgcodeView:(LoginUseMsgcodeView *)loginUseMsgcodeView DidClickSendCodeButton:(UIButton *)button;

- (void)LoginCodeOrPassWordTableViewCell:(LoginCodeOrPassWordTableViewCell *)cell LoginUseMsgcodeView:(LoginUseMsgcodeView *)loginUseMsgcodeView DidClickLoginButton:(UIButton *)button;

- (void)LoginCodeOrPassWordTableViewCell:(LoginCodeOrPassWordTableViewCell *)cell LoginUsePassWordView:(LoginUsePassWordView *)loginUsePassWordView DidClickLoginButton:(UIButton *)button;

- (void)LoginCodeOrPassWordTableViewCell:(LoginCodeOrPassWordTableViewCell *)cell LoginUsePassWordView:(LoginUsePassWordView *)loginUsePassWordView DidClickRegisterButton:(UIButton *)button;

- (void)LoginCodeOrPassWordTableViewCell:(LoginCodeOrPassWordTableViewCell *)cell LoginUsePassWordView:(LoginUsePassWordView *)loginUsePassWordView DidClickSearchButton:(UIButton *)button;


@end

@interface LoginCodeOrPassWordTableViewCell : UITableViewCell

@property (nonatomic,weak) id<LoginCodeOrPassWordTableViewCellDelegate> delegate;

/** 倒计时 */
@property(nonatomic,assign) int          countDown;

/** 固定高度 0则自适应 */
@property (nonatomic,assign) CGFloat     fixedCellHeight;

/** 登录按钮动画效果 */
@property(nonatomic,assign) BOOL          loginStatus;


+(LoginCodeOrPassWordTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight;




@end

NS_ASSUME_NONNULL_END
