//
//  GameViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/6.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "GameViewController.h"
#import "GameHomeTaskListTableViewCell.h"//列表cell
#import "GameTaskCheckInDetailViewController.h"//游戏活动详情页

@interface GameViewController ()

/** 数据数组 */
@property(nonatomic,strong) NSMutableArray          *listModelArray;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self createUI];
	
	
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    self.listModelArray = [GameListModel mj_objectArrayWithKeyValuesArray:@[@{},@{},@{},@{},@{}]];
    [self.tableView reloadData];
  });
  
}


#pragma mark - createUI
- (void)createUI {
	self.tableView.backgroundColor = UIColor.whiteColor;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
  //重置tableView
  self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.mas_equalTo(0);
    make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    make.bottom.mas_equalTo(self.view.mas_bottom).offset(-TAB_BAR_HEIGHT);
  }];
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



#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  GameTaskCheckInDetailViewController *vc = [[GameTaskCheckInDetailViewController alloc] initWithTitle:@"任务详情"];
  [self.navigationController pushViewController:vc animated:true];
}





#pragma mark - dqm_navibar
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar {
	return true;
}

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
	return DQMMainColor;
}

@end
