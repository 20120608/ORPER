//
//  CompleteInformationViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/10.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "CompleteInformationViewController.h"
#import "UserDetailModel.h"
#import "DQMRightImageViewTableViewCell.h"
#import "DQMDefaultTableViewCell.h"
#import "SettingUserInfoWithInputViewController.h"//带输入框的编辑
#import "SettingUserInfoWithTableViewController.h"//带选择列表的编辑

@interface CompleteInformationViewController ()
/** 用户模型 */
@property(nonatomic,strong) UserDetailModel *userModel;
/** 组的数组 */
@property(nonatomic,strong) NSMutableArray  *sectionsArray;

@end

@implementation CompleteInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.tableView.tableFooterView = [UIView new];
  
  
  //模拟请求    可能是要从数据库取出来
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    UserDetailModel *userModel = [[UserDetailModel alloc] init];
    userModel.name = @"测试名称";
    userModel.userId = @"1234";
    userModel.userface = @"http://tupian.qqjay.com/u/2017/1221/4_143339_4.jpg";
    userModel.balance = @"1";
    userModel.total = @"15";
    userModel.students = @"3";
    userModel.allowPushNotification = @"1";
    
    userModel.weChat = @"QM22231213";
    userModel.nickName = @"测试昵称";
    userModel.QQ = @"946067151";
    userModel.phone = @"18659740507";
    userModel.job = @"工作";
    userModel.birthday = @"生日";
    userModel.sex = @"0";
    
    self.userModel = userModel;
    
    
    
    //处理数据  必须保证没有字段为空  可以给@“”
    [self createSectionsDataArray];
    
    
    
    //返回主线程刷新界面
    dispatch_async(dispatch_get_main_queue(), ^{
      [UIView transitionWithView:self.tableView duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.tableView reloadData];
      } completion:nil];
    });
    
    
  });
  
}

//组装cell的数据源
- (void)createSectionsDataArray {
  if (_userModel == nil) {
    [self.view makeToast:@"请先登入!"];
    return;
  }
  
  
  self.sectionsArray = [[NSMutableArray alloc] init];
  NSArray *titleArray = @[@[@"上传头像"],@[@"昵称",@"性别",@"出生日期"],@[@"职业",@"微信号",@"QQ",@"手机号"]];
  NSArray *subtitleArray = @[@[@""],@[_userModel.nickName,_userModel.sex,_userModel.birthday],@[_userModel.job,_userModel.weChat,_userModel.QQ,_userModel.phone]];
  NSArray *subImageArray = @[@[_userModel.userface],@[@"",@"",@""],@[@"",@"",@"",@""]];
  //对应跳转的界面 0 为不跳转
  NSArray *destVcArray = @[@[[UIViewController class]],@[[SettingUserInfoWithInputViewController class],[SettingUserInfoWithTableViewController class],[UIViewController class]],@[[SettingUserInfoWithTableViewController class],[SettingUserInfoWithInputViewController class],[SettingUserInfoWithInputViewController class],[SettingUserInfoWithInputViewController class]]];
  //样式的数组
  NSArray *viewTpyeArray = @[@[@(0)],@[@(SettingInputStyleNickName),@(SettingTableStyleSex),@(0)],@[@(SettingTableStyleJob),@(SettingInputStyleWeChat),@(SettingInputStyleQQ),@(SettingInputStylePhone)]];
  
  for (int i = 0; i < 3; i++) {
    NSMutableArray<DQMRightImageViewTableViewCellModel *> *itemArray = [[NSMutableArray alloc] init];
    for (int j = 0; j < [titleArray[i] count]; j++) {
      DQMRightImageViewTableViewCellModel *item = [DQMRightImageViewTableViewCellModel initWithtitle:titleArray[i][j] andSubTitle:subtitleArray[i][j] andsubImageUrl:subImageArray[i][j] IfNeedCreateWithdestVc:destVcArray[i][j] andviewType:[viewTpyeArray[i][j] integerValue]];
      [itemArray addObject:item];
    }
    [_sectionsArray addObject:itemArray];
  }
  
  NSLog(@"11111");
}



#pragma mark - tableView dataSource
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return [_sectionsArray count] + 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  //返回1 3 1 1
  return section == 1 ? 3 : section == 2 ? 4 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
  return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section != 3) {
    CGFloat cellHeight = indexPath.section == 0 ? 90 : 58;
    DQMRightImageViewTableViewCell *cell = [DQMRightImageViewTableViewCell cellWithTableView:tableView indexPath:indexPath andFixedHeightIfNeed:cellHeight showArrow:true];
    cell.model = self.sectionsArray[indexPath.section][indexPath.row];
    return cell;
   
  } else if (indexPath.section == 3) {
    
    DQMDefaultTableViewCell *cell = [DQMDefaultTableViewCell cellWithTableView:tableView];
    [cell removeAllSubviews];
    UILabel *loginOutLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [cell addSubview:loginOutLabel];
    loginOutLabel.textAlignment = NSTextAlignmentCenter;
    QMLabelFontColorText(loginOutLabel, @"提交", DQMMainColor, 16);
    return cell;
    
  }
  
  UITableViewCell *cell = [[UITableViewCell alloc] init];
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"下标 %ld   %ld",indexPath.section,indexPath.row);
  
  if (indexPath.section == 3) {
    //退出
    
  }
  
  else if (indexPath.section == 0) {
    //头像
    
  }
  
  else if (indexPath.section == 1 && indexPath.row == 2) {
    //生日
  }
  
  
  else {
    //跳转二级设置界面
    DQMRightImageViewTableViewCell *cell = (DQMRightImageViewTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIViewController *vc = [[cell.model.destVc alloc] init];
    if ([vc isKindOfClass:[SettingUserInfoWithInputViewController class]]) {
      
      SettingUserInfoWithInputViewController *inputvc = (SettingUserInfoWithInputViewController *)vc;
      inputvc.settingInputStyle = cell.model.viewType;
      [self.navigationController pushViewController:inputvc animated:true];

      
    } else if ([vc isKindOfClass:[SettingUserInfoWithTableViewController class]]) {
      SettingUserInfoWithTableViewController *inputvc = (SettingUserInfoWithTableViewController *)vc;
      inputvc.settingTableStype = cell.model.viewType;
      [self.navigationController pushViewController:inputvc animated:true];
    }
  }
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

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
  return DQMMainColor;
}


@end
