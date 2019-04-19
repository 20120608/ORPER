//
//  KuCunView.m
//  KuQuKe
//
//  Created by Xcoder on 2019/4/17.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "KuCunView.h"
#import "CategoryModel.h"

@interface KuCunView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;


@end

@implementation KuCunView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)  style:UITableViewStylePlain];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		[self addSubview:_tableView];
		
	}
	return self;
}


#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.categoryModel.data.skuInfoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
	}
	
	NSString *title = [[NSString alloc] initWithFormat:@"%ld.",indexPath.row];
	NSArray<AttributeValueList *> *skuinfoArr = _categoryModel.data.skuInfoList[indexPath.row].attributeValueList;
	for (int i = 0; i < skuinfoArr.count; i++) {
		title = [NSString stringWithFormat:@"%@  %@",title,skuinfoArr[i].attributeValue];
		
	}
	cell.textLabel.text = [NSString stringWithFormat:@"%@    库存数%@",title,_categoryModel.data.skuInfoList[indexPath.row].stockQuantity];
	
	return cell;
}






@end
