//
//  DQMChildJXCategpryListViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "DQMChildJXCategpryListViewController.h"

@interface DQMChildJXCategpryListViewController ()

@end

@implementation DQMChildJXCategpryListViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	//因为列表延迟加载了，所以在初始化的时候加载数据即可
	[self loadDataForFirst];
}

- (void)loadDataForFirst {
	NSLog(@"刷新");
}


#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
	return self.view;
}

- (void)listDidAppear {
	NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
	NSLog(@"%@", NSStringFromSelector(_cmd));
}
@end
