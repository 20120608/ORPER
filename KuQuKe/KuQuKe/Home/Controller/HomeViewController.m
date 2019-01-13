//
//  HomeViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/6.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "HomeViewController.h"
#import "CheckInViewController.h"//签到
#import "DQMHorizontalViewScrollerView.h" //滚动广告
#import "TaskTableViewCell.h"//任务cell
#import "AvgButtonMenuTableViewCell.h"//多按钮菜单样式的cell
#import "RotaryTableViewController.h" //转盘
#import "DQMRightImageViewTableViewCell.h"//头像的cell
#import "OnGoingTaskViewController.h"//进行中的任务
#import "HomeBigAmazingTableViewCell.h"//大礼包
#import "HomeHeaderView.h"//组头
#import "ShareToMyFriendViewController.h"//邀请赚钱
#import "HomeMyTaskTableViewCell.h"//专属任务
#import "EarnMoneyForRegisterViewController.h"//安装注册赚钱

#import "CheckOutAliPayViewController.h"

@interface HomeViewController () <DQMHorizontalViewScrollerViewDataSource,AvgButtonMenuTableViewCellDelegate>
{
	UIStatusBarStyle _barStyle;
}

/** 滚动广告 */
@property(nonatomic,strong) DQMHorizontalViewScrollerView *advScrollView;

@property(nonatomic,copy) NSString *myMoney; /* 余额 */


@end

@implementation HomeViewController

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated {
	_barStyle = UIStatusBarStyleLightContent;
	[self setNeedsStatusBarAppearanceUpdate];
	
	[self.advScrollView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
	_barStyle = UIStatusBarStyleDefault;
	[self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];

  [self createUI];
	
  QMWeak(self);
  //广告请求数据 推荐赚钱数据
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
	  
	  //订阅余额
	  self.myMoney = @"1";
	  
    [weakself.advScrollView reloadData];
    
   
  });

}

#pragma mark - UI
-(void)createUI {
	
	[self DIYNavibar];//导航栏部分
	
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	self.advScrollView = [[DQMHorizontalViewScrollerView alloc] initWithFrame:CGRectMake(0,NAVIGATION_BAR_HEIGHT, kScreenWidth, 38)];
	_advScrollView.dataSource = self;
	[self.view addSubview:_advScrollView];
	//重置tableView
	self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(0);
		make.top.mas_equalTo(_advScrollView.mas_bottom);
		make.bottom.mas_equalTo(self.view.mas_bottom).offset(-TAB_BAR_HEIGHT);
	}];
	
  
}

-(void)DIYNavibar {
	UIView *navi = ({
		UIView *view = [[UIView alloc] init];
		[self.view addSubview: view];
		view.backgroundColor = DQMMainColor;
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.right.top.mas_equalTo(0);
			make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
		}];
		view;
	});
	
	UILabel *moneyLabel = ({
		UILabel *label = [[UILabel alloc] init];
		[navi addSubview:label];
		QMLabelFontColorText(label, @"今日赚钱: ¥0.00", UIColor.whiteColor, 15);
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(navi.mas_left).offset(15);
			make.bottom.mas_equalTo(navi.mas_bottom).offset(-12);
		}];
		label;
	});
	[RACObserve(self, myMoney) subscribeNext:^(NSString *x) {
		moneyLabel.text = [NSString stringWithFormat:@"今日赚钱: ¥%.2f",[x floatValue]];
	}];
	
	UIButton *withdrawMoneyButton = [UIButton initWithFrame:CGRectZero buttonTitle:@"提现" normalColor:DQMMainColor cornerRadius:AdaptedWidth(11) doneBlock:^(UIButton *sender) {
		NSLog(@"提现");
		
		
	}];
	
	[navi addSubview:withdrawMoneyButton];
	withdrawMoneyButton.backgroundColor = UIColor.whiteColor;
	[withdrawMoneyButton.titleLabel setFont:AdaptedFontSize(13)];
	[withdrawMoneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(navi.mas_right).offset(-15);
		make.height.mas_equalTo(AdaptedWidth(22));
		make.width.mas_equalTo(AdaptedWidth(54));
		make.bottom.mas_equalTo(navi.mas_bottom).offset(-12);
	}];
	
}





#pragma mark - tableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 4) {
		return 10;
	}
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	if (section == 2 || section == 4) {
		return 35;
	}
	return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 2:
		{
			HomeHeaderView *headerView = [[HomeHeaderView alloc] initWithFrame:CGRectZero];
			headerView.titleString = @"酷玩赚钱";
			headerView.subTitleString = @"高额赚钱";
			return headerView;
		}
			break;
		case 4:
		{
			HomeHeaderView *headerView = [[HomeHeaderView alloc] initWithFrame:CGRectZero];
			headerView.titleString = @"推荐赚钱";
			headerView.subTitleString = @"";
			return headerView;
		}
			break;
		default:
			return [UIView new];
			break;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	switch (section) {
		case 1:
		return 0.01;
			break;
		default:
			break;
	}
	return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
	footerView.backgroundColor = QMBackColor;
	return footerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.section) {
		case 0:
		{
			AvgButtonMenuTableViewCell *cell = [AvgButtonMenuTableViewCell cellWithTableView:tableView initWithButtonsNum:4 indexPath:indexPath andFixedHeightIfNeed:85 WithDatasArray:@[@{@"name":@"邀请赚钱",@"icon":@"01"},@{@"name":@"现金签到",@"icon":@"02"},@{@"name":@"抽奖大转盘",@"icon":@"03"},@{@"name":@"正在进行",@"icon":@"04"}] withFixedSpacing:0 leadSpacing:10 tailSpacing:10];
			cell.delegate = self;
			return cell;
		}
			break;
		case 1:
		{
			HomeBigAmazingTableViewCell *cell = [HomeBigAmazingTableViewCell cellWithTableView:tableView];
			return cell;
		}
			break;
		case 2:
		{
			AvgButtonMenuTableViewCell *cell = [AvgButtonMenuTableViewCell cellWithTableView:tableView initWithButtonsNum:2 indexPath:indexPath andFixedHeightIfNeed:80 WithDatasArray:@[@{@"name":@"",@"icon":@"05"},@{@"name":@"",@"icon":@"06"}] withFixedSpacing:0 leadSpacing:10 tailSpacing:10];
			return cell;
		}
			break;
		case 3:
		{
			HomeMyTaskTableViewCell *cell = [HomeMyTaskTableViewCell cellWithTableView:tableView];
			cell.contentMAString = [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:@"我的专属任务6个,全部完成可以获得23元奖励" font:[UIFont systemFontOfSize:14] rangeOfFont:NSMakeRange(6, 2) color:QMPriceColor rangeOfColor:NSMakeRange(6, 2)];
			return cell;
		}
			break;
		case 4:
		{
			TaskTableViewCell *cell = [TaskTableViewCell cellWithTableView:tableView initWithCellStyle:TaskTableViewCellStylePriceLabelGreenColor indexPath:indexPath andFixedHeightIfNeed:68];
			cell.showSeperaterLine = true;
			return cell;
		}
			break;
			
			
		default:
			break;
	}
	return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	EarnMoneyForRegisterViewController *vc = [[EarnMoneyForRegisterViewController alloc] initWithTitle:@"注册赚钱"];
	[self.navigationController pushViewController:vc animated:true];
}


#pragma mark - AvgButtonMenuTableViewCellDelegate
- (void)avgButtonMenuTableViewCell:(AvgButtonMenuTableViewCell *)cell didSelectRowAtIndex:(NSInteger)index superIndexPath:(NSIndexPath *)indexPath {
	switch (index) {
		case 0:
		{
			ShareToMyFriendViewController *vc = [[ShareToMyFriendViewController alloc] initWithStyle:UITableViewStyleGrouped];
			[self.navigationController pushViewController:vc animated:true];
		}
			break;
		case 1:
			{
				CheckInViewController *vc = [[CheckInViewController alloc] initWithTitle:@"每日签到"];
				[self.navigationController pushViewController:vc animated:true];
			}
			break;
		case 2:
		{
			RotaryTableViewController *vc = [[RotaryTableViewController alloc] initWithTitle:@"抽奖拿现金"];
			[self.navigationController pushViewController:vc animated:true];
		}
			break;
		case 3:
		{
			OnGoingTaskViewController *vc = [[OnGoingTaskViewController alloc] initWithTitle:@"正在进行"];
			[self.navigationController pushViewController:vc animated:true];
		}
			break;
			
		default:
			break;
	}
	
	
	
}





#pragma mark - DQMHorizontalViewScrollerViewDataSource
- (NSArray *)horizontalViewScrollViewDataArray:(DQMHorizontalViewScrollerView *)horizontalScrollView
{
  return @[@{@"name":@"186****1234的客户赚了10元,获得厦门一日游"},@{@"name":@"186****1234的客户赚了10元"},@{@"name":@"186****1234的客户刚刚签到成功获得100元现金抵用券"},@{@"name":@"186****1234的客户赚了0.02元"},@{@"name":@"186****1234的客户赚了1元"}];
}


#pragma mark - dqm_navibar
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(DQMNavUIBaseViewController *)navUIBaseViewController {
	return false;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
	return _barStyle;
}



@end
