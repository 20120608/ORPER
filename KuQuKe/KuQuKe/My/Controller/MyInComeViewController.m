//
//  MyInComeViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "MyInComeViewController.h"
#import "TaskTableViewCell.h"//cell的样式

@interface MyInComeViewController () <UITableViewDelegate,UITableViewDataSource>

/** 数据源 */
@property(nonatomic,strong) NSMutableArray          *listDataArray;
/** 列表 */
@property(nonatomic,strong) UITableView          	*tableView;
/** 是否第一次刷新 */
@property(nonatomic,assign) BOOL 					isDataLoaded;
@end

@implementation MyInComeViewController

- (void)viewDidLoad {
	self.tableView.backgroundColor = UIColor.whiteColor;
	
	//因为列表延迟加载了，所以在初始化的时候加载数据即可
	[self loadData];
}



- (void)loadData {
	NSLog(@"1111");
	//第一次才加载，后续触发的不处理
	if (!self.isDataLoaded) {
		[self headerRefresh];
		self.isDataLoaded = YES;
	}
}


- (void)headerRefresh {
	NSLog(@"1111wwww");
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		NSLog(@"刷新");
		[self.listDataArray addObjectsFromArray:@[@{@"11":@"222"},@{@"11":@"222"},@{@"11":@"222"}]];
		[UIView transitionWithView:self.tableView duration:0.35 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
			[self.tableView reloadData];
		} completion:nil];
	});
	
}




#pragma mark - tableview datasource
#pragma mark - tableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	TaskTableViewCell *cell = [TaskTableViewCell cellWithTableView:tableView initWithCellStyle:TaskTableViewCellStyleInCome indexPath:indexPath andFixedHeightIfNeed:60];
	return cell;
}













#pragma mark - load data
-(NSMutableArray *)listDataArray {
	if (!_listDataArray) {
		_listDataArray = [[NSMutableArray alloc] init];
	}
	return _listDataArray;
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] init];
		[self.view addSubview:_tableView];
		_tableView.delegate           = self;
		_tableView.dataSource         = self;
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

