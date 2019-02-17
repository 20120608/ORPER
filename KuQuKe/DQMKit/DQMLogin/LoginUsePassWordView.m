//
//  LoginUsePassWordView.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/24.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "LoginUsePassWordView.h"

@implementation LoginUsePassWordView

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
    
    
    UIImageView *passWordImageView =  ({
      UIImageView *imageView = [[UIImageView alloc] init];
      QMSetImage(imageView, @"icon_login_password");
      [self addSubview: imageView];
      [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(phoneImageView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
      }];
      imageView;
    });
    UITextField *passWordTextField = ({
      UITextField *textField = [[UITextField alloc] init];
      [self addSubview:textField];
      textField.placeholder = @"密码";
      textField.textColor = QMTextColor;
      textField.font = KQMFont(16);
      [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passWordImageView.mas_right).offset(5);
        make.top.mas_equalTo(userNameTextField.mas_bottom);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
      }];
      textField;
    });
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = QMBackColor;
    [passWordTextField addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.bottom.mas_equalTo(0);
      make.height.mas_equalTo(1);
    }];
    
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
        make.top.mas_equalTo(passWordTextField.mas_bottom).offset(20);
      }];
      button;
    });
    
    NSMutableArray *buttonMArray = [[NSMutableArray alloc] init];
    UIButton *registerButton = ({
      UIButton *button = [[UIButton alloc] init];
      [self addSubview:button];
      QMSetButton(button, @"注册账号", 14, nil, QMTextColor, UIControlStateNormal);
      [button addTarget:self action:@selector(registerButtonClcik:) forControlEvents:UIControlEventTouchUpInside];
      button;
    });
    UIButton *searchButton = ({
      UIButton *button = [[UIButton alloc] init];
      [self addSubview:button];
      QMSetButton(button, @"找回密码", 14, nil, QMTextColor, UIControlStateNormal);
      [button addTarget:self action:@selector(searchButtonClcik:) forControlEvents:UIControlEventTouchUpInside];
      button;
    });
    [buttonMArray addObject:registerButton];
    [buttonMArray addObject:searchButton];
    [buttonMArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [buttonMArray mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(LoginButton.mas_bottom);
      make.height.mas_equalTo(40);
    }];
    

    //聚合用户名和密码的信号量
    RAC(LoginButton,selected) = [RACSignal combineLatest:@[userNameTextField.rac_textSignal, passWordTextField.rac_textSignal] reduce:^id _Nullable(NSString *username, NSString *password){
      return @([username length] >= 6 && [password length] >= 4);
    }];
    
  }
  return self;
}


#pragma mark - touch event
- (void)LoginButtonClick:(UIButton *)sender {
  if (sender.isSelected) {
    if ([self.delegate respondsToSelector:@selector(LoginUsePassWordView:DidClickLoginButton:)]) {
      [self.delegate LoginUsePassWordView:self DidClickLoginButton:sender];
    }
  }
}

- (void)registerButtonClcik:(UIButton *)sender {
  if ([self.delegate respondsToSelector:@selector(LoginUsePassWordView:DidClickRegisterButton:)]) {
    [self.delegate LoginUsePassWordView:self DidClickRegisterButton:sender];
  }
}

- (void)searchButtonClcik:(UIButton *)sender {
  if ([self.delegate respondsToSelector:@selector(LoginUsePassWordView:DidClickSearchButton:)]) {
    [self.delegate LoginUsePassWordView:self DidClickSearchButton:sender];
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
