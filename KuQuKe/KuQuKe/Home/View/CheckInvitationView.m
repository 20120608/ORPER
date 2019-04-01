//
//  CheckInvitationView.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/2/25.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "CheckInvitationView.h"

@implementation CheckInvitationView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.6];
    
    UIView *backView = ({
      UIView *view = [[UIView alloc] init];
      [self addSubview: view];
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/3*2, kScreenWidth/3*2/0.84));
      }];
      view;
    });
	  
	  UIButton *closeButton = ({
		  UIButton *button = [[UIButton alloc] init];
		  [self addSubview:button];
		  button.tag = 0;
		  QMSetButton(button, nil, 12, @"icon_dqm_ring_close_white", QMRandomColor, UIControlStateNormal);
		  [button mas_makeConstraints:^(MASConstraintMaker *make) {
			  make.right.mas_equalTo(self.mas_right).offset(-30);
			  make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT+30);
			  make.size.mas_equalTo(CGSizeMake(30, 30));
		  }];
		  button;
	  });
	  [closeButton addTarget:self action:@selector(AlertViewbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
	  
	  
    UIImageView *backImageView =  ({
      UIImageView *imageView = [[UIImageView alloc] init];
      [self addSubview: imageView];
      imageView.userInteractionEnabled = true;
      [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(backView);
      }];
      imageView;
    });
    QMSetImage(backImageView, @"绑定邀请码背景");

    UILabel *titleLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [backImageView addSubview:label];
      label.font = [UIFont boldSystemFontOfSize:20];
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(15);
      }];
      label;
    });
    QMLabelFontColorText(titleLabel, @"填写邀请码", QMHexColor(@"f8d66e"), 20);

    
    UILabel *messageLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [backImageView addSubview:label];
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(50);
      }];
      label;
    });
    QMLabelFontColorText(messageLabel, @"请可获得0.5元红包", QMHexColor(@"f8d66e"), 16);

//    要用到高度
    [backImageView setNeedsLayout];
    [backImageView layoutIfNeeded];
    
    UITextField *inputTextField = ({
      UITextField *textField = [[UITextField alloc] init];
      [backImageView addSubview:textField];
      textField.placeholder = @"请填写邀请码";
      textField.textColor = QMTextColor;
      textField.font = KQMFont(16);
      textField.textAlignment = NSTextAlignmentCenter;
      [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
          make.height.mas_equalTo(backImageView.height*70/709);
          make.left.mas_equalTo(30);
          make.right.mas_equalTo(-30);
          make.top.mas_equalTo(backImageView.height*227/709);
        }];
      }];
      textField;
    });
    //需要圆角
    QMViewBorderRadius(inputTextField, backImageView.height*70/709/2, 0, DQMMainColor);
    inputTextField.backgroundColor = [UIColor whiteColor];
    
    UIButton *receiveButton = ({
      UIButton *button = [[UIButton alloc] init];
      [backImageView addSubview:button];
      [button setBackgroundImage:[UIImage imageNamed:@"圆圈"] forState:UIControlStateNormal];
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(backImageView.height*164/229-40);
        make.size.mas_equalTo(CGSizeMake(80, 80));
      }];
      button;
    });
    QMSetButton(receiveButton, @"领取", 22, nil, QMHexColor(@"d88523"), UIControlStateNormal);

    UIButton *QQqunButton = ({
      UIButton *button = [[UIButton alloc] init];
      [backImageView addSubview:button];
      button.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.3];
      QMViewBorderRadius(button, backImageView.height*50/709/2, 0, DQMMainColor);
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(backImageView.height*50/709);
        make.bottom.mas_equalTo(backImageView.mas_bottom).offset(-10);
      }];
      button;
    });
    QMSetButton(QQqunButton, @" 我还没邀请码,请联系客服索取  ", 14, nil, QMHexColor(@"d88523"), UIControlStateNormal);

    [[receiveButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
      if ([_delegate respondsToSelector:@selector(CheckInvitationView:DidSelectInvitation:)]) {
        [self.delegate CheckInvitationView:self DidSelectInvitation:inputTextField.text];
      }
    }];
    
    [[QQqunButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
      if ([_delegate respondsToSelector:@selector(CheckInvitationViewDidSelectAddQQSection:)]) {
		  [self removeFromSuperview];
        [self.delegate CheckInvitationViewDidSelectAddQQSection:self];
      }
    }];
    
    //show
    [[self rac_signalForSelector:@selector(show)] subscribeNext:^(id  _Nullable x) {
      CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
      animation.fromValue = [NSNumber numberWithFloat:0.01f];
      animation.toValue = [NSNumber numberWithFloat:1.0f];
      animation.duration = 0.2f;
      animation.fillMode = kCAFillModeForwards;
      animation.removedOnCompletion = NO;
      [backImageView.layer addAnimation:animation forKey:@"scaleAnimation"];
    }];
    
    //hide
    [[self rac_signalForSelector:@selector(hide)] subscribeNext:^(id  _Nullable x) {
      CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
      animation.fromValue = [NSNumber numberWithFloat:1.0f];
      animation.toValue = [NSNumber numberWithFloat:0.01f];
      animation.duration = 0.2f;
      animation.fillMode = kCAFillModeForwards;
      animation.removedOnCompletion = NO;
      [backImageView.layer addAnimation:animation forKey:@"scaleAnimation"];
     //移除
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
      });
    }];
    
  }
  return self;
}

- (void)AlertViewbuttonClick:(UIButton *)sender {
	[self hide];
}

- (void)show {
  NSLog(@"调用的显示,看订阅");
}
- (void)hide {
  NSLog(@"调用的隐藏,看订阅");
}

@end
