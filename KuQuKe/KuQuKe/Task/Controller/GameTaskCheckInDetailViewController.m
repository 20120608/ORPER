//
//  GameTaskCheckInDetailViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/19.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "GameTaskCheckInDetailViewController.h"

@interface GameTaskCheckInDetailViewController ()

@end

@implementation GameTaskCheckInDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}





#pragma mark - dqm_navibar
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar {
  return true;
}

/** 导航条左边的按钮 */
- (UIImage *)dqmNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(DQMNavigationBar *)navigationBar {
  [leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];
  return [UIImage imageNamed:@"NavgationBar_white_back"];
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
  [self.navigationController popViewControllerAnimated:true];
}

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
  return DQMMainColor;
}

@end
