//
//  MyStudentsViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "MyStudentsViewController.h"
#import "StudentListViewModel.h"//rac下的ViewModel

@interface MyStudentsViewController ()

@property (nonatomic, strong) StudentListViewModel *racViewModel;

@end

@implementation MyStudentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.tableView.tableFooterView = [UIView new];

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
	
	//通知方法刷新表视图
	@weakify(self)
	[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NotificationName_MyStudentsViewController object:nil] subscribeNext:^(NSNotification * _Nullable x) {
		@strongify(self)
		[self resetRefreshView];
		[UIView transitionWithView:self.tableView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
			[self.tableView reloadData];
		} completion:nil];
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
- (StudentListViewModel *)racViewModel{
	if (!_racViewModel) {
		_racViewModel = [[StudentListViewModel alloc] init];
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

- (NSMutableAttributedString *)dqmNavigationBarTitle:(DQMNavigationBar *)navigationBar {
	return [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:@"我的徒弟" color:[UIColor whiteColor]];
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
	[self.navigationController popViewControllerAnimated:true];
}

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
	return DQMMainColor;
}



@end
