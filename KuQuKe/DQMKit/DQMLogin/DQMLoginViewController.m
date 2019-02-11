//
//  DQMLoginViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/18.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMLoginViewController.h"
#import "DQMExpandHeader.h"//顶部
#import "DQMExpandImageView.h"//纯绿色背景会放大
#import "LoginCodeOrPassWordTableViewCell.h"//免密登入和密码登入
#import "LoginThreeForeignView.h"//第三方登入

#define HEADER_TOP AdaptedHeight(270) //滚动到多少导航栏变不透明

@interface DQMLoginViewController () <LoginCodeOrPassWordTableViewCellDelegate>
{
  NSTimer * _timer;
  int _countDown;
}
@property (nonatomic, strong) DQMExpandHeader                   *expandHander;

@end

@implementation DQMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  [self createUI];
  
}

#pragma mark - UI
- (void)createUI {

  self.tableView.tableFooterView = [UIView new];
  self.tableView.backgroundColor = UIColor.whiteColor;
  self.tableView.showsVerticalScrollIndicator = false;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
  }];
  [self.view sendSubviewToBack:self.tableView];
  
  UIImageView *expandImageView = [[DQMExpandImageView alloc] initWithImage:[UIImage imageNamed:@"horizontal_placehold_image"]];
  expandImageView.height = HEADER_TOP;
  expandImageView.width = kScreenWidth;
  expandImageView.backgroundColor = DQMMainColor;
  expandImageView.userInteractionEnabled = true;
  expandImageView.contentMode = UIViewContentModeScaleAspectFit;
  _expandHander.headerView.backgroundColor = QMBackColor;
  _expandHander = [DQMExpandHeader expandWithScrollView:self.tableView expandView:expandImageView];
  
  
  UIView *whiteView = ({
    UIView *view = [[UIView alloc] init];
    [self.tableView addSubview: view];
    QMViewBorderRadius(view, 6, 0, UIColor.whiteColor);
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(24);
      make.top.mas_equalTo(-33);
      make.size.mas_equalTo(CGSizeMake(kScreenWidth-48, 39));
    }];
    view;
  });
  whiteView.backgroundColor = UIColor.whiteColor;

  
  LoginThreeForeignView *threeView = ({
    LoginThreeForeignView *view = [[LoginThreeForeignView alloc] init];
    [self.view addSubview: view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.bottom.mas_equalTo(0);
      make.height.mas_equalTo(120+HOME_INDICATOR_HEIGHT);
    }];
    view;
  });
  threeView.backgroundColor = UIColor.whiteColor;

}

#pragma mark - tableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 0) {
    LoginCodeOrPassWordTableViewCell *cell = [LoginCodeOrPassWordTableViewCell cellWithTableView:tableView indexPath:indexPath FixedCellHeight:0];
    cell.delegate = self;
    cell.countDown = 0;
    return cell;
  }
  DQMDefaultTableViewCell *cell = [DQMDefaultTableViewCell cellWithTableView:tableView];
  cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
  return cell;
}



#pragma mark - button delegate
- (void)LoginCodeOrPassWordTableViewCell:(LoginCodeOrPassWordTableViewCell *)cell LoginUseMsgcodeView:(LoginUseMsgcodeView *)loginUseMsgcodeView DidClickSendCodeButton:(UIButton *)button {
  NSLog(@"获取验证码");
  [self beginCountDown];
}

- (void)LoginCodeOrPassWordTableViewCell:(LoginCodeOrPassWordTableViewCell *)cell LoginUsePassWordView:(LoginUsePassWordView *)loginUsePassWordView DidClickRegisterButton:(UIButton *)button {
   NSLog(@"注册");
}

- (void)LoginCodeOrPassWordTableViewCell:(LoginCodeOrPassWordTableViewCell *)cell LoginUsePassWordView:(LoginUsePassWordView *)loginUsePassWordView DidClickSearchButton:(UIButton *)button {
   NSLog(@"找回");
}

- (void)LoginCodeOrPassWordTableViewCell:(LoginCodeOrPassWordTableViewCell *)cell LoginUseMsgcodeView:(LoginUseMsgcodeView *)loginUseMsgcodeView DidClickLoginButton:(UIButton *)button {
  NSLog(@"短信登录");
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self loginSuccess];
  });
}

- (void)LoginCodeOrPassWordTableViewCell:(LoginCodeOrPassWordTableViewCell *)cell LoginUsePassWordView:(LoginUsePassWordView *)loginUsePassWordView DidClickLoginButton:(UIButton *)button {
  NSLog(@"密码登录");
  
  [self loginFalse];
}

#pragma mark - login status animation
- (void)loginSuccess {
  
  [self loginButtonAnimation:true];
  [self stopTimerAndReloadView];
}

- (void)loginFalse {
  
  [self loginButtonAnimation:false];
}

//触发动画
- (void)loginButtonAnimation:(BOOL)status {
  LoginCodeOrPassWordTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
  cell.loginStatus = status;//触发监听
}


#pragma mark - timer
/**
 开始计时
 */
- (void)beginCountDown {
  CGFloat timeInterval = 1;
  _countDown = 10;
  [self invalidateTimerWhenDismissViewController];
  _timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(countdownAction) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 计时器操作
 */
- (void)countdownAction {
  if (_countDown >= 0) {
    LoginCodeOrPassWordTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.countDown = _countDown;
    _countDown -= 1;
  } else {
   [self invalidateTimerWhenDismissViewController];
  }
}

//释放定时器
-(void)invalidateTimerWhenDismissViewController {
  [_timer invalidate];
  _timer = nil;
}

//停止定时器刷新界面
- (void)stopTimerAndReloadView {
  [self invalidateTimerWhenDismissViewController];
  LoginCodeOrPassWordTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
  _countDown = 0;
  cell.countDown = _countDown;
}
/**
 删除移除计时器   因为视图是present出来的 不会走这里！！！！
 */
//- (void)willMoveToParentViewController:(UIViewController *)parent {
//  [super willMoveToParentViewController:parent];
//  NSLog(@"执行了 willMoveToParentViewController ");
//  [self invalidateTimerWhenDismissViewController];
//}






#pragma mark - dqm_navibar
- (UIColor *)DQMModalnavUIBaseViewControllerNaviBackgroundColor:(DQMModalNavUIBaseViewController *)navUIBaseViewController {
  return UIColor.clearColor;
}

- (NSMutableAttributedString *)DQMModalnavUIBaseViewControllerNaviTitle:(DQMModalNavUIBaseViewController *)navUIBaseViewController {
  return [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:@"登录" color:UIColor.whiteColor];
}

- (UIImage *)DQMModalnavUIBaseViewControllerLeftButtonImage:(DQMModalNavUIBaseViewController *)navUIBaseViewController {
  return [UIImage imageNamed:@"NavgationBar_white_back"];
}

-(void)DQMModalleftButtonEvent:(UIButton *)sender navigationBar:(DQMModalNavUIBaseViewController *)navUIBaseViewController {
  UIViewController *currentVc = [QMSGeneralHelpers topViewControllerInNavi];
  if (currentVc != nil) {
    [currentVc.navigationController popViewControllerAnimated:false];
    //要先手动停掉定时器, 因为present出来的不会走willMoveToParentViewController ！！！！
    [self invalidateTimerWhenDismissViewController];
    [self dismissViewControllerAnimated:true completion:nil];
  }
}




@end
