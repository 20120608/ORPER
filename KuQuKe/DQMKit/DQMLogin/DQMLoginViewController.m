//
//  DQMLoginViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/18.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMLoginViewController.h"
#import "DQMTabBarController.h"//分栏

@interface DQMLoginViewController ()

@end

@implementation DQMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];


  
  
}






#pragma mark - dqm_navibar
- (UIColor *)DQMModalnavUIBaseViewControllerNaviBackgroundColor:(DQMModalNavUIBaseViewController *)navUIBaseViewController {
  return DQMMainColor;
}

- (NSMutableAttributedString *)DQMModalnavUIBaseViewControllerNaviTitle:(DQMModalNavUIBaseViewController *)navUIBaseViewController {
  return [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:@"登录" color:UIColor.whiteColor];
}

-(void)DQMModalleftButtonEvent:(UIButton *)sender navigationBar:(DQMModalNavUIBaseViewController *)navUIBaseViewController {
  UIViewController *currentVc = [QMSGeneralHelpers topViewControllerInNavi];
  if (currentVc != nil) {
    [currentVc.navigationController popViewControllerAnimated:false];
    [self dismissViewControllerAnimated:true completion:nil];
  }
}




@end
