//
//  MyInComeViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "MyInComeViewController.h"
#import "MyInComeViewModel.h"//rac下的ViewModel

@interface MyInComeViewController ()

/** 列表 */
@property(nonatomic,strong) UITableView          	*tableView;
/** 是否第一次刷新 */
@property(nonatomic,assign) BOOL 					isDataLoaded;

@property (nonatomic, strong) MyInComeViewModel 	*racViewModel;

@end

@implementation MyInComeViewController

- (void)viewDidLoad {
	self.tableView.backgroundColor = UIColor.whiteColor;
	
	//因为列表延迟加载了，所以在初始化的时候加载数据即可
	[self loadData];
}



- (void)loadData {
	
	//第一次才加载，后续触发的不处理
	if (!self.isDataLoaded) {
		self.isDataLoaded = YES;
		
		//UI
		[self createUI];
		
		//绑定
		[self setupBind];
		
		//进入界面首次下拉刷新
		[self.tableView.mj_header beginRefreshing];
	}
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
	[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NotificationName_MyInComeViewController object:nil] subscribeNext:^(NSNotification * _Nullable x) {
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
- (MyInComeViewModel *)racViewModel{
	if (!_racViewModel) {
		_racViewModel = [[MyInComeViewModel alloc] init];
	}
	return _racViewModel;
}




- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] init];
		[self.view addSubview:_tableView];
		_tableView.estimatedRowHeight = 80;
		_tableView.rowHeight          = UITableViewAutomaticDimension;
		_tableView.tableFooterView    = [[UIView alloc] init];
		[_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
		}];
	}
	return _tableView;
}


#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
	return self.view;
}

- (void)listDidAppear {
	NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
	NSLog(@"%@", NSStringFromSelector(_cmd));
}
@end

