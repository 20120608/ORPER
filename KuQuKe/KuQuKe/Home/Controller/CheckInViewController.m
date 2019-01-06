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
	
	[self createTableHeaderView];
	
	

}

#pragma mark - UI
/**
 实际视图
 */
- (void)createTableHeaderView {

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




#pragma mark - dqm_navibar
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar {
	return true;
}

- (UIImage *)dqmNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(DQMNavigationBar *)navigationBar {
	[leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];
	return [UIImage imageNamed:@"NavgationBar_blue_back"];
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
	[self.navigationController popViewControllerAnimated:YES];
}

@end
