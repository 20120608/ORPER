//
//  MyBalanceOfPaymentsViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "MyBalanceOfPaymentsViewController.h"
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
#import "MyInComeViewController.h"//收入列表
#import "MyWithdrawViewController.h"//提现

@interface MyBalanceOfPaymentsViewController () <JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) NSArray <NSString *> *titles;

@end

@implementation MyBalanceOfPaymentsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
  self.view.backgroundColor = UIColor.whiteColor;
	
	//滚动的菜单
	CGFloat categoryHeight = 45;
	self.categoryView = [[JXCategoryTitleView alloc] init];
	self.categoryView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, categoryHeight);
	self.categoryView.delegate = self;
	self.categoryView.titles = self.titles;
	self.categoryView.defaultSelectedIndex = 0;
	self.categoryView.titleColor = QMTextColor;
	self.categoryView.titleSelectedColor = DQMMainColor;
	self.categoryView.titleFont = [UIFont systemFontOfSize:19];
	self.categoryView.backgroundColor = [UIColor whiteColor];
	//线条颜色
	JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
	lineView.indicatorLineViewColor = DQMMainColor;
	lineView.lineStyle = JXCategoryIndicatorLineStyle_IQIYI;
	self.categoryView.indicators = @[lineView];
	[self.view addSubview:self.categoryView];
	
	//视图容器
	self.listContainerView = [[JXCategoryListContainerView alloc] initWithParentVC:self delegate:self];
	self.listContainerView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT+categoryHeight, kScreenWidth, kScreenHeight-NAVIGATION_BAR_HEIGHT-categoryHeight);
	self.listContainerView.defaultSelectedIndex = 0;
	[self.view addSubview:self.listContainerView];
	self.categoryView.contentScrollView = self.listContainerView.scrollView;
	
	//刷新
	[self reloadData];
}

/**
 重载数据源：比如从服务器获取新的数据、否则用户对分类进行了排序等
 */
- (void)reloadData {
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		
		if (self.titles == nil) {
			_titles = @[@"收入", @"提现"];
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
	if (index == 0) {
		MyInComeViewController *listVC = [[MyInComeViewController alloc] init];
		return listVC;
	}
	MyWithdrawViewController *listVC = [[MyWithdrawViewController alloc] init];
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

- (NSMutableAttributedString *)dqmNavigationBarTitle:(DQMNavigationBar *)navigationBar {
	return [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:@"收支明细" color:[UIColor whiteColor]];
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
	[self.navigationController popViewControllerAnimated:true];
}

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
	return DQMMainColor;
}

@end
