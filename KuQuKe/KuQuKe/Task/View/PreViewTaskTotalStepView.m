//
//  PreViewTaskTotalStepView.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/16.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "PreViewTaskTotalStepView.h"

@implementation PreViewTaskTotalStepView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = QMBackColor;
    
    UILabel *msgLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      QMLabelFontColorText(label, @"详细步骤", QMSubTextColor, 18);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-10);
      }];
      label;
    });
    
    UILabel *totalLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      QMLabelFontColorText(label, @"共有0步", QMSubTextColor, 12);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(msgLabel.mas_bottom).offset(10);
      }];
      label;
    });
    
    [RACObserve(self, totalNum) subscribeNext:^(id  _Nullable x) {
      totalLabel.text = [NSString stringWithFormat:@"共%ld步",[x integerValue]];
    }];
    
    
  }
  return self;
}

@end
