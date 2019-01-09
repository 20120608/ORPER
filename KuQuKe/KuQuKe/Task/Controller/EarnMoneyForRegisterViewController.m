//
//  EarnMoneyForRegisterViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "EarnMoneyForRegisterViewController.h"
#import "EarnMoneyForSubLabelView.h"//标签
#import "PreviewTaskRequireView.h"  //任务内容
#import "UserMessageInputView.h"//输入用户信息


@interface EarnMoneyForRegisterViewController ()

/** 滚动的背景 */
@property(nonatomic,strong) UIScrollView          *scrollView;

@end

@implementation EarnMoneyForRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  [self createUI];
  
}


#pragma mark - UI
- (void)createUI {
  
  EarnMoneyForSubLabelView *subTagView = ({
    EarnMoneyForSubLabelView *view = [[EarnMoneyForSubLabelView alloc] init];
    [self.scrollView addSubview: view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(_scrollView.mas_left);
      make.top.mas_equalTo(_scrollView.mas_top);
      make.right.mas_equalTo(_scrollView.mas_right);
    }];
    view;
  });
  subTagView.backgroundColor = UIColor.whiteColor;
  
  PreviewTaskRequireView *preTaskView = ({
    PreviewTaskRequireView *view = [[PreviewTaskRequireView alloc] init];
    [self.scrollView addSubview: view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_scrollView.mas_left);
            make.top.mas_equalTo(subTagView.mas_bottom);
            make.right.mas_equalTo(_scrollView.mas_right);
    }];
    view;
  });
  preTaskView.backgroundColor = UIColor.whiteColor;
  
  UserMessageInputView *userMessageView = ({
    UserMessageInputView *view = [[UserMessageInputView alloc] init];
    [self.scrollView addSubview: view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(_scrollView.mas_left);
      make.top.mas_equalTo(preTaskView.mas_bottom);
      make.right.mas_equalTo(_scrollView.mas_right);
      make.bottom.mas_equalTo(_scrollView.mas_bottom);
    }];
    view;
  });
  userMessageView.backgroundColor = UIColor.whiteColor;
  
  
  
  
}



#pragma mark - load UI
-(UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = ({
      UIScrollView *scrollView = [[UIScrollView alloc] init];
      [self.view addSubview:scrollView];
      [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(NAVIGATION_BAR_HEIGHT, 0, 0, 0));
      }];
      scrollView;
    });
  }
  return _scrollView;
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
