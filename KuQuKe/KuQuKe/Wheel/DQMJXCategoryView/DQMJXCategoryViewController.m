//
//  DQMJXCategoryViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "DQMJXCategoryViewController.h"
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
#import "DQMChildJXCategpryListViewController.h"

@interface DQMJXCategoryViewController () <JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@end

@implementation DQMJXCategoryViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	NSAssert(NO, @"不要继承这个类,可以仿照后删除本行");
	
	CGFloat categoryHeight = 50;
	self.categoryView = [[JXCategoryTitleView alloc] init];
	self.categoryView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, categoryHeight);
	self.categoryView.delegate = self;
	self.categoryView.titles = self.titles;
	self.categoryView.defaultSelectedIndex = 0;
	JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
	self.categoryView.indicators = @[lineView];
	[self.view addSubview:self.categoryView];
	
	self.listContainerView = [[JXCategoryListContainerView alloc] initWithParentVC:self delegate:self];
	self.listContainerView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT+categoryHeight, kScreenWidth, kScreenHeight-NAVIGATION_BAR_HEIGHT-categoryHeight);
	self.listContainerView.defaultSelectedIndex = 0;
	[self.view addSubview:self.listContainerView];
	
	self.categoryView.contentScrollView = self.listContainerView.scrollView;
	
	[self reloadData];
}

/**
 重载数据源：比如从服务器获取新的数据、否则用户对分类进行了排序等
 */
- (void)reloadData {
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		
		if (self.titles == nil) {
			_titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果", @"营养胡萝卜", @"葡萄", @"美味西瓜", @"香蕉", @"香甜菠萝", @"鸡肉", @"鱼", @"海星"];
		}
		
		//重载之后默认回到0，你也可以指定一个index
		self.categoryView.defaultSelectedIndex = 0;
		self.categoryView.titles = self.titles;
		[self.categoryView reloadData];
		
		self.listContainerView.defaultSelectedIndex = 0;
		[self.listContainerView reloadData];
	});
	
}


#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
	[self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
	[self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
	DQMChildJXCategpryListViewController *listVC = [[DQMChildJXCategpryListViewController alloc] init];
	//	listVC.naviController = self.navigationController;
	return listVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
	return self.titles.count;
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
