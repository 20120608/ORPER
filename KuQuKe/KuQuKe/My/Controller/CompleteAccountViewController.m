//
//  CompleteAccountViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/10.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "CompleteAccountViewController.h"
#import "DQMInputTextFieldTableViewCell.h"

@interface CompleteAccountViewController ()

/** 组的数组 */
@property(nonatomic,strong) NSMutableArray  *sectionsArray;

/** 电话 */
@property(nonatomic,copy) NSString          *mobile;
/** 电话 */
@property(nonatomic,copy) NSString          *firstCode;
/** 电话 */
@property(nonatomic,copy) NSString          *secondCode;
@end

@implementation CompleteAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.sectionsArray = [[NSMutableArray alloc] init];
	NSArray *titleArray = @[@"手机号",@"登录密码",@"确认登录"];
	NSArray *placeholdArray = @[@"请输入手机号",@"请输入登录密码",@"请确认登录密码"];
	for (int i = 0; i < 3; i++) {
		NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
		[dic setValue:titleArray[i] forKey:@"title"];
		[dic setValue:placeholdArray[i] forKey:@"placehold"];
		[_sectionsArray addObject:dic];
	}
	
	[KuQuKeNetWorkManager POST_bindPageParams:[NSMutableDictionary new] View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
		self.mobile = dataDic[@"data"][@"mobile"];
		[self.tableView reloadData];
		
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
	} failure:^(NSError *error) {
		
	}];
  
}

#pragma mark - dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	DQMInputTextFieldTableViewCell *cell = [DQMInputTextFieldTableViewCell cellWithTableView:tableView indexPath:indexPath FixedCellHeight:44];
	cell.titleLabel.text = self.sectionsArray[indexPath.row][@"title"];
	cell.contentTextField.placeholder = self.sectionsArray[indexPath.row][@"placehold"];
	cell.contentTextField.text = indexPath.row == 0 ? self.mobile : indexPath.row == 1 ? self.firstCode : self.secondCode;
	
	@weakify(self);
	[[[cell.contentTextField rac_newTextChannel] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(NSString *  _Nullable x) {
		@strongify(self);
		switch (indexPath.row) {
			case 0:
				self.mobile = x;
				break;
			case 1:
				self.firstCode = x;
				break;
			case 2:
				self.secondCode = x;
				break;
			default:
				break;
		}
		NSLog(@"%@", x);
	}];
	

	
	return cell;
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

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
  [self.navigationController popViewControllerAnimated:true];
}

- (UIView *)dqmNavigationBarRightView:(DQMNavigationBar *)navigationBar {
	UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
	QMSetButton(saveButton, @"保存", 15, nil, UIColor.whiteColor, UIControlStateNormal);
	return saveButton;
}

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
	
	if ([self.mobile length] == 0 || [self.firstCode length] == 0 || [self.secondCode length] == 0) {
		[self.view makeToast:@"请填写完整数据"];
		return;
	}
	
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	[params setValue:self.mobile forKey:@"mobile"];
	[params setValue:self.firstCode forKey:@"pswd"];
	[params setValue:self.secondCode forKey:@"pswd2"];

	[KuQuKeNetWorkManager POST_bindPostParams:params View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		[self.view makeToast:@"保存成功"];
		[self.view setUserInteractionEnabled:false];
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self.navigationController popViewControllerAnimated:true];
		});
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
	} failure:^(NSError *error) {
		
	}];
}

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
  return DQMMainColor;
}

@end
