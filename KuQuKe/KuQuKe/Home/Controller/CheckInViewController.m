//
//  CheckInViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/6.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "CheckInViewController.h"
#import "ZJCalenderView.h"//自己改的日历
#import "ChickInHeaderView.h"//顶部签到
#import "ChickSuccessAlertView.h"//成功弹窗

@interface CheckInViewController () <ChickInHeaderViewDelegate>

@end

@implementation CheckInViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = UIColor.whiteColor;
	
	[self createHeaderView];
	
	

}

#pragma mark - UI
/**
 实际视图
 */
- (void)createHeaderView {

	
	ChickInHeaderView *headerView = [[ChickInHeaderView alloc] initWithFrame:CGRectZero];
	headerView.delegate = self;
	[self.view addSubview:headerView];
	[headerView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
		make.left.mas_equalTo(0);
		make.width.mas_equalTo(kScreenWidth);
		make.height.mas_equalTo(kScreenHeight-(ZJCalenderWidth/286*292)-100-NAVIGATION_BAR_HEIGHT);
	}];
				

	ZJCalenderView *zjCalenderview = [[ZJCalenderView alloc] initWithFrame:CGRectMake(35, 400, ZJCalenderWidth, ZJCalenderWidth/286*292) calenderMode:ZJCalenderModePartScreen];
	zjCalenderview.selectedEnable = false;
	[self.view addSubview:zjCalenderview];
	[zjCalenderview mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(headerView.mas_bottom).offset(20);
		make.left.mas_equalTo(25);
		make.right.mas_equalTo(-25);
		make.height.mas_equalTo(ZJCalenderPartScreenHeight);
	}];
	
	UIImageView *bindImageView = ({
		UIImageView *imageView = [[UIImageView alloc] init];
		[self.view addSubview: imageView];
		[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(self.view.mas_centerX);
			make.centerY.mas_equalTo(zjCalenderview.mas_top).offset(-5);
			make.size.mas_equalTo(CGSizeMake(kScreenWidth-200, 40));
			
		}];
		imageView;
	});
	QMSetImage(bindImageView, @"qd02");

	
}


#pragma mark - status AlertView
-(void)showCheckInStatusView {
	
	ChickSuccessAlertView *successView = [[ChickSuccessAlertView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, kScreenHeight)];
	[self.view addSubview:successView];
	successView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.6];
	QMWeak(successView);
	successView.ChickSuccessAlertViewBlock = ^(NSInteger index) {
		[weaksuccessView removeFromSuperview];
	};
}


#pragma mark - 签到按钮
- (void)ChickInHeaderView:(ChickInHeaderView *)headerView didDidseleted:(NSInteger)index {
	NSLog(@"签到按钮");
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self showCheckInStatusView];
	});
}


#pragma mark - dqm_navibar
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar {
	return true;
}

- (NSMutableAttributedString *)dqmNavigationBarTitle:(DQMNavigationBar *)navigationBar {
	return [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:@"每日签到" color:QMTextColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleDefault;
}

/** 导航条左边的按钮 */
- (UIImage *)dqmNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(DQMNavigationBar *)navigationBar {
	[leftButton setImage:[UIImage imageNamed:@"NavgationBar_blue_back"] forState:UIControlStateHighlighted];
	return [UIImage imageNamed:@"NavgationBar_blue_back"];
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
	[self.navigationController popViewControllerAnimated:true];
}


@end
