//
//  CheckOutAliPayViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/13.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "CheckOutAliPayViewController.h"

@interface CheckOutAliPayViewController () <CheckOutCollectionViewDelegate>

/** 用户选择要提现的金额 默认20元 */
@property(nonatomic,copy) NSString  *withdrawalMoney;

@property(nonatomic,strong) NSArray *moneyArray; /* 可选的数组 */

@property(nonatomic,copy) NSString  *myMoneyString; /* 余额 */


@end

@implementation CheckOutAliPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  	self.withdrawalMoney = @"0";
	self.view.backgroundColor = QMBackColor;
	
}

- (void)setCheckOutThreePartType:(CheckOutThreePartType)checkOutThreePartType {
  _checkOutThreePartType = checkOutThreePartType;
	
	[self isWithdrawal:checkOutThreePartType];
	
}

//判断是否可以申请
- (void)isWithdrawal:(CheckOutThreePartType)checkOutThreePartType {
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	[params setValue:checkOutThreePartType == CheckOutThreePartTypeAliPay ? @"1" : @"2" forKey:@"type"];
	[KuQuKeNetWorkManager POST_isWithdrawalParams:params View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		NSArray *dataArray = dataDic[@"data"][@"money_list"];
		NSMutableArray *moneyArray = [[NSMutableArray alloc] init];
		for(int i = 0; i < [dataArray count]; i++){
			if(i < 12){
				[moneyArray addObject:dataArray[i]];
			}
		}
		self.moneyArray = moneyArray;
		self.myMoneyString = dataDic[@"data"][@"money"];
		if ([self.moneyArray count]) {
			[self createUI];
		}
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
	} failure:^(NSError *error) {
		
	}];
}

- (void)createUI {
	
	CheckOutCollectionView *moneyView = [[CheckOutCollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+20, kScreenWidth, 360)];
	moneyView.delegate = self;
  	moneyView.checkOutThreePartType = _checkOutThreePartType;
	moneyView.moneyArray = _moneyArray;
	moneyView.myBalane = _myMoneyString;
	[self.view addSubview:moneyView];
	
}

#pragma mark - delegate
- (void)CheckOutCollectionView:(CheckOutCollectionView *)checkView didSelectButton:(nonnull UIButton *)button {
  NSLog(@"用户点击了%@元",_moneyArray[button.tag]);
  self.withdrawalMoney = _moneyArray[button.tag];//触发订阅

}

- (void)CheckOutCollectionView:(CheckOutCollectionView *)checkView didSelectSure:(UIButton *)button  DataDictionary:(NSMutableDictionary *)dataDictionary {
	
	NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:dataDictionary];
	[params setValue:_checkOutThreePartType == CheckOutThreePartTypeAliPay ? @"1":@"2" forKey:@"type"];
	[params setValue:[_withdrawalMoney length] == 0 ? @"0":_withdrawalMoney forKey:@"price"];
	
	[KuQuKeNetWorkManager POST_withdrawalParams:params View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		[self.view makeToast:@"申请成功"];
		[self.view setUserInteractionEnabled:false];
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self.navigationController popViewControllerAnimated:true];
		});
		
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
	} failure:^(NSError *error) {
		
	}];
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
	myBalanceLabel.text = @"余额:00.00元  ";
	[[RACObserve(self, myMoneyString) skip: 1] subscribeNext:^(NSString *  _Nullable x) {
		myBalanceLabel.text = [NSString stringWithFormat:@"余额:%.2lf元  ", [x floatValue]];
	}];
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
