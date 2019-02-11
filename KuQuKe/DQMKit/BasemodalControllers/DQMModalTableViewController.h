//
//  DQMModalTableViewController.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/24.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMModalBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DQMModalTableViewController : DQMModalBaseViewController<UITableViewDelegate, UITableViewDataSource>

// 这个代理方法如果子类实现了, 必须调用super
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView NS_REQUIRES_SUPER;


/** 列表 */
@property (strong, nonatomic) UITableView *tableView;

// tableview的样式, 默认plain
- (instancetype)initWithStyle:(UITableViewStyle)style;

@end

NS_ASSUME_NONNULL_END
