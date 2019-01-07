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

@interface HomeViewController () <DQMHorizontalViewScrollerViewDataSource>
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
}

- (void)viewWillDisappear:(BOOL)animated {
	_barStyle = UIStatusBarStyleDefault;
	[self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];

  [self createUI];
  
  
//  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    CheckInViewController *vc = [[CheckInViewController alloc] initWithTitle:@"每日签到"];
//    [self.navigationController pushViewController:vc animated:true];
//  });
  
  QMWeak(self);
  //广告请求数据
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
	  
	  //订阅余额
	  self.myMoney = @"1";
	  
    [weakself.advScrollView reloadData];
//    https://www.jianshu.com/p/46bcfcf53055
  });
	
	
	
	
	

}

#pragma mark - UI
-(void)createUI {
	
	[self DIYNavibar];//导航栏部分
	
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
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//	return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//	return 20;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	TaskTableViewCell *cell = [TaskTableViewCell cellWithTableView:tableView initWithCellStyle:TaskTableViewCellStyleSubTag indexPath:indexPath andFixedHeightIfNeed:AdaptedHeight(68)];
//
//	return cell;
//}





#pragma mark - DQMHorizontalViewScrollerViewDataSource
- (NSArray *)horizontalViewScrollViewDataArray:(DQMHorizontalViewScrollerView *)horizontalScrollView
{
  return @[@{@"name":@"我是你的什么"},@{@"name":@"会吹牛逼的小明"},@{@"name":@"haliluya"},@{@"name":@"移动ATM"},@{@"name":@"下一个天亮"}];
}



#pragma mark - dqm_navibar
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(DQMNavUIBaseViewController *)navUIBaseViewController {
	return false;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
	return _barStyle;
}



@end
