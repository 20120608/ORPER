//
//  UserMessageInputView.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "UserMessageInputView.h"

@interface UserMessageInputView ()


@end

@implementation UserMessageInputView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    /** 姓名 */
    self.nameLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      QMLabelFontColorText(label, @"姓名", QMTextColor, 15);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(70, 44));
      }];
      label;
    });
    
    /** 电话 */
    self.phoneLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      QMLabelFontColorText(label, @"手机号", QMTextColor, 15);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.top.mas_equalTo(_nameLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(70, 44));
      }];
      label;
    });
    
    /** 验证码 */
    self.codeLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      QMLabelFontColorText(label, @"验证码", QMTextColor, 15);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.top.mas_equalTo(_phoneLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(70, 44));
      }];
      label;
    });
    
    /** 姓名 */
    self.nameTextFiled = ({
      UITextField *textField = [[UITextField alloc] init];
      [self addSubview:textField];
      textField.placeholder = @"注册所用姓名";
      textField.textColor = QMTextColor;
      textField.font = KQMFont(16);
      [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_right).offset(10);
        make.top.mas_equalTo(_nameLabel.mas_top);
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.height.mas_equalTo(40);
      }];
      textField;
    });
    UIView *line1 = [[UIView alloc] init];
    [_nameTextFiled addSubview:line1];
    line1.backgroundColor = QMBackColor;
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.bottom.mas_equalTo(0);
      make.height.mas_equalTo(1);
    }];
    
    /** 电话 */
    self.phoneTextFiled = ({
      UITextField *textField = [[UITextField alloc] init];
      [self addSubview:textField];
      textField.placeholder = @"注册所用的手机号";
      textField.textColor = QMTextColor;
      textField.font = KQMFont(16);
      [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_right).offset(10);
        make.top.mas_equalTo(_phoneLabel.mas_top);
        make.right.mas_equalTo(self.mas_right).offset(-150);
        make.height.mas_equalTo(40);
      }];
      textField;
    });
    UIView *line2 = [[UIView alloc] init];
    [self addSubview:line2];
    line2.backgroundColor = QMBackColor;
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(_phoneLabel.mas_right).offset(10);
      make.top.mas_equalTo(_phoneLabel.mas_bottom);
      make.right.mas_equalTo(self.mas_right).offset(-15);
      make.height.mas_equalTo(1);
    }];
    
    /** 验证码 */
    self.codeTextFiled = ({
      UITextField *textField = [[UITextField alloc] init];
      [self addSubview:textField];
      textField.placeholder = @"注册所用姓名";
      textField.textColor = QMTextColor;
      textField.font = KQMFont(16);
      [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_right).offset(10);
        make.top.mas_equalTo(_codeLabel.mas_top);
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.height.mas_equalTo(40);
      }];
      textField;
    });
    UIView *line3 = [[UIView alloc] init];
    [_codeTextFiled addSubview:line3];
    line3.backgroundColor = QMBackColor;
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.bottom.mas_equalTo(0);
      make.height.mas_equalTo(1);
    }];
    
    /** 验证码 */
    self.codeButton = ({
      UIButton *button = [[UIButton alloc] init];
      [self addSubview:button];
      QMSetButton(button, @"获取验证码", 15, nil, QMTextColor, UIControlStateNormal);
      QMViewBorderRadius(button, 4, 1, QMSubTextColor);
      [button addTarget:self action:@selector(codeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.mas_equalTo(_phoneTextFiled.mas_top);
      }];
      button;
    });
    
    
    /** 上传截图 */
    UILabel *msgLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.top.mas_equalTo(_codeLabel.mas_bottom);
        make.width.mas_equalTo(kScreenWidth);//撑开宽
        make.size.mas_equalTo(CGSizeMake(80, 44));
      }];
      label;
    });
    QMLabelFontColorText(msgLabel, @"上传截图", QMTextColor, 15);
    
    /** 提交的图片数组 */
    self.printScreensView = ({
      UIView *view = [[UIView alloc] init];
      [self addSubview: view];
      QMViewBorderRadius(view, 8, 0, QMBackColor);
      view.backgroundColor = QMBackColor;
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.top.mas_equalTo(msgLabel.mas_bottom).offset(12);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-24, (kScreenWidth-44)/4 + 20));//后期改成子视图撑高
      }];
      view;
    });
    
    
	  /** 提交审核按钮 */
	  self.putButton = ({
		  UIButton *button = [[UIButton alloc] init];
		  [self addSubview:button];
		  QMSetButton(button, @"提交审核", 16, nil, UIColor.whiteColor, UIControlStateNormal);
		  QMViewBorderRadius(button, 4, 0, QMBlueColor);
		  button.backgroundColor = QMBlueColor;
		  [button addTarget:self action:@selector(beginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		  [button mas_makeConstraints:^(MASConstraintMaker *make) {
			  make.centerX.mas_equalTo(self.mas_centerX);
			  make.height.mas_equalTo(45);
			  make.width.mas_equalTo(150);
			  make.top.mas_equalTo(_printScreensView.mas_bottom).offset(44);
		  }];
		  button;
	  });
    /** 介绍 */
    self.msgLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      label.textAlignment = NSTextAlignmentCenter;
      QMLabelFontColorText(label, @"通过审核后自动到账,审核时长1~2工作日", QMSubTextColor, 10);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-30+HOME_INDICATOR_HEIGHT);//撑开高
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(_putButton.mas_bottom).offset(20);
      }];
      label;
    });
    
  }
  return self;
}

#pragma mark - event
- (void)codeButtonClick:(UIButton *)sender {
  
}

- (void)beginButtonClick:(UIButton *)sender {
  
}



@end
