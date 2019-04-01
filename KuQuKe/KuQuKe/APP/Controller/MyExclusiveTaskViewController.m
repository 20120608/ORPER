//
//  MyExclusiveTaskViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/3/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "MyExclusiveTaskViewController.h"
#import "MyExclusiveTaskViewModel.h"

@interface MyExclusiveTaskViewController ()

/** 视图模型 */
@property(nonatomic,strong) MyExclusiveTaskViewModel          *racViewModel;
/** 头部 */
@property(nonatomic,strong) UILabel					  *myTaskLabel;

@end

@implementation MyExclusiveTaskViewController

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
	self.tableView.backgroundColor = UIColor.whiteColor;
	self.tableView.tableFooterView = [UIView new];
	//重置tableView
	self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(0);
		make.top.mas_equalTo(self.dqm_navgationBar.mas_bottom);
		make.bottom.mas_equalTo(self.view.mas_bottom).offset(-TAB_BAR_HEIGHT);
	}];
	QMWeak(self);
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
	[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NotificationName_MyExclusiveTaskViewController object:nil] subscribeNext:^(NSNotification * _Nullable x) {
		@strongify(self)
		NSDictionary *dic = x.object;
		NSString *astring = [NSString stringWithFormat:@"您有%@个专属任务，共%@元",dic[@"data"][@"exclusive_info"][@"exclusive_num"],dic[@"data"][@"exclusive_info"][@"exclusive_sum"]];
		self.myTaskLabel.text = astring;
		[self.tableView reloadData];
		[self resetRefreshView];
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
- (MyExclusiveTaskViewModel *)racViewModel{
	if (!_racViewModel) {
		_racViewModel = [[MyExclusiveTaskViewModel alloc] init];
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

