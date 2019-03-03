//
//  MessageCenterViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MessageCenterViewModel.h"//视图模型

@interface MessageCenterViewController ()

@property (nonatomic, strong) MessageCenterViewModel *racViewModel;

@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	//UI
	[self createUI];
	
	//绑定
	[self setupBind];
	
	//进入界面首次下拉刷新
	[self.tableView.mj_header beginRefreshing];
}

#pragma mark - createUI
- (void)createUI {
	QMWeak(self);
	[self.view addSubview:self.tableView];
	//下拉刷新
	self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		[weakself.racViewModel.requestVideoListCommand execute:@{@"headerRefresh":@"1"}];
	}];
	//下拉加载更多
	self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
		[weakself.racViewModel.requestVideoListCommand execute:@{@"headerRefresh":@"0"}];
	}];
}


#pragma mark - Bind UI
- (void)setupBind{
	
	self.racViewModel.currentVC = self;
	self.tableView.dataSource = self.racViewModel;
	self.tableView.delegate = self.racViewModel;
	self.tableView.tableFooterView = [UIView new];
	
	//通知方法刷新表视图
	@weakify(self)
	[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NotificationName_MessageCenterViewController object:nil] subscribeNext:^(NSNotification * _Nullable x) {
		@strongify(self)
		[self resetRefreshView];
		[UIView transitionWithView:self.tableView duration:0.35 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
			[self.tableView reloadData];
		} completion:^(BOOL finished) {
			
		}];
	}];
}


- (void)resetRefreshView{
	if ([self.tableView.mj_header isRefreshing]) {
		[self.tableView.mj_header endRefreshing];
	}
	if ([self.tableView.mj_footer isRefreshing]) {
		[self.tableView.mj_footer endRefreshing];
	}
}


#pragma mark - load
- (MessageCenterViewModel *)racViewModel{
	if (!_racViewModel) {
		_racViewModel = [[MessageCenterViewModel alloc] init];
	}
	return _racViewModel;
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
