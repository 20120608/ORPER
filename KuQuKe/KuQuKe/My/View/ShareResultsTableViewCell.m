//
//  ShareResultsTableViewCell.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "ShareResultsTableViewCell.h"

@implementation ShareResultsTableViewCell

+(ShareResultsTableViewCell *)cellWithTableView:(UITableView *)tableview
{
	static NSString *identifier = @"ShareResultsTableViewCell";
	ShareResultsTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil)
	{
		cell = [[ShareResultsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self)
	{
		self.backgroundColor = UIColor.whiteColor;
		
		/** 背景 */
		UIView *backColorView = ({
			UIView *view = [[UIView alloc] init];
			[self.contentView addSubview:view];
			view.backgroundColor = QMBackColor;
			QMViewBorderRadius(view, 4, 0, DQMMainColor);
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.edges.mas_equalTo(UIEdgeInsetsMake(0, 20, 0, 20));
			}];
			view;
		});
		
		
		NSMutableArray *labelsArray = [[NSMutableArray alloc] init];
		NSArray *titleArray = @[@"我的徒弟",@"今日提成",@"累计提成"];
		NSArray *priceArray = @[@"0人",@"0.00元",@"0.00元"];

		for (int i = 0 ; i < 3; i++) {
			
			UIView *backView = [[UIView alloc] init];
			[backColorView addSubview: backView];
			
			UILabel *contentLabel = ({
				UILabel *label = [[UILabel alloc] init];
				[backView addSubview:label];
				label.textAlignment = NSTextAlignmentCenter;
				[label mas_makeConstraints:^(MASConstraintMaker *make) {
					make.left.right.mas_equalTo(backView);
					make.centerY.mas_equalTo(backView.mas_centerY).offset(-15);
				}];
				label;
			});
			
			UILabel *titleLabel = ({
				UILabel *label = [[UILabel alloc] init];
				[backView addSubview:label];
				label.textAlignment = NSTextAlignmentCenter;
				[label mas_makeConstraints:^(MASConstraintMaker *make) {
					make.left.right.mas_equalTo(backView);
					make.centerY.mas_equalTo(backView.mas_centerY).offset(15);
				}];
				label;
			});
			QMLabelFontColorText(contentLabel, priceArray[i], QMPriceColor, 20);
			QMLabelFontColorText(titleLabel, titleArray[i], QMTextColor, 13);
			
			[labelsArray addObject:backView];
		}
		
		[labelsArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
		[labelsArray mas_makeConstraints:^(MASConstraintMaker *make) {
			make.bottom.top.mas_equalTo(backColorView);
			make.height.mas_equalTo(100);
		}];
		
		
		
		
	}
	return self;
}

@end
