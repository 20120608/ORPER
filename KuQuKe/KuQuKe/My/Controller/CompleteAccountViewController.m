//
//  CompleteAccountViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/10.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "CompleteAccountViewController.h"

@interface CompleteAccountViewController ()

@end

@implementation CompleteAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  
  self.addItem([StaticListItem itemAdditionalExtensionWithTitle:@"手机号" subTitle:@"" extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
    
  }])
  .addItem([StaticListItem itemAdditionalExtensionWithTitle:@"登入密码" subTitle:@"" extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
    
  }])
  .addItem([StaticListItem itemAdditionalExtensionWithTitle:@"确认密码" subTitle:@"" extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
    
  }]);
  
}

#pragma mark - dataSource

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
