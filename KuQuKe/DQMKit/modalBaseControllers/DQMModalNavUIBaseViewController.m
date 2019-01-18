//
//  DQMModalNavUIBaseViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/18.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMModalNavUIBaseViewController.h"

@interface DQMModalNavUIBaseViewController ()

@end

@implementation DQMModalNavUIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];
  self.edgesForExtendedLayout = UIRectEdgeNone;
  
  [self createNavigationView];

}

- (void)createNavigationView {
  UIView *navi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, NAVIGATION_BAR_HEIGHT)];
  UILabel *label = [[UILabel alloc] init];
  [navi addSubview:label];
  QMLabelFontColorText(label, @"", QMTextColor, 18);
  [label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(navi.mas_centerX);
    make.bottom.mas_equalTo(navi.mas_bottom);
    make.height.mas_equalTo(44);
  }];
  
  UIButton *backButton = [[UIButton alloc] init];
  [navi addSubview:backButton];
  backButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
  QMSetButton(backButton, nil, 12, @"NavgationBar_blue_back", QMTextColor, UIControlStateNormal);
  [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
  [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(navi.mas_left);
    make.size.mas_equalTo(CGSizeMake(44, 44));
    make.bottom.mas_equalTo(navi.mas_bottom);
  }];
  
  if ([self.dataSource respondsToSelector:@selector(navUIBaseViewControllerNaviBackgroundColor:)]) {
     navi.backgroundColor = [self.dataSource navUIBaseViewControllerNaviBackgroundColor:self];
  }
  
  if ([self.dataSource respondsToSelector:@selector(navUIBaseViewControllerNaviTitle:)]) {
    label.attributedText = [self.dataSource navUIBaseViewControllerNaviTitle:self];
  }
  
  [self.view addSubview: navi];
}

#pragma mark - delegate bind

- (void)backButtonClick:(UIButton *)sender {
  if ([self.delegate respondsToSelector:@selector(leftButtonEvent:navigationBar:)]) {
    [self.delegate leftButtonEvent:sender navigationBar:self];
  }
}


#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
}


- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)dealloc {
  NSLog(@"dealloc -- %@ %s",QMKeyPath(self.navigationItem, title),__func__);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
  return NO;
}




#pragma mark 自定义代码

- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
  NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
  
  [title addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, title.length)];
  
  [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, title.length)];
  
  return title;
}



@end







