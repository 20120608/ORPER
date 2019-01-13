//
//  APPViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/6.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "APPViewController.h"
#import "LeftAndRightLabelHeaderView.h"//组头
#import "TaskTableViewCell.h"//任务列表cell

@interface APPViewController ()

/** 数组 */
@property(nonatomic,strong) NSMutableArray       *listDataArray;

@end

@implementation APPViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	//重置tableView
	self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(0);
		make.top.mas_equalTo(self.dqm_navgationBar.mas_bottom);
		make.bottom.mas_equalTo(self.view.mas_bottom).offset(-TAB_BAR_HEIGHT);
	}];
	
	
	
	
	//模拟请求数据
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		
		
		[UIView transitionWithView:self.tableView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
			
			[self.tableView reloadData];
			
		} completion:nil];
	});
	
}


#pragma mark - tableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 10;
	return [_listDataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	LeftAndRightLabelHeaderView *heaerView = [[LeftAndRightLabelHeaderView alloc] initWithFrame:CGRectZero];
	LeftAndRightLabelHeaderViewModel *heaerModel = [LeftAndRightLabelHeaderViewModel initWithleftString:@"投放中" rightString:@""];
	heaerView.headerModel = heaerModel;
	return heaerView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	TaskTableViewCell *cell = [TaskTableViewCell cellWithTableView:tableView initWithCellStyle:TaskTableViewCellStyleSubTag indexPath:indexPath andFixedHeightIfNeed:80];
	return cell;
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
