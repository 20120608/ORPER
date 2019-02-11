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
#import "GameTaskDetailStepTableViewCell.h"//第二个cell

#define HEADER_TOP AdaptedWidth([UIScreen mainScreen].bounds.size.width)/1125*670 //滚动到多少导航栏变不透明


@interface GameTaskCheckInDetailViewController ()
{
  NSTimer * _timer;
  
}
@property (nonatomic, strong) DQMExpandHeader                   *expandHander;

/** 第一个cell的模型 带有滚动的 */
@property (nonatomic,strong ) GameTaskCheckInTableViewCellModel *first_model;

/** 第二个cell的模型 带有不固定数量的步骤 */
@property (nonatomic,strong ) GameTaskDetailStepTableViewCellModel *second_model;

@end

@implementation GameTaskCheckInDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  [self createUI];
  
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
      [dataArray addObjectsFromArray:@[@{@"name":@"186****1234的客户赚了10元,获得厦门一日游"},@{@"name":@"186****1234的客户赚了10元"},@{@"name":@"186****1234的客户刚刚签到成功获得100元现金抵用券"},@{@"name":@"186****1234的客户赚了0.02元"},@{@"name":@"186****1234的客户赚了1元"}]];
    }
    GameTaskCheckInTableViewCellModel *first_model = [[GameTaskCheckInTableViewCellModel alloc] init];
    first_model.historyArray = dataArray;
    first_model.imageUrl = @"http://c.hiphotos.baidu.com/baike/pic/item/d1a20cf431adcbefd4018f2ea1af2edda3cc9fe5.jpg";
    first_model.name = @"现金大派送";
    first_model.taskTime = @"2019年01月23日09:27:02";
    first_model.price = @"1234.56";
    self.first_model = first_model;//这会触发图标设置
    
    GameTaskDetailStepTableViewCellModel *second_model = [[GameTaskDetailStepTableViewCellModel alloc] init];
    second_model.stepMArray = [[NSMutableArray alloc] initWithArray:@[@{},@{},@{}]];
    self.second_model = second_model;
    [self.tableView reloadData];
    
    [UIView transitionWithView:self.tableView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
      self.tableView.hidden = false;
    } completion:^(BOOL finished) {
      [self setMoveSpeed:0.03];
    }];
  });
  
}


#pragma mark - createUI
- (void)createUI {
  self.tableView.hidden = true;//请求成功后再显示
  self.tableView.tableFooterView = [UIView new];
  self.tableView.backgroundColor = DQMMainColor;
  self.tableView.showsVerticalScrollIndicator = false;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

  
  UIImageView *expandImageView = [[DQMExpandImageView alloc] initWithImage:[UIImage imageNamed:@"temp_game_task_header"]];
  expandImageView.height = HEADER_TOP;
  expandImageView.width = kScreenWidth;
  expandImageView.backgroundColor = DQMMainColor;
  expandImageView.userInteractionEnabled = true;
  expandImageView.contentMode = UIViewContentModeScaleAspectFit;
  _expandHander.headerView.backgroundColor = QMBackColor;
  _expandHander = [DQMExpandHeader expandWithScrollView:self.tableView expandView:expandImageView];
  
  
  UIImageView *logoImageView = [[UIImageView alloc] init];
  QMViewBorderRadius(logoImageView, 14, 2, UIColor.whiteColor);
  QMSetImage(logoImageView, @"pkq");
  [self.tableView addSubview:logoImageView];
  [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(12);
    make.top.mas_equalTo(-20);//固定80会有错
    make.size.mas_equalTo(CGSizeMake(AdaptedWidth(100), AdaptedWidth(100)));
  }];
  
  [RACObserve(self, first_model) subscribeNext:^(GameTaskCheckInTableViewCellModel *x) {
    [logoImageView qm_setImageUrlString:x.imageUrl];
  }];
  
}



#pragma mark - tableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _first_model == nil ? 0 : 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 0) {
    GameTaskCheckInTableViewCell *cell = [GameTaskCheckInTableViewCell cellWithTableView:tableView indexPath:indexPath FixedCellHeight:167];
    cell.cellModel = _first_model;
    return cell;
  } else  if (indexPath.row == 1) {
    GameTaskDetailStepTableViewCell *cell = [GameTaskDetailStepTableViewCell cellWithTableView:tableView indexPath:indexPath FixedCellHeight:0];
    cell.cellModel = _second_model;
    return cell;
  }
  DQMDefaultTableViewCell *cell = [DQMDefaultTableViewCell cellWithTableView:tableView];
  cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
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
  
  GameTaskCheckInTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
  if (cell.collectionView.contentSize.width < kScreenWidth - 134) {
    return;//小于屏幕不滚动
  }
  if (cell.collectionView.contentOffset.x + kScreenWidth - 18 > cell.collectionView.contentSize.width ) {
    cell.collectionView.contentOffset = CGPointMake(-kScreenWidth+134, 0);
  }
  
  
  [UIView animateWithDuration:0.03 animations:^{
    cell.collectionView.contentOffset = CGPointMake(cell.collectionView.contentOffset.x + 1, 0);
  }];
  
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
