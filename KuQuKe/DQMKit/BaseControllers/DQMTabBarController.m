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
  DQMNavigationController *one = [[DQMNavigationController alloc] initWithRootViewController:[[HomeViewController alloc] initWithStyle:UITableViewStyleGrouped]];
  
  DQMNavigationController *two = [[DQMNavigationController alloc] initWithRootViewController:[[APPViewController alloc] initWithTitle:@"应用赚钱"]];

  DQMNavigationController *three = [[DQMNavigationController alloc] initWithRootViewController:[[GameViewController alloc] initWithTitle:@"游戏赚钱"]];

    DQMNavigationController *four = [[DQMNavigationController alloc] initWithRootViewController:[[MyViewController alloc] initWithTitle:@"我的"]];


   self.viewControllers = @[one,two,three,four];
  
}

- (void)addTabarItems
{
  
  NSDictionary *firstTabBarItemsAttributes = @{
                                               @"TabBarItemTitle" : @"首页",
                                               @"TabBarItemImage" : @"09",
                                               @"TabBarItemSelectedImage" : @"08",
                                               };
  
  NSDictionary *secondTabBarItemsAttributes = @{
                                               @"TabBarItemTitle" : @"应用赚钱",
                                               @"TabBarItemImage" : @"11",
                                               @"TabBarItemSelectedImage" : @"10",
                                               };
NSDictionary *threeTabBarItemsAttributes = @{
											  @"TabBarItemTitle" : @"游戏赚钱",
											  @"TabBarItemImage" : @"13",
											  @"TabBarItemSelectedImage" : @"12",
											  };
NSDictionary *fourTabBarItemsAttributes = @{
											  @"TabBarItemTitle" : @"我的",
											  @"TabBarItemImage" : @"15",
											  @"TabBarItemSelectedImage" : @"14",
											  };
  
  NSArray<NSDictionary *>  *tabBarItemsAttributes = @[
                                                          firstTabBarItemsAttributes,
                                                          secondTabBarItemsAttributes,
														  threeTabBarItemsAttributes,
														  fourTabBarItemsAttributes
                                                          ];
  
  [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
    obj.tabBarItem.title = tabBarItemsAttributes[idx][@"TabBarItemTitle"];
    obj.tabBarItem.image = [[self scaleImageToSize:[UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemImage"]] size:CGSizeMake(28, 28)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    obj.tabBarItem.selectedImage = [[self scaleImageToSize:[UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemSelectedImage"]] size:CGSizeMake(28, 28)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    obj.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 0);
    obj.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
  }];
  
  self.tabBar.tintColor = DQMMainColor;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
  return YES;
}

-(UIImage *)scaleImageToSize:(UIImage *)img size:(CGSize)size
{
	UIGraphicsBeginImageContext(size);
	[img drawInRect:CGRectMake(0, 0, size.width, size.height)];
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return scaledImage;
}

@end
