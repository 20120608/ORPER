//
//  ShopCategoryViewController.m
//  KuQuKe
//
//  Created by Xcoder on 2019/4/16.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "ShopCategoryViewController.h"
@interface ShopCategoryViewController () <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray *list; /* <#mark#> */


@end

@implementation ShopCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	UITableView *tableView = ({
		UITableView *tableView       = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
		[self.view addSubview:tableView];
		tableView.delegate           = self;
		tableView.dataSource         = self;
		tableView.estimatedRowHeight = 80;
		tableView.rowHeight          = UITableViewAutomaticDimension;
		tableView.tableFooterView    = [[UIView alloc] init];
		tableView.separatorStyle     = UITableViewCellSeparatorStyleNone;

		tableView;
	});
	
	self.list = [[NSMutableArray alloc] init];
	Class LSApplicationWorkspace_Class = NSClassFromString(@"LSApplicationWorkspace");
	NSObject *workspace = [LSApplicationWorkspace_Class performSelector:NSSelectorFromString(@"defaultWorkspace")];
	NSArray *plugins = [workspace performSelector:NSSelectorFromString(@"installedPlugins")];
	for (id plugin in plugins) {
		id infoPlist = [plugin performSelector:NSSelectorFromString(@"infoPlist")];
		
		NSString *bundleID = [infoPlist objectForKey:@"CFBundleIdentifier"];
		NSString *dispalyName = infoPlist[@"CFBundleDisplayName"];
		NSString *str = [NSString stringWithFormat:@"%@ -- %@",dispalyName,bundleID];
		[self.list addObject:str];
		
//		if
		
//		if (bundle) {
//			NSString *itemName = [bundle performSelector:NSSelectorFromString(@"itemName")];
//			if (itemName) {
//				[self.list addObject:[NSString stringWithFormat:@"%@ <%@>", [bundle performSelector:NSSelectorFromString(@"bundleIdentifier")], [bundle performSelector:NSSelectorFromString(@"itemName")]]];
//
////				NSLog(@"%@ <%@>", [bundle performSelector:NSSelectorFromString(@"bundleIdentifier")], [bundle performSelector:NSSelectorFromString(@"itemName")]);
//			} else {
//				NSLog(@"bundle  %@",bundle);
//			}
//		}
	}
	
	[tableView reloadData];
}

#pragma mark : ==============  代理 ==============
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1111"];
	cell.textLabel.text = self.list[indexPath.row];
	return cell;
}


@end
