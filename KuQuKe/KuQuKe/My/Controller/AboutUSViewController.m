//
//  AboutUSViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/10.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "AboutUSViewController.h"

@interface AboutUSViewController ()

/** 公司的数据 */
@property(nonatomic,strong) NSDictionary          *companyDictionay;

@end

@implementation AboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  [self createTableViewHeader];
  
  [KuQuKeNetWorkManager GET_aboutUsParams:[NSMutableDictionary new] View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {

    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:dataDic[@"data"]];
    [tempDic setValue:@"用户须知" forKey:@"needKnow"];
    self.companyDictionay = tempDic;
    
    self.addItem([StaticListItem itemAdditionalExtensionWithTitle:@"客服QQ" subTitle:_companyDictionay[@"kfqq"] extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
      
    }])
    .addItem([StaticListItem itemAdditionalExtensionWithTitle:@"百度贴吧" subTitle:_companyDictionay[@"baidutb"] extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
      
    }])
    .addItem([StaticListItem itemAdditionalExtensionWithTitle:@"新浪微博" subTitle:_companyDictionay[@"sianweibo"] extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
      
    }])
    .addItem([StaticListItem itemAdditionalExtensionWithTitle:@"QQ群" subTitle:_companyDictionay[@"qqun"] extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
      
    }])
    .addItem([StaticListItem itemAdditionalExtensionWithTitle:@"商务QQ群" subTitle:_companyDictionay[@"syqqun"] extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
      
    }])
    .addItem([StaticListItem itemAdditionalExtensionWithTitle:@"意见反馈" subTitle:_companyDictionay[@"email"] extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
      
    }])
    .addItem([StaticListItem itemAdditionalExtensionWithTitle:@"用户须知" subTitle:_companyDictionay[@"needKnow"] extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
      
    }]);
    
    [self.tableView reloadData];
    
  } unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
    
  } failure:^(NSError *error) {
    
  }];
  

}


#pragma mark - UI
-(void)createTableViewHeader {
  
  UIView *headerView = ({
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    view.backgroundColor = QMBackColor;
    view;
  });
  self.tableView.tableHeaderView = headerView;
  UIImageView *iconImageView =  ({
    UIImageView *imageView = [[UIImageView alloc] init];
    QMSetImage(imageView, @"logo");
    QMViewBorderRadius(imageView, 4, 0, DQMMainColor);
    [headerView addSubview: imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.mas_equalTo(headerView.mas_centerX);
      make.top.mas_equalTo(headerView.mas_top).offset(15);
      make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    imageView;
  });
  
  UILabel *nameLabel = ({
    UILabel *label = [[UILabel alloc] init];
    [headerView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    QMLabelFontColorText(label, @"酷趣客", UIColor.blackColor, 15);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.mas_equalTo(headerView.mas_centerX);
      make.top.mas_equalTo(iconImageView.mas_bottom).offset(10);
    }];
    label;
  });
  
  UILabel *msgLabel = ({
    UILabel *label = [[UILabel alloc] init];
    [headerView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    QMLabelFontColorText(label, @"版本:0.0.0", QMSubTextColor, 10);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.mas_equalTo(headerView.mas_centerX);
      make.top.mas_equalTo(nameLabel.mas_bottom).offset(10);
      make.bottom.mas_equalTo(headerView.mas_bottom).offset(-15);
    }];
    label;
  });
  NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
  NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];// app名称
  NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];// app版本
  nameLabel.text = app_Name;
  msgLabel.text = [NSString stringWithFormat:@"版本:%@",app_Version];
  
  
  
  UIView *footerView = ({
      UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
      view.backgroundColor = QMBackColor;
      view;
    });
  self.tableView.tableFooterView = footerView;

  UILabel *footerLabel = ({
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    [footerView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label;
  });
  QMLabelFontColorText(footerLabel, @"每天赚一点,满足零花钱", QMSubTextColor, 12);
  
}



#pragma mark - tableView DataSource
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

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
  return DQMMainColor;
}

@end
