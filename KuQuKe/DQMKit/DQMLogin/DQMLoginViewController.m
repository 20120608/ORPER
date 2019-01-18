//
//  DQMLoginViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/18.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMLoginViewController.h"
#import "DQMTabBarController.h"//分栏

@interface DQMLoginViewController () <DQMModalNavUIBaseViewControllerDataSource,DQMModalNavUIBaseViewControllerDelegate>

@end

@implementation DQMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.delegate = self;
  self.dataSource = self;

  
  
}






#pragma mark - dqm_navibar
- (UIColor *)navUIBaseViewControllerNaviBackgroundColor:(DQMModalNavUIBaseViewController *)navUIBaseViewController {
  return DQMMainColor;
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMModalNavUIBaseViewController *)navUIBaseViewController {
  UIViewController *currentVc = [QMSGeneralHelpers currentViewController];
  if (currentVc != nil) {
    [currentVc.navigationController popViewControllerAnimated:false];
    [self dismissViewControllerAnimated:true completion:nil];
  }
}




@end
