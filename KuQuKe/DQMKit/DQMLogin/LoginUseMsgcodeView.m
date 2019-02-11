//
//  LoginUseMsgcodeView.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/24.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "LoginUseMsgcodeView.h"
#import <QuartzCore/QuartzCore.h>

@implementation LoginUseMsgcodeView


- (instancetype)init
{
  self = [super init];
  if (self) {
    
    UIImageView *phoneImageView =  ({
      UIImageView *imageView = [[UIImageView alloc] init];
      QMSetImage(imageView, @"icon_login_phone");
      [self addSubview: imageView];
      [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
      }];
      imageView;
    });
    UITextField *userNameTextField = ({
      UITextField *textField = [[UITextField alloc] init];
      [self addSubview:textField];
      textField.placeholder = @"手机号";
      textField.textColor = QMTextColor;
      textField.font = KQMFont(16);
      textField.returnKeyType = UIReturnKeyDone;
      textField.keyboardType = UIKeyboardTypeNumberPad;
      [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneImageView.mas_right).offset(5);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
      }];
      textField;
    });
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = QMBackColor;
    [userNameTextField addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.bottom.mas_equalTo(0);
      make.height.mas_equalTo(1);
    }];
    
    
    UIImageView *codeImageView =  ({
      UIImageView *imageView = [[UIImageView alloc] init];
      QMSetImage(imageView, @"icon_login_shield");
      [self addSubview: imageView];
      [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(phoneImageView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
      }];
      imageView;
    });
    UITextField *codeTextField = ({
      UITextField *textField = [[UITextField alloc] init];
      [self addSubview:textField];
      textField.placeholder = @"验证码";
      textField.textColor = QMTextColor;
      textField.font = KQMFont(16);
      textField.returnKeyType = UIReturnKeyDone;
      textField.keyboardType = UIKeyboardTypeNumberPad;
      [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(codeImageView.mas_right).offset(5);
        make.top.mas_equalTo(userNameTextField.mas_bottom);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
      }];
      textField;
    });
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = QMBackColor;
    [codeTextField addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.bottom.mas_equalTo(0);
      make.height.mas_equalTo(1);
    }];
    
    
    UIButton *sendCodeButton = ({
      UIButton *button = [[UIButton alloc] init];
      [self addSubview:button];
      QMSetButton(button, @"获取验证码", 18, nil, QMHexColor(@"bdbec0"), UIControlStateNormal);
      QMSetButton(button, @"获取验证码", 18, nil, DQMMainColor, UIControlStateSelected);
      [button addTarget:self action:@selector(sendCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(codeTextField.mas_right);
        make.height.mas_equalTo(codeTextField.mas_height);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(codeTextField.mas_top);
      }];
      button;
    });
    
    UIButton *LoginButton = ({
      UIButton *button = [[UIButton alloc] init];
      [self addSubview:button];
      QMSetButton(button, @"登录", 18, nil, UIColor.whiteColor, UIControlStateNormal);
      [button setBackgroundColor:QMHexColor(@"f0f0f2") forState:UIControlStateNormal];
      [button setBackgroundColor:DQMMainColor forState:UIControlStateSelected];
      [button addTarget:self action:@selector(LoginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(48);
        make.top.mas_equalTo(codeTextField.mas_bottom).offset(20);
      }];
      button;
    });
    
    
    UILabel *msgLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LoginButton.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
      }];
      label;
    });
    QMLabelFontColorText(msgLabel, @"未注册的手机号将自动创建一个新的账号", QMSubTextColor, 13);

    
    [RACObserve(self, countDown) subscribeNext:^(id  _Nullable x) {
      //设置倒计时
      int count = [x intValue];
      NSLog(@"订阅到的 定时器时间%d",count);
      if (count) {
        [sendCodeButton setTitle:[NSString stringWithFormat:@"等待%d秒",count] forState:UIControlStateNormal];
        [sendCodeButton setTitle:[NSString stringWithFormat:@"等待%d秒",count] forState:UIControlStateSelected];
      } else {
        [sendCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [sendCodeButton setTitle:@"获取验证码" forState:UIControlStateSelected];
      }
      [sendCodeButton setSelected: (count == 0 && [userNameTextField.text length] >= 6) ? true : false];
    }];
    
    //订阅用户名
    QMWeak(self);
    [[userNameTextField rac_textSignal] subscribeNext:^(NSString *x) {
     [sendCodeButton setSelected: (weakself.countDown == 0 && [x length] >= 6) ? true : false];
    }];
    
    
    //聚合用户名和密码的信号量
   RAC(LoginButton,selected) = [RACSignal combineLatest:@[userNameTextField.rac_textSignal, codeTextField.rac_textSignal] reduce:^id _Nullable(NSString *username, NSString *code){
     return @([username length] >= 6 && [code length] >= 4);
    }];
    
    
  }
  return self;
}







#pragma mark - touch event
- (void)sendCodeButtonClick:(UIButton *)sender {
  if (sender.isSelected) {
    if ([self.delegate respondsToSelector:@selector(LoginUseMsgcodeView:DidClickSendCodeButton:)]) {
      [self.delegate LoginUseMsgcodeView:self DidClickSendCodeButton:sender];
    }
  }
}

- (void)LoginButtonClick:(UIButton *)sender {
  if (sender.isSelected) {
    if ([self.delegate respondsToSelector:@selector(LoginUseMsgcodeView:DidClickLoginButton:)]) {
      [self.delegate LoginUseMsgcodeView:self DidClickLoginButton:sender];
    }
  }
}



#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
  return self;
}

- (void)listDidAppear {
  NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
  NSLog(@"%@", NSStringFromSelector(_cmd));
}


@end
