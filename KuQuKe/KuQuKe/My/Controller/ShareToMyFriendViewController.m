//
//  ShareToMyFriendViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "ShareToMyFriendViewController.h"
#import "ShareToMyFriendImageTableViewCell.h"
#import "LeftAndRightLabelHeaderView.h"//组头
#import "DQMLabelSizeToFitTableViewCell.h"//自适应大小的cell
#import "ShareResultsTableViewCell.h"//我的成绩

@interface ShareToMyFriendViewController ()

@property(nonatomic,copy) NSDictionary *dataDic; /* 分享的数据 */


@end

@implementation ShareToMyFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self createUI];

  //分享的数据
  [KuQuKeNetWorkManager GET_shareInfoParams:[NSMutableDictionary new] View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
    
    self.dataDic = dataDic;
    [self.tableView reloadData];
    
  } unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
    
  } failure:^(NSError *error) {
    
  }];
	
	
}

#pragma mark - UI
-(void)createUI {
	//tableView样式调整
	UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/1154*821)];
	headerView.contentMode = UIViewContentModeScaleAspectFit;
	[headerView setImage:[UIImage imageNamed:@"sharetomyfriend"]];
	self.tableView.tableHeaderView = headerView;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.backgroundColor = UIColor.whiteColor;
	self.tableView.contentInset = UIEdgeInsetsMake(NAVIGATION_BAR_HEIGHT, 0, HOME_INDICATOR_HEIGHT+50, 0);
}





#pragma mark - tableView dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	NSArray *titleArray = @[@"邀请方式",@"我的成绩",@"活动规则"];
	LeftAndRightLabelHeaderView *heaerView = [[LeftAndRightLabelHeaderView alloc] initWithFrame:CGRectZero];
	heaerView.backgroundColor = UIColor.whiteColor;
	LeftAndRightLabelHeaderViewModel *heaerModel = [LeftAndRightLabelHeaderViewModel initWithleftString:titleArray[section] rightString:@""];
	heaerView.headerModel = heaerModel;
	return heaerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	return [UIView new];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		ShareToMyFriendImageTableViewCell *cell = [ShareToMyFriendImageTableViewCell cellWithTableView:tableView];
		if (_dataDic) {
			cell.codeLabel.text = [NSString stringWithFormat:@"我的邀请码:%@",_dataDic[@"data"][@"user_info"][@"share_code"]];
		}
    QMWeak(self);
    cell.copyCodeSuccess = ^{
      if (!_dataDic) {
         [weakself.view makeToast:@"复制失败"];
        return;
      }
      if (_dataDic[@"data"][@"user_info"][@"share_code"]) {
        [weakself.view makeToast:@"复制成功"];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard]; pasteboard.string = _dataDic[@"data"][@"user_info"][@"share_code"];
      }
    };
		return cell;
	} else if (indexPath.section == 1) {
		ShareResultsTableViewCell *cell = [ShareResultsTableViewCell cellWithTableView:tableView];
    if (_dataDic) {
      cell.dataDic = _dataDic;
    }
		return cell;
	} else if (indexPath.section == 2) {
		DQMLabelSizeToFitTableViewCell *cell = [DQMLabelSizeToFitTableViewCell cellWithTableView:tableView];
		cell.backgroundColor = UIColor.whiteColor;
    cell.contentText = [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:@"1: ios徒弟每做一个任务，师傅可得60%奖励;\n\n2: 安卓徒弟每做一个任务，师傅可得20%奖励;\n\n3: 酷趣客保留在法律法规许可的范围内调整奖励政策与佣金高低;" color:QMTextColor];
		[cell setLabelEdgeInsetTop:10 left:30 bottom:10 right:30];
		cell.showBackColorView = true;
		return cell;
	}
	
	UITableViewCell *cell = [[UITableViewCell alloc] init];
	return cell;
}






#pragma mark - dqm_navibar

- (NSMutableAttributedString *)dqmNavigationBarTitle:(DQMNavigationBar *)navigationBar {
	return [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:@"邀请好友" color:UIColor.whiteColor];
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
	[self.navigationController popViewControllerAnimated:true];
}

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
	return DQMMainColor;
}

@end
