//
//  GameTaskStepView.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/23.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "GameTaskStepView.h"

@implementation GameTaskStepView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    UIView *backView = ({
      UIView *view = [[UIView alloc] init];
      [self addSubview: view];
      QMViewBorderRadius(view, 6, 0, DQMMainColor);
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
        make.height.mas_equalTo(80).priorityHigh();
      }];
      view;
    });
    
    UILabel *titleLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [backView addSubview:label];
      QMLabelFontColorText(label, @"1.请下载\"红包大派送\"APP", QMTextColor, 23);
      label.font = [UIFont boldSystemFontOfSize:23];
      label.adjustsFontSizeToFitWidth = true;
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 5, 40, 100));
      }];
      label;
    });
    
    UILabel *msgLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [backView addSubview:label];
      QMLabelFontColorText(label, @"领取任务后完成即可获得奖励", QMSubTextColor, 13);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(40, 5, 0, 100));
      }];
      label;
    });
    
    UIButton *rightButton = ({
      UIButton *button = [[UIButton alloc] init];
      [backView addSubview:button];
      QMSetButton(button, @"校验", 16, nil, QMBlueColor, UIControlStateNormal);
      QMViewBorderRadius(button, 18, 0, DQMMainColor);
      [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(80, 36));
        make.centerY.mas_equalTo(backView.mas_centerY);
      }];
      button;
    });
    
    
    [[RACObserve(self, style) skip:1] subscribeNext:^(id  _Nullable x) {
      GameTaskStepViewStyle style = (GameTaskStepViewStyle)[x integerValue];
      switch (style) {
        case GameTaskStepViewStyleDefault:
        {
          [rightButton setBackgroundColor:QMBackColor forState:UIControlStateNormal];
          [rightButton setTitleColor:QMBlueColor forState:UIControlStateNormal];
          backView.backgroundColor = QMHexColor(@"f4f4f4");
        }
          break;
        case GameTaskStepViewStyleBackgroundColorGary:
          {
            [rightButton setBackgroundColor:DQMMainColor forState:UIControlStateNormal];
            [rightButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            backView.backgroundColor = QMHexColor(@"e5e5e5");
          }
          break;
        default:
          break;
      }
    }];
    
  }
  return self;
}


#pragma mark - touch event
- (void)rightButtonClick:(UIButton *)sender {
  
}

@end
