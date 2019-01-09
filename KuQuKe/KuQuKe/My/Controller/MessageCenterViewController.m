//
//  MessageCenterViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "DQMImageTitleSubTitleAndArrowTableViewCell.h" //消息中心的cell
#import "MessageContentViewController.h"//消息详情

@interface MessageCenterViewController ()

/** 数据源 */
@property(nonatomic,strong) NSMutableArray          *listDataArray;

@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  //模拟请求
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    self.listDataArray = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    
    [UIView transitionWithView:self.tableView duration:0.35 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
      [self.tableView reloadData];
    } completion:^(BOOL finished) {
      
    }];
  });
  
}


#pragma mark - tableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [_listDataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //消息中心
  DQMImageTitleSubTitleAndArrowTableViewCell *cell = [DQMImageTitleSubTitleAndArrowTableViewCell cellWithTableView:tableView indexPath:indexPath andFixedHeightIfNeed:60 showArrow:true];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //信息详情页
  MessageContentViewController *vc = [[MessageContentViewController alloc] initWithTitle:@"消息详情"];
  [self.navigationController pushViewController:vc animated:true];
}


#pragma mark - load data
-(NSMutableArray *)listDataArray {
  if (!_listDataArray) {
    _listDataArray = [[NSMutableArray alloc] init];
  }
  return _listDataArray;
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
