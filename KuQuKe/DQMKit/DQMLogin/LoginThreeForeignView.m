//
//  LoginThreeForeignView.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/24.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "LoginThreeForeignView.h"

@implementation LoginThreeForeignView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    
    
    UIView *line = ({
      UIView *view = [[UIView alloc] init];
      [self addSubview: view];
      view.backgroundColor = QMHexColor(@"bdbec0");
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-48, 1));
      }];
      view;
    });
    UILabel *msgLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      label.backgroundColor = UIColor.whiteColor;
      QMLabelFontColorText(label, @"   其他登录方式   ", QMHexColor(@"bdbec0"), 15);
      label.font = [UIFont boldSystemFontOfSize:16];
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(line.mas_centerX);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(20);
      }];
      label;
    });
    
    UIButton *wechatButton = ({
      UIButton *button = [[UIButton alloc] init];
      [self addSubview:button];
      QMSetButton(button, nil, 12, @"wechat_logo", nil, UIControlStateNormal);
      [button addTarget:self action:@selector(wechatButtonClick:) forControlEvents:UIControlEventTouchUpInside];
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(msgLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(45, 36));
      }];
      button;
    });

    
  }
  return self;
}

-(void)wechatButtonClick:(UIButton *)sender {
  NSLog(@"微信");
}


@end
