//
//  HomeViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/6.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "HomeViewController.h"
#import "CheckInViewController.h"//签到
#import "DQMHorizontalViewScrollerView.h" //滚动广告


@interface HomeViewController () <DQMHorizontalViewScrollerViewDataSource>

/** 滚动广告 */
@property(nonatomic,strong) DQMHorizontalViewScrollerView *advScrollView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  [self createUI];
  
  
//  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    CheckInViewController *vc = [[CheckInViewController alloc] initWithTitle:@"每日签到"];
//    [self.navigationController pushViewController:vc animated:true];
//  });
  
  QMWeak(self);
  //广告请求数据
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [weakself.advScrollView reloadData];
//    https://www.jianshu.com/p/46bcfcf53055
  });

}

#pragma mark - UI
-(void)createUI {
  self.advScrollView = [[DQMHorizontalViewScrollerView alloc] initWithFrame:CGRectMake(44,NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH-44, 38)];
  _advScrollView.dataSource = self;
  [self.view addSubview:_advScrollView];
  
  
}

#pragma mark - DQMHorizontalViewScrollerViewDataSource
- (NSArray *)horizontalViewScrollViewDataArray:(DQMHorizontalViewScrollerView *)horizontalScrollView
{
  return @[@{@"name":@"我是你的什么"},@{@"name":@"会吹牛逼的小明"},@{@"name":@"haliluya"},@{@"name":@"移动ATM"},@{@"name":@"下一个天亮"}];
}



#pragma mark - dqm_navibar
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(DQMNavUIBaseViewController *)navUIBaseViewController {
	return false;
}



@end
