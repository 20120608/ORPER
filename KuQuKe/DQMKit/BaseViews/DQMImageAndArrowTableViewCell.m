//
//  DQMImageAndArrowTableViewCell.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/7.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "DQMImageAndArrowTableViewCell.h"

@interface DQMImageAndArrowTableViewCell ()

/** 固定高 0自适应 */
@property(nonatomic,assign) CGFloat          fixedCellHeight;


@end

@implementation DQMImageAndArrowTableViewCell

+(DQMImageAndArrowTableViewCell *)cellWithTableView:(UITableView *)tableview andIndexPath:(NSIndexPath *)indexPath andFixedCellHeight:(CGFloat)fixedCellHeight
{
	static NSString *identifier = @"DQMImageAndArrowTableViewCell";
	DQMImageAndArrowTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil)
	{
		cell = [[DQMImageAndArrowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
		cell.indexPath = indexPath;
		cell.fixedCellHeight = fixedCellHeight;
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
		self.iconImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[self.contentView addSubview: imageView];
			QMSetImage(imageView, @"01");
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(20);
				make.top.mas_equalTo(17.5);
				make.bottom.mas_equalTo(-17.5);
				make.size.mas_equalTo(CGSizeMake(25, 25));
			}];
			imageView;
		});
		/** 标题 */
		self.titleLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			QMLabelFontColorText(label, @"关于酷趣客", QMTextColor, 16);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(_iconImageView.mas_right).offset(5);
				make.centerY.mas_equalTo(_iconImageView.mas_centerY);
			}];
			label;
		});
		/** 箭头 */
		self.arrowImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[self addSubview: imageView];
			QMSetImage(imageView, @"icon_arrow_f6f6f6");
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(-8);
				make.centerY.mas_equalTo(_iconImageView.mas_centerY);
				make.size.mas_equalTo(CGSizeMake(30, 30));
			}];
			imageView;
		});
		
	}
	return self;
}

- (void)setFixedCellHeight:(CGFloat)fixedCellHeight {
	_fixedCellHeight = fixedCellHeight;
	if (fixedCellHeight != 0) {
		[_iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(20);
			make.top.mas_equalTo((fixedCellHeight-25)/2);
			make.bottom.mas_equalTo(-(fixedCellHeight-25)/2);
			make.size.mas_equalTo(CGSizeMake(25, 25));
		}];
	} else {
		[_iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(20);
			make.top.mas_equalTo(17.5);
			make.bottom.mas_equalTo(-17.5);
			make.size.mas_equalTo(CGSizeMake(25, 25));
		}];
	}
}



- (void)setTeamModel:(DQMTeam *)teamModel {
	_teamModel = teamModel;
	/** 图标 */
	[self.iconImageView setImage:[UIImage imageNamed:teamModel.extensionDictionary[@"icon"]]];
	/** 标题 */
	self.titleLabel.text = teamModel.name;
}




@end
