//
//  DQMModalRequestBaseViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/18.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMModalRequestBaseViewController.h"
#import "MBProgressHUD+DQM.h"

@interface DQMModalRequestBaseViewController ()

@property (nonatomic, strong) Reachability *reachHost;

@end

@implementation DQMModalRequestBaseViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self reachHost];
}

#pragma mark - 加载框
- (void)showLoading
{
  [MBProgressHUD showProgressToView:self.view Text:@"加载中..."];
}

- (void)dismissLoading
{
  [MBProgressHUD hideHUDForView:self.view];
}


#define kURL_Reachability__Address @"www.baidu.com"
#pragma mark - 监听网络状态
- (Reachability *)reachHost
{
  if(_reachHost == nil)
  {
    _reachHost = [Reachability reachabilityWithHostName:kURL_Reachability__Address];
    QMWeak(self);
    [_reachHost setUnreachableBlock:^(Reachability * reachability){
      dispatch_async(dispatch_get_main_queue(), ^{
        [weakself networkStatus:reachability.currentReachabilityStatus inViewController:weakself];
      });
    }];
    
    [_reachHost setReachableBlock:^(Reachability * reachability){
      dispatch_async(dispatch_get_main_queue(), ^{
        [weakself networkStatus:reachability.currentReachabilityStatus inViewController:weakself];
      });
    }];
    [_reachHost startNotifier];
  }
  return _reachHost;
}


#pragma mark - DQMModalRequestBaseViewControllerDelegate
- (void)networkStatus:(NetworkStatus)networkStatus inViewController:(DQMModalRequestBaseViewController *)inViewController
{
  //判断网络状态
  switch (networkStatus) {
    case NotReachable:
      [MBProgressHUD showError:@"当前网络连接失败，请查看设置" ToView:self.view];
      break;
    case ReachableViaWiFi:
      NSLog(@"wifi上网2");
      break;
    case ReachableViaWWAN:
      NSLog(@"手机上网2");
      break;
    default:
      break;
  }
}


- (void)dealloc
{
  if ([self isViewLoaded]) {
    [MBProgressHUD hideHUDForView:self.view animated:NO];
  }
  [_reachHost stopNotifier];
  _reachHost = nil;
}

@end

