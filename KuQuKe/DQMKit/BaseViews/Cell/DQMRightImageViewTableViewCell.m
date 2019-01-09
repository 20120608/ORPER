//
//  DQMRightImageViewTableViewCell.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/10.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "DQMRightImageViewTableViewCell.h"
@interface DQMRightImageViewTableViewCell ()

/** 背景图层 */
@property (nonatomic,strong) UIView      *backView;
/** 图标 */
@property (nonatomic,strong) UIImageView *iconImageView;
/** 标题 */
@property (nonatomic,strong) UILabel     *titleLabel;
/** 子标题 */
@property (nonatomic,strong) UILabel     *subTitleLabel;
/** 箭头图标 */
@property (nonatomic,strong) UIImageView *arrowImageView;


/** 下标 */
@property (nonatomic,copy  ) NSIndexPath *indexPath;
/** 固定高度 0则自适应 */
@property (nonatomic,assign) CGFloat     cellHeight;
/** 是否显示箭头 */
@property (nonatomic,assign) BOOL        showArrow;

@end

@implementation DQMRightImageViewTableViewCell


+(DQMRightImageViewTableViewCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath andFixedHeightIfNeed:(CGFloat)height showArrow:(BOOL)showArrow
{
	static NSString *identifier = @"DQMRightImageViewTableViewCell";
	DQMRightImageViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil)
	{
		cell = [[DQMRightImageViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	cell.indexPath = indexPath;
	cell.showArrow = showArrow;
	if (height != 0) {
		cell.cellHeight = height;
	}
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
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.edges.mas_equalTo(self.contentView);
				if (_cellHeight != 0) {
					make.height.mas_equalTo(_cellHeight);
				} else {
					make.height.mas_equalTo(89);
				}
			}];
			view;
		});
		
		/** 箭头图标 */
		self.arrowImageView =  ({
			UIImageView *imageView = [[UIImageView alloc] init];
			QMSetImage(imageView, @"icon_arrow_dqm_888888");
			[self.contentView addSubview: imageView];
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
				make.centerY.mas_equalTo(self.contentView.mas_centerY);
				make.size.mas_equalTo(CGSizeMake(25, 25));
			}];
			imageView;
		});
		[RACObserve(self, showArrow) subscribeNext:^(id  _Nullable x) {
			_arrowImageView.hidden = [x boolValue];
		}];
		
		/** 图标 */
		self.iconImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[self.contentView addSubview: imageView];
			QMSetImage(imageView, @"pkq");
			if (_cellHeight != 0) {
				QMViewBorderRadius(imageView, (_cellHeight-16)/2, 0, DQMMainColor);
			} else {
				QMViewBorderRadius(imageView, 36.5, 0, DQMMainColor);
			}
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(_arrowImageView.mas_left).offset(-10).priority(1000);
				make.right.mas_equalTo(_backView.mas_right).offset(-10).priority(900);
				make.top.mas_equalTo(8);
				make.bottom.mas_equalTo(-8);
				make.width.mas_equalTo(imageView.mas_height);
			}];
			imageView;
		});
		
		/** 子标题 */
		self.subTitleLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self.contentView addSubview:label];
			label.hidden = true;
			QMLabelFontColorText(label, @"", QMSubTextColor, 16);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(_arrowImageView.mas_left).offset(-10);
				make.centerY.mas_equalTo(_backView.mas_centerY);
				make.right.mas_equalTo(self.mas_right).offset(-10).priority(800);
			}];
			label;
		});
		
		/** 标题 */
		self.titleLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self.contentView addSubview:label];
			QMLabelFontColorText(label, @"京东白条-获额版", QMTextColor, 16);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(_backView.mas_left).offset(12);
				make.centerY.mas_equalTo(_backView.mas_centerY);
				make.right.mas_equalTo(_arrowImageView.mas_left).offset(-10).priority(1000);
				make.right.mas_equalTo(_subTitleLabel.mas_left).offset(-10).priority(900);
				make.right.mas_equalTo(_arrowImageView.mas_left).offset(-10).priority(800);
			}];
			label;
		});
		
		
	}
	return self;
}

- (void)setCellHeight:(CGFloat)cellHeight
{
	_cellHeight = cellHeight;
	[self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(self.contentView);
		if (_cellHeight != 0) {
			make.height.mas_equalTo(cellHeight);
		}
	}];
}


@end


