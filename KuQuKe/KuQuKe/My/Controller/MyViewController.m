//
//  MyViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/6.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "MyViewController.h"
#import "DQMImageAndArrowTableViewCell.h"
#import "DQMExpandHeader.h"
#import "DQMExpandImageView.h"

#define HEADER_TOP AdaptedHeight(400) //滚动到多少导航栏变不透明

@interface MyViewController ()
{
	UIStatusBarStyle _statusBarStyle; /*要想改变状态栏的颜色要在plist配置 View controller-based status bar appearance 为YES*/
}
@property (nonatomic, strong) DQMExpandHeader *expandHander;

/** 数据数组 */
@property(nonatomic,strong) NSMutableArray *listDataArray;
/** 设置 */
@property(nonatomic,strong) UIButton *settingButton;
/** 消息 */
@property(nonatomic,strong) UIButton *messageButton;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//创建界面
	[self createUI];
	
	[self loadTableViewListData];

	
	
}

#pragma mark - createUI
- (void)createUI {
	UIEdgeInsets edgeInsets = self.tableView.contentInset;
	edgeInsets.top -= NAVIGATION_BAR_HEIGHT;
	self.tableView.contentInset = edgeInsets;
	self.tableView.backgroundColor = QMBackColor;
	
	_statusBarStyle = UIStatusBarStyleLightContent;

	UIImageView *imageView = [[DQMExpandImageView alloc] initWithImage:[UIImage imageNamed:@"img_header"]];
	imageView.height = HEADER_TOP;
	imageView.width = kScreenWidth;
	imageView.backgroundColor = DQMMainColor;
	_expandHander = [DQMExpandHeader expandWithScrollView:self.tableView expandView:imageView];
	
	UIImageView *headerImageView = [[UIImageView alloc] init];
	QMSetImage(headerImageView, @"my_header_bg");
	[imageView addSubview:headerImageView];
	[headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(imageView);
		make.bottom.mas_equalTo(imageView.mas_bottom);
		make.height.mas_equalTo(kScreenWidth/1127*827);
	}];
	
	UIView *whiteBackView = ({
		UIView *view = [[UIView alloc] init];
		[imageView addSubview: view];
		view.backgroundColor = UIColor.whiteColor;
		QMViewBorderRadius(view, 4, 0, UIColor.whiteColor);
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(self.view);
			make.bottom.mas_equalTo(imageView.mas_bottom).offset(-20);
			make.height.mas_equalTo(110);
			make.left.mas_equalTo(20);
		}];
		view;
	});
	
	
}


- (void)loadTableViewListData {
	NSArray<DQMTeam *> *firstSectionItemsArray =
  @[[DQMTeam initTeamWithName:@"账号安全" sortNumber:nil destVc:[MyViewController class] extensionDictionary:@{@"icon":@"006"}],
	[DQMTeam initTeamWithName:@"QQ客服群" sortNumber:nil destVc:[MyViewController class] extensionDictionary:@{@"icon":@"007"}],
	[DQMTeam initTeamWithName:@"分享给朋友" sortNumber:nil destVc:[MyViewController class] extensionDictionary:@{@"icon":@"008"}]];
	
	NSArray<DQMTeam *> *secondSectionItemsArray =
  @[[DQMTeam initTeamWithName:@"关于酷趣客" sortNumber:nil destVc:[MyViewController class] extensionDictionary:@{@"icon":@"009"}],
	[DQMTeam initTeamWithName:@"检查更新" sortNumber:nil destVc:[MyViewController class] extensionDictionary:@{@"icon":@"010"}]];
	
	[self.listDataArray addObject:firstSectionItemsArray];
	[self.listDataArray addObject:secondSectionItemsArray];
	[self.tableView reloadData];
}


#pragma mark - tableView datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [_listDataArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.listDataArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 8)];
	headerView.backgroundColor = QMBackColor;
	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
	footerView.backgroundColor = QMBackColor;
	return footerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	DQMImageAndArrowTableViewCell *cell = [DQMImageAndArrowTableViewCell cellWithTableView:tableView andIndexPath:indexPath andFixedCellHeight:AdaptedHeight(56)];
	cell.teamModel = self.listDataArray[indexPath.section][indexPath.row];
	return cell;
}


#pragma mark - scroll delegate
//滚动的视图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	
	NSLog(@"offset---scroll:%f",self.tableView.contentOffset.y);
	UIColor *color = [UIColor whiteColor];
	CGFloat offset = scrollView.contentOffset.y;
	
	NSString *navititle = @"我的";
	if (offset + HEADER_TOP <= 0) {
		self.dqm_navgationBar.title = [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:navititle font:AdaptedBoldFont(16) rangeOfFont:NSMakeRange(0, navititle.length) color:QMHexColor(@"ffffff") rangeOfColor:NSMakeRange(0, navititle.length)];
		self.dqm_navgationBar.backgroundColor = [color colorWithAlphaComponent:0];
		self.dqm_navgationBar.titleView.alpha = 0.01;
		_statusBarStyle = UIStatusBarStyleLightContent;//白色
		[_messageButton setSelected: false];
		[_settingButton setSelected: false];
	} else {
		CGFloat alpha = 1 - ( ( 64- offset - HEADER_TOP ) / 64 );
		self.dqm_navgationBar.title = [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:navititle font:AdaptedBoldFont(16) rangeOfFont:NSMakeRange(0, navititle.length) color:QMHexColor(@"373A3F") rangeOfColor:NSMakeRange(0, navititle.length)];
		self.dqm_navgationBar.backgroundColor = [color colorWithAlphaComponent:alpha];
		self.dqm_navgationBar.titleView.alpha = alpha;
		_statusBarStyle = UIStatusBarStyleDefault;//黑色
		[_messageButton setSelected: true];
		[_settingButton setSelected: true];
	}
	[self setNeedsStatusBarAppearanceUpdate];//重新设置状态栏

}


#pragma mark - navi delegate
- (NSMutableAttributedString *)dqmNavigationBarTitle:(DQMNavigationBar *)navigationBar {
	return [[NSMutableAttributedString alloc] initWithString:@"我的"];
}

-(BOOL)navUIBaseViewControllerIsNeedNavBar:(DQMNavUIBaseViewController *)navUIBaseViewController
{
	return YES;
}

- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar
{
	return true;
}

- (UIView *)dqmNavigationBarRightView:(DQMNavigationBar *)navigationBar {
	self.messageButton = [UIButton initWithFrame:CGRectMake(kScreenWidth-56, STATUS_BAR_HEIGHT, 44, 44) buttonTitle:nil normalColor:QMTextColor cornerRadius:0 doneBlock:^(UIButton *sender) {
		NSLog(@"消息");
	}];
	[_messageButton setImage:[UIImage imageNamed:@"icon_dqm_msg"] forState:UIControlStateNormal];
	[_messageButton setImage:[UIImage imageNamed:@"icon_dqm_msg_select"] forState:UIControlStateSelected];
	return self.messageButton;
}
- (UIView *)dqmNavigationBarLeftView:(DQMNavigationBar *)navigationBar {
	self.settingButton = [UIButton initWithFrame:CGRectMake(10, STATUS_BAR_HEIGHT, 44, 44) buttonTitle:nil normalColor:QMTextColor cornerRadius:0 doneBlock:^(UIButton *sender) {
		NSLog(@"设置");
	}];
	[_settingButton setImage:[UIImage imageNamed:@"icon_dqm_setting"] forState:UIControlStateNormal];
	[_settingButton setImage:[UIImage imageNamed:@"icon_dqm_setting_select"] forState:UIControlStateSelected];
	return self.settingButton;
}


#pragma mark - statusBar
/**
 状态栏是否隐藏
 */
-(BOOL)prefersStatusBarHidden {
	return false;
}


/**
 状态栏样式  要想改变状态栏的颜色要在plist配置 View controller-based status bar appearance 为YES
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
	return _statusBarStyle;
}

/**
 状态栏变化动画效果:渐变
 */
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
	return UIStatusBarAnimationFade;
}

- (void)dealloc
{
	NSLog(@"remove");
	//用DQMstaticTableViewController要通知释放
	[[NSNotificationCenter defaultCenter] postNotificationName:DQMTableViewControllerDeallocNotification object:self];
}


#pragma mark - lazy load
-(NSMutableArray *)listDataArray {
	if (!_listDataArray) {
		_listDataArray = [[NSMutableArray alloc] init];
	}
	return _listDataArray;
}


@end
