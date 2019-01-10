//
//  SettingUsetInfoViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/10.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "SettingUsetInfoViewController.h"
#import "DQMRightImageViewTableViewCell.h"//右边头像或副标题
#import "DQMRigthSwitchTableViewCell.h"//右边选择按钮
#import "DQMDefaultTableViewCell.h"//默认cell用来写退出按钮
#import "UserDetailModel.h"//用户模型

#import "CompleteInformationViewController.h"//完善资料


@interface SettingUsetInfoViewController ()

/** 用户模型 */
@property(nonatomic,strong) UserDetailModel *userModel;

@end

@implementation SettingUsetInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.tableView.tableFooterView = [UIView new];
  
  
  //模拟请求    可能是要从数据库取出来
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    UserDetailModel *userModel = [[UserDetailModel alloc] init];
    userModel.name = @"测试";
    userModel.userId = @"1234";
    userModel.userface = @"http://tupian.qqjay.com/u/2017/1221/4_143339_4.jpg";
    userModel.balance = @"1";
    userModel.total = @"15";
    userModel.students = @"3";
    userModel.allowPushNotification = @"1";
    self.userModel = userModel;
    
    
    
    //返回主线程刷新界面
    dispatch_async(dispatch_get_main_queue(), ^{
      [UIView transitionWithView:self.tableView duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.tableView reloadData];
      } completion:nil];
    });
    
    
  });
  
}


#pragma mark - tableView dataSource
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  //返回1 3 1 1
  return section == 1 ? 3 : 1;
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
  if (indexPath.section == 0) {
    
    DQMRightImageViewTableViewCell *cell = [DQMRightImageViewTableViewCell cellWithTableView:tableView indexPath:indexPath andFixedHeightIfNeed:90 showArrow:true];
    DQMRightImageViewTableViewCellModel *model = [DQMRightImageViewTableViewCellModel initWithtitle:@"完善资料" andSubTitle:@"" andsubImageUrl:@"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=542856769,437986106&fm=173&app=25&f=JPEG?w=550&h=365&s=F59B1DD50C581AC24EB1113C03008073"];
    cell.model = model;
    return cell;
    
  } else if (indexPath.section == 1 && indexPath.row == 0) {
    
    DQMRigthSwitchTableViewCell *cell = [DQMRigthSwitchTableViewCell cellWithTableView:tableView indexPath:indexPath andFixedHeightIfNeed:56];
    cell.model = [DQMRigthSwitchTableViewCellModel initWithtitle:@"推送设置" andison:@"1"];
    return cell;
    
  } else if (indexPath.section == 1 && indexPath.row == 1) {
    
    DQMRightImageViewTableViewCell *cell = [DQMRightImageViewTableViewCell cellWithTableView:tableView indexPath:indexPath andFixedHeightIfNeed:58 showArrow:true];
    DQMRightImageViewTableViewCellModel *model = [DQMRightImageViewTableViewCellModel initWithtitle:@"清除缓存" andSubTitle:@"1.00M" andsubImageUrl:@""];
    cell.model = model;
    return cell;
    
  } else if (indexPath.section == 1 && indexPath.row == 2) {
    
    DQMRightImageViewTableViewCell *cell = [DQMRightImageViewTableViewCell cellWithTableView:tableView indexPath:indexPath andFixedHeightIfNeed:58 showArrow:true];
    DQMRightImageViewTableViewCellModel *model = [DQMRightImageViewTableViewCellModel initWithtitle:@"检测更新" andSubTitle:@"V4.1.1" andsubImageUrl:@""];
    cell.model = model;
    return cell;
    
  } else if (indexPath.section == 2) {
    
    DQMRightImageViewTableViewCell *cell = [DQMRightImageViewTableViewCell cellWithTableView:tableView indexPath:indexPath andFixedHeightIfNeed:58 showArrow:true];
    DQMRightImageViewTableViewCellModel *model = [DQMRightImageViewTableViewCellModel initWithtitle:@"关于我们" andSubTitle:@"" andsubImageUrl:@""];
    cell.model = model;
    return cell;
    
  } else if (indexPath.section == 3) {
    
    DQMDefaultTableViewCell *cell = [DQMDefaultTableViewCell cellWithTableView:tableView];
    [cell removeAllSubviews];
    UILabel *loginOutLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [cell addSubview:loginOutLabel];
    loginOutLabel.textAlignment = NSTextAlignmentCenter;
    QMLabelFontColorText(loginOutLabel, @"退出账号", DQMMainColor, 16);
    return cell;
    
  }
 
  UITableViewCell *cell = [[UITableViewCell alloc] init];
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"下标 %ld   %ld",indexPath.section,indexPath.row);
  
  if (indexPath.section == 0) {//修改资料
    CompleteInformationViewController *vc = [[CompleteInformationViewController alloc] initWithTitle:@"个人资料"];
    [self.navigationController pushViewController:vc animated:true];
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
