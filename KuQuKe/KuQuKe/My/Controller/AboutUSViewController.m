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
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
   
    //触发信号
    self.companyDictionay = @{@"QQ":@"787765489",@"tieba":@"酷趣客吧",@"weibo":@"@酷趣客-手机赚钱",@"QQSection":@"198067852",@"advice":@"789678956@qq.com",@"businessQQ":@"1011078954",@"needKnow":@"查看",@"icon":@"pkq",@"name":@"酷趣客-手机赚钱",@"version":@"版本4.1.1"};
    
    self.addItem([StaticListItem itemAdditionalExtensionWithTitle:@"客服QQ" subTitle:_companyDictionay[@"QQ"] extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
      
    }])
    .addItem([StaticListItem itemAdditionalExtensionWithTitle:@"百度贴吧" subTitle:_companyDictionay[@"tieba"] extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
      
    }])
    .addItem([StaticListItem itemAdditionalExtensionWithTitle:@"新浪微博" subTitle:_companyDictionay[@"weibo"] extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
      
    }])
    .addItem([StaticListItem itemAdditionalExtensionWithTitle:@"QQ群" subTitle:_companyDictionay[@"QQSection"] extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
      
    }])
    .addItem([StaticListItem itemAdditionalExtensionWithTitle:@"商务QQ群" subTitle:_companyDictionay[@"businessQQ"] extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
      
    }])
    .addItem([StaticListItem itemAdditionalExtensionWithTitle:@"意见反馈" subTitle:_companyDictionay[@"advice"] extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
      
    }])
    .addItem([StaticListItem itemAdditionalExtensionWithTitle:@"用户须知" subTitle:_companyDictionay[@"needKnow"] extensionDictionary:nil itemOperation:^(NSIndexPath *indexPath) {
      
    }]);
    
    [self.tableView reloadData];
    
  });
  

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
    QMSetImage(imageView, @"pkq");
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

  
  //订阅信号  改变标题
  [RACObserve(self, companyDictionay) subscribeNext:^(NSDictionary *x) {
    QMSetImage(iconImageView, x[@"icon"]);
    nameLabel.text = x[@"name"];
    msgLabel.text = x[@"version"];
  }];
  
  
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
