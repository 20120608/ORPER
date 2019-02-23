//
//  APPViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/6.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "APPViewController.h"
#import "APPPageViewModel.h"
@interface APPViewController ()

/** 数组 */
@property(nonatomic,strong) NSMutableArray       *listDataArray;
/** 视图模型 */
@property(nonatomic,strong) APPPageViewModel          *racViewModel;
@end

@implementation APPViewController

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
  [[[NSNotificationCenter defaultCenter] rac_addObserverForName:NotificationName_APPViewController object:nil] subscribeNext:^(NSNotification * _Nullable x) {
    @strongify(self)

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
- (APPPageViewModel *)racViewModel{
  if (!_racViewModel) {
    _racViewModel = [[APPPageViewModel alloc] init];
  }
  return _racViewModel;
}


#pragma mark - dqm_navibar
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar {
	return true;
}

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
	return DQMMainColor;
}


#pragma mark - load data
-(NSMutableArray *)listDataArray {
	if (!_listDataArray) {
		_listDataArray = [[NSMutableArray alloc] init];
	}
	return _listDataArray;
}

@end
