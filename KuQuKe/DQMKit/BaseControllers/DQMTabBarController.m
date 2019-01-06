//
//  DQMTabBarController.m
//  DQM_AnimationDemo
//
//  Created by 漂读网 on 2018/12/24.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMTabBarController.h"
#import "DQMNavigationController.h"     //导航栏  给每个首页套上导航栏
#import "HomeViewController.h"          //首页
#import "APPViewController.h"           //应用赚钱
#import "GameViewController.h"          //游戏赚钱
#import "MyViewController.h"            //我的

@interface DQMTabBarController () <UITabBarControllerDelegate>

@end

@implementation DQMTabBarController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self addChildViewControllers];
  [self addTabarItems];
  self.delegate = self;
}
- (void)customIsInGod:(NSNotification *)noti {
  if (![noti.object boolValue]) {
    return;
  }
}


- (void)addChildViewControllers
{
  DQMNavigationController *one = [[DQMNavigationController alloc] initWithRootViewController:[[HomeViewController alloc] initWithTitle:@"首页"]];
  
  DQMNavigationController *two = [[DQMNavigationController alloc] initWithRootViewController:[[APPViewController alloc] initWithTitle:@"应用赚钱"]];

  DQMNavigationController *three = [[DQMNavigationController alloc] initWithRootViewController:[[GameViewController alloc] initWithTitle:@"游戏赚钱"]];

  DQMNavigationController *four = [[DQMNavigationController alloc] initWithRootViewController:[[MyViewController alloc] initWithTitle:@"我的"]];

   self.viewControllers = @[one,two,three,four];
  
}

- (void)addTabarItems
{
  
  NSDictionary *firstTabBarItemsAttributes = @{
                                               @"TabBarItemTitle" : @"首页",
                                               @"TabBarItemImage" : @"icon_tabbar_home_default",
                                               @"TabBarItemSelectedImage" : @"icon_tabbar_home_select",
                                               };
  
  NSDictionary *secondTabBarItemsAttributes = @{
                                               @"TabBarItemTitle" : @"应用赚钱",
                                               @"TabBarItemImage" : @"icon_tabbar_download_default",
                                               @"TabBarItemSelectedImage" : @"icon_tabbar_download_select",
                                               };
NSDictionary *threeTabBarItemsAttributes = @{
											  @"TabBarItemTitle" : @"游戏赚钱",
											  @"TabBarItemImage" : @"icon_tabbar_download_default",
											  @"TabBarItemSelectedImage" : @"icon_tabbar_download_select",
											  };
NSDictionary *fourTabBarItemsAttributes = @{
											  @"TabBarItemTitle" : @"我的",
											  @"TabBarItemImage" : @"icon_tabbar_download_default",
											  @"TabBarItemSelectedImage" : @"icon_tabbar_download_select",
											  };
  
  NSArray<NSDictionary *>  *tabBarItemsAttributes = @[
                                                          firstTabBarItemsAttributes,
                                                          secondTabBarItemsAttributes,
														  threeTabBarItemsAttributes,
														  fourTabBarItemsAttributes
                                                          ];
  
  [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
    obj.tabBarItem.title = tabBarItemsAttributes[idx][@"TabBarItemTitle"];
    obj.tabBarItem.image = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemImage"]];
    obj.tabBarItem.selectedImage = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemSelectedImage"]];
    obj.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
  }];
  
  self.tabBar.tintColor = [UIColor redColor];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
  return YES;
}

@end
