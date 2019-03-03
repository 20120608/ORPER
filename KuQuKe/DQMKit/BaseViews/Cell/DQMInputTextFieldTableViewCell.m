//
//  DQMInputTextFieldTableViewCell.m
//  KuQuKe
//
//  Created by hallelujah on 2019/3/3.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "DQMInputTextFieldTableViewCell.h"

@interface DQMInputTextFieldTableViewCell ()

/** 下标 */
@property (nonatomic,copy  ) NSIndexPath *indexPath;
/** 固定高度 0则自适应 */
@property (nonatomic,assign) CGFloat     fixedCellHeight;
/** 用来撑开高度的View */
@property(nonatomic,strong) UIView       *backView;


@end

@implementation DQMInputTextFieldTableViewCell

+(DQMInputTextFieldTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight
{
	static NSString *identifier = @"DQMInputTextFieldTableViewCell";
	DQMInputTextFieldTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil)
	{
		cell = [[DQMInputTextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	cell.fixedCellHeight = fixedCellHeight;
	cell.indexPath = indexPath;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self)
	{
		self.backView = ({
			UIView *view = [[UIView alloc] init];
			[self.contentView addSubview: view];
			[view setBackgroundColor:UIColor.whiteColor];
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
			}];
			view;
		});
		
		/** 标题 */
		self.titleLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self.contentView addSubview:label];
			QMLabelFontColorText(label, @"titleLabel", QMTextColor, 16);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(self.mas_left).offset(12);
				make.centerY.mas_equalTo(self.mas_centerY);
				make.width.mas_equalTo(80);
			}];
			label;
		});
		
		self.contentTextField = ({
			UITextField *textField = [[UITextField alloc] init];
			[self addSubview:textField];
			textField.placeholder = @"contentTextField";
			textField.textColor = QMTextColor;
			textField.font = KQMFont(16);
			[textField mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(_titleLabel.mas_right).offset(10);
				make.centerY.mas_equalTo(self.mas_centerY);
				make.right.mas_equalTo(self.mas_right).offset(-12);
				make.height.mas_equalTo(30);
			}];
			textField;
		});

	}
	return self;
}


- (void)setFixedCellHeight:(CGFloat)fixedCellHeight {
	_fixedCellHeight = fixedCellHeight;
	if (fixedCellHeight != 0) {
		[_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.height.mas_equalTo(fixedCellHeight);
		}];
	}
}

@end
