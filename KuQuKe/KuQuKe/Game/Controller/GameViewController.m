//
//  GameViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/6.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "GameViewController.h"
#import "GameHomeTaskListTableViewCell.h"//列表cell

@interface GameViewController ()

/** 数据数组 */
@property(nonatomic,strong) NSMutableArray          *listModelArray;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self createUI];
	
	
	[KuQuKeNetWorkManager getWeather:nil AndView:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
		self.listModelArray = [GameListModel mj_objectArrayWithKeyValuesArray:@[@{},@{},@{},@{},@{}]];
		[self.tableView reloadData];
		
		
	} failure:^(NSError *error) {
		
	}];
	
}


#pragma mark - createUI
- (void)createUI {
	self.view.backgroundColor = UIColor.whiteColor;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
}




#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_listModelArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	GameHomeTaskListTableViewCell *cell = [GameHomeTaskListTableViewCell cellWithTableView:tableView indexPath:indexPath FixedCellHeight:AdaptedHeight(200)];
	
	return cell;
}


#pragma mark - dqm_navibar
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar {
	return true;
}

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
	return DQMMainColor;
}

@end
