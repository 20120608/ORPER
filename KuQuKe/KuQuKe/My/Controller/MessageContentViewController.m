//
//  MessageContentViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "MessageContentViewController.h"

@interface MessageContentViewController ()

/** 消息内容 */
@property(nonatomic,strong) NSDictionary          *msgDictionary;

@end

@implementation MessageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  [self createUI];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    //触发订阅
    self.msgDictionary = @{@"name":@"这是消息标题",@"time":@"这是消息时间",@"content":@"这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容这是消息内容"};
    
  });
  
}



#pragma mark - UI
- (void)createUI {
  
  UIScrollView *scrollView = ({
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.mas_equalTo(UIEdgeInsetsMake(NAVIGATION_BAR_HEIGHT, 0, 0, 0));
    }];
    scrollView;
  });
  
  UIView *contentView = ({
    UIView *view = [[UIView alloc] init];
    [scrollView addSubview: view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.mas_equalTo(scrollView);
      make.width.mas_equalTo(kScreenWidth);
    }];
    view;
  });
  
  UILabel *titleLabel = ({
    UILabel *label = [[UILabel alloc] init];
    [contentView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    QMLabelFontColorText(label, @"_ _ _ _", QMTextColor, 16);
    label.font = [UIFont boldSystemFontOfSize:16];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.mas_equalTo(contentView.mas_right);
      make.left.mas_equalTo(contentView.mas_left);
      make.top.mas_equalTo(contentView.mas_top).offset(20);
    }];
    label;
  });
  
  UILabel *timeLabel = ({
    UILabel *label = [[UILabel alloc] init];
    [contentView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    QMLabelFontColorText(label, @"_ _ _ _", QMSubTextColor, 12);
    label.font = [UIFont boldSystemFontOfSize:16];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.mas_equalTo(contentView.mas_right);
      make.left.mas_equalTo(contentView.mas_left);
      make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
    }];
    label;
  });
  
  UILabel *contentLabel = ({
    UILabel *label = [[UILabel alloc] init];
    [contentView addSubview:label];
    label.numberOfLines = 0;
    QMLabelFontColorText(label, @"_ _ _ _", QMTextColor, 16);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(contentView.mas_left).offset(12);
      make.right.mas_equalTo(contentView.mas_right).offset(-12);
      make.width.mas_equalTo(kScreenWidth-24);
      make.top.mas_equalTo(timeLabel.mas_bottom).offset(40);
      make.bottom.mas_equalTo(contentView.mas_bottom).offset(-10);
    }];
    label;
  });
  
  //订阅最新消息内容
  [RACObserve(self, msgDictionary) subscribeNext:^(NSDictionary *x) {
    titleLabel.text = x[@"name"];
    timeLabel.text = x[@"time"];
    contentLabel.text = x[@"content"];
  }];
  
  
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
