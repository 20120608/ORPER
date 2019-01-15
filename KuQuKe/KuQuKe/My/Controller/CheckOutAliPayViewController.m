//
//  CheckOutAliPayViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/13.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "CheckOutAliPayViewController.h"
#import "CheckOutCollectionView.h"//选择金额

@interface CheckOutAliPayViewController () <CheckOutCollectionViewDelegate>

/** 用户选择要提现的金额 默认20元 */
@property(nonatomic,copy) NSString          *withdrawalMoney;

@end

@implementation CheckOutAliPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.withdrawalMoney = CheckOutMoneyArray[0];
	self.view.backgroundColor = QMBackColor;
	
  
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		
		[self createUI];
		
	});
	
}

- (void)createUI {
	
	CheckOutCollectionView *moneyView = [[CheckOutCollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+20, kScreenWidth, 360)];
	moneyView.delegate = self;
	[self.view addSubview:moneyView];
	
}

#pragma mark - delegate
- (void)CheckOutCollectionView:(CheckOutCollectionView *)checkView didSelectButton:(nonnull UIButton *)button {
  NSLog(@"用户点击了%@元",CheckOutMoneyArray[button.tag]);
  self.withdrawalMoney = CheckOutMoneyArray[button.tag];//触发订阅
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

- (UIView *)dqmNavigationBarRightView:(DQMNavigationBar *)navigationBar {
	UILabel *myBalanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 44)];
	myBalanceLabel.font = kQmFont(13);
	myBalanceLabel.textColor = UIColor.whiteColor;
	myBalanceLabel.textAlignment = NSTextAlignmentRight;
	myBalanceLabel.text = @"余额:00.00元";
	return myBalanceLabel;
}

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
	
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
	[self.navigationController popViewControllerAnimated:true];
}

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
	return DQMMainColor;
}

@end
