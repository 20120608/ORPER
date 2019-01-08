//
//  DQMExpandImageView.m
//  QM_EnlargementHeaderTableView
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMExpandImageView.h"

@implementation DQMExpandImageView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setSelfAllowExpand];
  }
  return self;
}

- (void)awakeFromNib
{
  [super awakeFromNib];
  [self setSelfAllowExpand];
}


-(void)setSelfAllowExpand {
  //关键步骤 设置可变化背景view属性
  self.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
  self.clipsToBounds = YES;
  self.contentMode = UIViewContentModeScaleAspectFill;
  self.userInteractionEnabled = YES;
}



@end
