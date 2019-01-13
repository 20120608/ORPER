//
//  MyStudentsViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "MyStudentsViewController.h"
#import "LeftAndRightLabelHeaderView.h"//组头
#import "DQMRImageRLabelAndLSubLabelTableViewCell.h"//cell样式

@interface MyStudentsViewController ()

/** 数组 */
@property(nonatomic,strong) NSMutableArray<DQMRImageRLabelAndLSubLabelTableViewCellModel *>        *listDataArray;

@end

@implementation MyStudentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.tableView.tableFooterView = [UIView new];
	
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		
		NSArray *dataDicArray = @[
								  @{@"title":@"ID:896754",@"imageUrl":@"http://img3.h1365.cn/hb1/yl2/10/881812405474933.jpg",@"subTitle":@"¥23.00元"},
								  @{@"title":@"ID:196724",@"imageUrl":@"http://img3.h1365.cn/hb1/yl2/10/881812405574941.jpg",@"subTitle":@"¥13.00元"}];
		
		self.listDataArray = [DQMRImageRLabelAndLSubLabelTableViewCellModel mj_objectArrayWithKeyValuesArray:dataDicArray];
		
		[UIView transitionWithView:self.tableView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
			
			[self.tableView reloadData];
			
		} completion:nil];
	});
	
}


#pragma mark - tableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_listDataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	LeftAndRightLabelHeaderView *heaerView = [[LeftAndRightLabelHeaderView alloc] initWithFrame:CGRectZero];
	LeftAndRightLabelHeaderViewModel *heaerModel = [LeftAndRightLabelHeaderViewModel initWithleftString:@"徒弟ID" rightString:@"累计提成"];
	heaerView.headerModel = heaerModel;
	return heaerView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	DQMRImageRLabelAndLSubLabelTableViewCell *cell = [DQMRImageRLabelAndLSubLabelTableViewCell cellWithTableView:tableView indexPath:indexPath andFixedHeightIfNeed:75 showArrow:true];
	cell.model = _listDataArray[indexPath.row];
	return cell;
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


#pragma mark - load data
-(NSMutableArray *)listDataArray {
	if (!_listDataArray) {
		_listDataArray = [[NSMutableArray alloc] init];
	}
	return _listDataArray;
}

@end
