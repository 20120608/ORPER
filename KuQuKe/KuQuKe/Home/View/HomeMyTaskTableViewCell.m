//
//  HomeMyTaskTableViewCell.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/13.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "HomeMyTaskTableViewCell.h"

@implementation HomeMyTaskTableViewCell

+(HomeMyTaskTableViewCell *)cellWithTableView:(UITableView *)tableview
{
	static NSString *identifier = @"HomeMyTaskTableViewCell";
	HomeMyTaskTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil)
	{
		cell = [[HomeMyTaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self)
	{
		self.backgroundColor = RGB_COLOR(133, 237, 152);
		
		UILabel *contentLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self.contentView addSubview:label];
			QMLabelFontColorText(label, @"我的专属任务6个,全部完成可以获得23元奖励", QMTextColor, 14);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.edges.mas_equalTo(UIEdgeInsetsMake(0, 20, 0, 40));
				make.height.mas_equalTo(35);
			}];
			label;
		});
		
		UIImageView *arrowImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[self.contentView addSubview: imageView];
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
				make.centerY.mas_equalTo(contentLabel.centerY);
				make.size.mas_equalTo(CGSizeMake(15, 15));
			}];
			imageView;
		});
		QMSetImage(arrowImageView, @"icon_arrow_dqm_888888");
		
		
		//订阅
		[RACObserve(self, contentMAString) subscribeNext:^(NSMutableAttributedString *x) {
      contentLabel.attributedText = x;
		}];
		
	}
	return self;
}

@end
