//
//  CheckInViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/6.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "CheckInViewController.h"
#import "ZJCalenderView.h"//自己改的日历
@implementation CheckInViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self createHeaderView];
	
	

}

#pragma mark - UI
/**
 实际视图
 */
- (void)createHeaderView {

	UIView *buttonBackView = ({
		UIView *view = [[UIView alloc] init];
		[self.view addSubview: view];
		[view setGradientBackgroundWithColors:@[QMHexColor(@"88ec9b"), QMHexColor(@"5bbd7d")] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
			make.width.mas_equalTo(kScreenWidth);
			make.height.mas_equalTo(kScreenWidth/1125*818);
		}];
		view;
	});
	
	UIButton *checkInButton = ({
		UIButton *button = [[UIButton alloc] init];
		[self.view addSubview:button];
		[button setBackgroundImage:[UIImage imageNamed:@"qd01"] forState:UIControlStateNormal];
		[button addTarget:self action:@selector(checkInButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		[button mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(self.view.mas_centerX);
			make.centerY.mas_equalTo(buttonBackView.mas_centerY);
			make.size.mas_equalTo(CGSizeMake(130, 130));
		}];
		button;
	});
	
	UILabel *checkInLabel = ({
		UILabel *label = [[UILabel alloc] init];
		[checkInButton addSubview:label];
		label.numberOfLines = 0;
		label.font = [UIFont boldSystemFontOfSize:20];
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerY.mas_equalTo(checkInButton.mas_centerY);
			make.centerX.mas_equalTo(checkInButton.mas_centerX);
		}];
		label;
	});
	QMLabelFontColorText(checkInLabel, @"点击\n签到", DQMMainColor, 20);

	
	
	UILabel *titleLabel = ({
		UILabel *label = [[UILabel alloc] init];
		[buttonBackView addSubview:label];
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(self.view.mas_centerX);
			make.bottom.mas_equalTo(checkInButton.mas_top).offset(-30);
		}];
		label;
	});
	QMLabelFontColorText(titleLabel, @"每日签到", UIColor.whiteColor, 20);


	UIView *shadowView = ({
		UIView *view = [[UIView alloc] init];
		[self.view addSubview: view];
		view.layer.shadowOffset =CGSizeMake(1,3);
		view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
		view.layer.shadowRadius = 6;
		view.layer.shadowOpacity = 2;
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(buttonBackView.mas_bottom).offset(20);
			make.left.mas_equalTo(35);
			make.right.mas_equalTo(-35);
			make.height.mas_equalTo(ZJCalenderPartScreenHeight);
		}];
		view;
	});
	shadowView.backgroundColor = UIColor.whiteColor;

	ZJCalenderView *view = [[ZJCalenderView alloc] initWithFrame:CGRectMake(35, 400, kScreenWidth-70, (kScreenWidth-70)/286*292) calenderMode:ZJCalenderModePartScreen];
	view.selectedEnable = false;
	[self.view addSubview:view];
	[view mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(buttonBackView.mas_bottom).offset(20);
		make.left.mas_equalTo(35);
		make.right.mas_equalTo(-35);
		make.height.mas_equalTo(ZJCalenderPartScreenHeight);
	}];
	
}


#pragma mark - touch event
- (void)checkInButtonClick:(UIButton *)sender {
	
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
