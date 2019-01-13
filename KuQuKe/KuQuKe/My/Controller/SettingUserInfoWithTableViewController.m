//
//  SettingUserInfoWithTableViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/10.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "SettingUserInfoWithTableViewController.h"

@interface SettingUserInfoWithTableViewController ()

/** 标题 */
@property(nonatomic,copy) NSString *naviName;

@end

@implementation SettingUserInfoWithTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.naviName = _settingTableStype == SettingTableStyleJob ? @"工作" : @"其他";
  //因为先走了dqmNavigationBarTitle  所以要手动触发一次
  self.dqm_navgationBar.title = [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:self.naviName color:UIColor.whiteColor];
	
	self.addItem([StaticListItem itemAdditionalExtensionWithTitle:@"学生" subTitle:nil extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
		
	}])
	.addItem([StaticListItem itemAdditionalExtensionWithTitle:@"教师" subTitle:nil extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
		
	}])
	.addItem([StaticListItem itemAdditionalExtensionWithTitle:@"全职妈妈" subTitle:nil extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
		
	}])
	.addItem([StaticListItem itemAdditionalExtensionWithTitle:@"上班族" subTitle:nil extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
		
	}])
	.addItem([StaticListItem itemAdditionalExtensionWithTitle:@"老板" subTitle:nil extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
		
	}])
	.addItem([StaticListItem itemAdditionalExtensionWithTitle:@"公务员" subTitle:nil extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
		
	}])
	.addItem([StaticListItem itemAdditionalExtensionWithTitle:@"自由职业" subTitle:nil extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
		
	}])
	.addItem([StaticListItem itemAdditionalExtensionWithTitle:@"其他" subTitle:nil extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
		
	}]);
  
}


#pragma mark - tableview datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
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

- (NSMutableAttributedString *)dqmNavigationBarTitle:(DQMNavigationBar *)navigationBar {
  
  return [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:_naviName color:UIColor.whiteColor];
}

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
  return DQMMainColor;
}


@end
