//
//  MyViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/6.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "MyViewController.h"
#import "DQMImageAndArrowTableViewCell.h"//常见cell
#import "DQMExpandHeader.h"//顶部
#import "DQMExpandImageView.h"//纯绿色背景会放大
#import "MessageCenterViewController.h"//消息中心
#import "UserDetailModel.h"//用户模型
#import "MyMoneyAndStdentsView.h"//用户余额和学徒
#import "SettingUsetInfoViewController.h"//设置
#import "CompleteAccountViewController.h"//完善账号
#import "AboutUSViewController.h"//关于我们
#import "CustomerServiceOfQQViewController.h"//QQ客服二维码
#import "ShareToMyFriendViewController.h"//分享给朋友
#import "MyBalanceCheckOutView.h"//余额弹窗
#import "CheckOutAliPayViewController.h"//兑换到支付宝


#define HEADER_TOP 330 //滚动到多少导航栏变不透明

@interface MyViewController () <MyMoneyAndStdentsViewDelegate,MyBalanceCheckOutViewDelegate>
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
/** 用户模型 */
@property(nonatomic,strong) UserDetailModel   *userModel;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.tableView.contentInset = UIEdgeInsetsMake(NAVIGATION_BAR_HEIGHT, 0, TAB_BAR_HEIGHT, 0);
	
	//创建界面
	[self createUI];
	
	[self loadTableViewListData];

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		UserDetailModel *userModel = [[UserDetailModel alloc] init];
		userModel.name = @"测试";
		userModel.userId = @"1234";
		userModel.userface = @"http://tupian.qqjay.com/u/2017/1221/4_143339_4.jpg";
		userModel.balance = @"1";
		userModel.total = @"15";
		userModel.students = @"3";
		self.userModel = userModel;
	});
	
}

#pragma mark - createUI
- (void)createUI {
	UIEdgeInsets edgeInsets = self.tableView.contentInset;
	edgeInsets.top -= NAVIGATION_BAR_HEIGHT;
	self.tableView.contentInset = edgeInsets;
	self.tableView.backgroundColor = QMBackColor;
	
	_statusBarStyle = UIStatusBarStyleLightContent;

	UIImageView *expandImageView = [[DQMExpandImageView alloc] initWithImage:[UIImage imageNamed:@"img_header"]];
	expandImageView.height = HEADER_TOP;
	expandImageView.width = kScreenWidth;
	expandImageView.backgroundColor = DQMMainColor;
	expandImageView.userInteractionEnabled = true;
	_expandHander = [DQMExpandHeader expandWithScrollView:self.tableView expandView:expandImageView];
	
	UIImageView *headerImageView = [[UIImageView alloc] init];
	QMSetImage(headerImageView, @"my_header_bg");
	[expandImageView addSubview:headerImageView];
	[headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(expandImageView);
		make.bottom.mas_equalTo(expandImageView.mas_bottom);
		make.height.mas_equalTo(kScreenWidth/1127*827);
	}];
	
	UIView *whiteBackView = ({
		UIView *view = [[UIView alloc] init];
		[expandImageView addSubview: view];
		view.userInteractionEnabled = true;
		view.backgroundColor = UIColor.whiteColor;
		view.layer.shadowOffset =CGSizeMake(1,2);
		view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
		view.layer.shadowRadius = 5;
		view.layer.shadowOpacity = 2;
		view.layer.cornerRadius = 5;
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(self.view);
			make.bottom.mas_equalTo(expandImageView.mas_bottom).offset(-20);
			make.height.mas_equalTo(110);
			make.left.mas_equalTo(20);
		}];
		view;
	});
	
	//余额 总收益 学徒的视图  同样订阅用户信息 
	MyMoneyAndStdentsView *balanceAndStudentView = [[MyMoneyAndStdentsView alloc] initWithFrame:CGRectZero];
	balanceAndStudentView.delegate = self;
	QMViewBorderRadius(balanceAndStudentView, 5, 0, DQMMainColor);
	[expandImageView addSubview:balanceAndStudentView];
	[balanceAndStudentView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(whiteBackView);
	}];
	
	UIImageView *userFaceImageView = ({
		UIImageView *imageView = [[UIImageView alloc] init];
		[expandImageView addSubview: imageView];
		QMSetImage(imageView, @"001");
		QMViewBorderRadius(imageView, 50, 2, UIColor.whiteColor);
		[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(self.view.mas_centerX);
			make.size.mas_equalTo(CGSizeMake(100, 100));
			make.bottom.mas_equalTo(whiteBackView.mas_top).offset(-50);
		}];
		imageView;
	});
	
	UILabel *userIDLabel = ({
		UILabel *label = [[UILabel alloc] init];
		[expandImageView addSubview:label];
		QMLabelFontColorText(label, @"ID:____", UIColor.whiteColor, 15);
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(userFaceImageView.mas_centerX);
			make.top.mas_equalTo(userFaceImageView.mas_bottom).offset(15);
		}];
		label;
	});
	
	//订阅用户信息的改变
	[RACObserve(self, userModel) subscribeNext:^(UserDetailModel *x) {
		//余额等
		balanceAndStudentView.userModel = x;

		//头像和id
		if (x != nil) {
			userIDLabel.text = [NSString stringWithFormat:@"ID: %@",x.userId];
		} else {
			userIDLabel.text = [NSString stringWithFormat:@"ID: __"];
		}
		if (x.userface != nil) {
			[userFaceImageView sd_setImageWithURL:[NSURL URLWithString:x.userface] placeholderImage:[UIImage imageNamed:@"userface"]];
		} else {
			[userFaceImageView setImage:[UIImage imageNamed:@"userface"]];
		}
	}];
	
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 8)];
	footerView.backgroundColor = QMBackColor;
	return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	DQMImageAndArrowTableViewCell *cell = [DQMImageAndArrowTableViewCell cellWithTableView:tableView andIndexPath:indexPath andFixedCellHeight:56];
	cell.teamModel = self.listDataArray[indexPath.section][indexPath.row];
	return cell;
}


#pragma mark - tableView delegate
/**
 列表点击事件
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.section == 0 && indexPath.row == 0) {
    CompleteAccountViewController *vc = [[CompleteAccountViewController alloc] initWithTitle:@"账号安全"];
    [self.navigationController pushViewController:vc animated:true];
  } else if (indexPath.section == 0 && indexPath.row == 1) {
	  CustomerServiceOfQQViewController *vc = [[CustomerServiceOfQQViewController alloc] initWithTitle:@"QQ客服群"];
	  [self.navigationController pushViewController:vc animated:true];
  }else if (indexPath.section == 0 && indexPath.row == 2) {
	  ShareToMyFriendViewController *vc = [[ShareToMyFriendViewController alloc] initWithStyle:UITableViewStyleGrouped];
	  [self.navigationController pushViewController:vc animated:true];
  } else if (indexPath.section == 1 && indexPath.row == 0) {
	  AboutUSViewController *vc = [[AboutUSViewController alloc] initWithTitle:@"关于酷趣客"];
	  [self.navigationController pushViewController:vc animated:true];
  } else {
	  
  }
  
}

#pragma mark - myMoneyAndStdentsView Delegate
/**
 菜单点击事件
 */
- (void)myMoneyAndStdentsView:(MyMoneyAndStdentsView *)menuView destVc:(Class)destVc didSelect:(NSInteger)index {
	if (index == 0) {
		//提现
		MyBalanceCheckOutView *checkOutView = [[MyBalanceCheckOutView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [[UIApplication sharedApplication].keyWindow addSubview:checkOutView];
		checkOutView.delegete = self;
		[checkOutView showAnimation];
	}
	else {
		UIViewController *vc = [[destVc alloc] init];
		[self.navigationController pushViewController:vc animated:true];
	}
}

- (void)MyBalanceCheckOutView:(MyBalanceCheckOutView *)checkOutView didSelected:(NSInteger)index {
	if (index == 1) {
		CheckOutAliPayViewController *vc = [[CheckOutAliPayViewController alloc] initWithTitle:@"兑换支付宝"];
		[self.navigationController pushViewController:vc animated:true];
	}
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
	QMWeak(self);
	self.messageButton = [UIButton initWithFrame:CGRectMake(kScreenWidth-56, STATUS_BAR_HEIGHT, 44, 44) buttonTitle:nil normalColor:QMTextColor cornerRadius:0 doneBlock:^(UIButton *sender) {
		NSLog(@"消息");
		MessageCenterViewController *vc = [[MessageCenterViewController alloc] initWithTitle:@"消息中心"];
		[weakself.navigationController pushViewController:vc animated:true];
	}];
	[_messageButton setImage:[UIImage imageNamed:@"icon_dqm_msg"] forState:UIControlStateNormal];
	[_messageButton setImage:[UIImage imageNamed:@"icon_dqm_msg_select"] forState:UIControlStateSelected];
	return self.messageButton;
}
- (UIView *)dqmNavigationBarLeftView:(DQMNavigationBar *)navigationBar {
	QMWeak(self);
	self.settingButton = [UIButton initWithFrame:CGRectMake(10, STATUS_BAR_HEIGHT, 44, 44) buttonTitle:nil normalColor:QMTextColor cornerRadius:0 doneBlock:^(UIButton *sender) {
		NSLog(@"设置");
		SettingUsetInfoViewController *vc = [[SettingUsetInfoViewController alloc] initWithTitle:@"设置中心"];
		[weakself.navigationController pushViewController:vc animated:true];
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
