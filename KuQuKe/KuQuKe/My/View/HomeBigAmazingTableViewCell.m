//
//  HomeBigAmazingTableViewCell.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "HomeBigAmazingTableViewCell.h"

@implementation HomeBigAmazingTableViewCell

+(HomeBigAmazingTableViewCell *)cellWithTableView:(UITableView *)tableview
{
	static NSString *identifier = @"HomeBigAmazingTableViewCell";
	HomeBigAmazingTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil)
	{
		cell = [[HomeBigAmazingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self)
	{
		UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/375*111)];
		headerView.contentMode = UIViewContentModeScaleAspectFit;
		[headerView setImage:[UIImage imageNamed:@"banner.jpg"]];
		[self.contentView addSubview:headerView];
		[headerView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
			make.height.mas_equalTo(kScreenWidth/375*111);
		}];

	}
	return self;
}

@end
