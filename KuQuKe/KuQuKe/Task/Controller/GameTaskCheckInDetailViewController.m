//
//  GameTaskCheckInDetailViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/19.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "GameTaskCheckInDetailViewController.h"
#import "DQMExpandHeader.h"//顶部
#import "DQMExpandImageView.h"//纯绿色背景会放大
#import "GameTaskCheckInTableViewCell.h"//第一个cell

#define HEADER_TOP AdaptedWidth([UIScreen mainScreen].bounds.size.width)/1125*670 //滚动到多少导航栏变不透明


@interface GameTaskCheckInDetailViewController ()
{
  NSTimer * _timer;
  
}
@property (nonatomic, strong) DQMExpandHeader *expandHander;

/** 第一个cell的模型 带有滚动的 */
@property(nonatomic,strong) GameTaskCheckInTableViewCellModel          *first_model;

@end

@implementation GameTaskCheckInDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  [self createUI];
  
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
      [dataArray addObjectsFromArray:@[@{@"name":@"186****1234的客户赚了10元,获得厦门一日游"},@{@"name":@"186****1234的客户赚了10元"},@{@"name":@"186****1234的客户刚刚签到成功获得100元现金抵用券"},@{@"name":@"186****1234的客户赚了0.02元"},@{@"name":@"186****1234的客户赚了1元"}]];
    }
    self.first_model = [[GameTaskCheckInTableViewCellModel alloc] init];
    _first_model.historyArray = dataArray;
    [self.tableView reloadData];
    [UIView transitionWithView:self.tableView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
      self.tableView.hidden = false;
    } completion:^(BOOL finished) {
      [self setMoveSpeed:2];
    }];
  });
  
}


#pragma mark - createUI
- (void)createUI {
  self.tableView.hidden = true;//请求成功后再显示
  self.tableView.tableFooterView = [UIView new];
  self.tableView.backgroundColor = QMBackColor;
  
  UIImageView *expandImageView = [[DQMExpandImageView alloc] initWithImage:[UIImage imageNamed:@"temp_game_task_header"]];
  expandImageView.height = HEADER_TOP;
  expandImageView.width = kScreenWidth;
  expandImageView.backgroundColor = DQMMainColor;
  expandImageView.userInteractionEnabled = true;
  expandImageView.contentMode = UIViewContentModeScaleAspectFit;
  _expandHander.headerView.backgroundColor = QMBackColor;
  _expandHander = [DQMExpandHeader expandWithScrollView:self.tableView expandView:expandImageView];
  
  
  UIImageView *imageView = [[UIImageView alloc] init];
  QMViewBorderRadius(imageView, 14, 2, UIColor.whiteColor);
  QMSetImage(imageView, @"pkq");
  [self.tableView addSubview:imageView];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(20);
    make.top.mas_equalTo(-20);//固定80会有错
    make.size.mas_equalTo(CGSizeMake(AdaptedWidth(100), AdaptedWidth(100)));
  }];
  
}



#pragma mark - tableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _first_model == nil ? 0 : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  GameTaskCheckInTableViewCell *cell = [GameTaskCheckInTableViewCell cellWithTableView:tableView indexPath:indexPath FixedCellHeight:167];
  cell.cellModel = _first_model;
  return cell;
}




#pragma mark - NSTimer
-(void)setMoveSpeed:(CGFloat)speed{
  CGFloat timeInterval = speed;
  [_timer invalidate];
  _timer = nil;
  _timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(contentMove) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)contentMove {
  NSLog(@"定时器执行!!!!!!!");
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
   [super willMoveToParentViewController:parent];
  NSLog(@"执行了 willMoveToParentViewController ");
  [_timer invalidate];
  _timer = nil;
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
