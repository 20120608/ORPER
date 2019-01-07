//
//  DQMImageAndArrowTableViewCell.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/7.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "DQMImageAndArrowTableViewCell.h"

@interface DQMImageAndArrowTableViewCell ()

@end

@implementation DQMImageAndArrowTableViewCell

+(DQMImageAndArrowTableViewCell *)cellWithTableView:(UITableView *)tableview andIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"DQMImageAndArrowTableViewCell";
	DQMImageAndArrowTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil)
	{
		cell = [[DQMImageAndArrowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
		cell.indexPath = indexPath;
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self)
	{
		/** 图标 */
		@property(nonatomic,strong) UIImageView      *iconImageView;
		/** 标题 */
		@property(nonatomic,strong) UILabel          *titleLabel;
		/** 下标 */
		@property(nonatomic,copy) NSIndexPath        *indexPath;
		/** 箭头 */
		@property(nonatomic,strong) UIImageView      *arrowImageView;
	}
	return self;
}

@end
