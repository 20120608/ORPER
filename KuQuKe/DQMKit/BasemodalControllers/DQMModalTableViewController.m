//
//  DQMModalTableViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/24.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMModalTableViewController.h"

@interface DQMModalTableViewController ()

/** UITableViewStyle */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@end

@implementation DQMModalTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setupBaseTableViewUI];
}

- (void)setupBaseTableViewUI
{
  self.tableView.backgroundColor = QMBackColor;
  
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  if (@available(iOS 11.0, *)) {
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  }
}

#pragma mark - scrollDeleggate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  UIEdgeInsets contentInset = self.tableView.contentInset;
  contentInset.bottom -= self.tableView.mj_footer.height;
  self.tableView.scrollIndicatorInsets = contentInset;
  [self.view endEditing:YES];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return [UITableViewCell new];
}

- (UITableView *)tableView
{
  if(_tableView == nil)
  {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, kScreenHeight-NAVIGATION_BAR_HEIGHT) style:self.tableViewStyle];
    [self.view addSubview:tableView];
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 44;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView = tableView;
  }
  return _tableView;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
  if (self = [super init]) {
    _tableViewStyle = style;
  }
  return self;
}

- (void)dealloc {
  
}

@end
