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
  } else {
    cell.cellHeight = 90;
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
			QMSetImage(imageView, @"icon_dqm_arrow_cdcdcd");
			[self.contentView addSubview: imageView];
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
				make.centerY.mas_equalTo(self.contentView.mas_centerY);
				make.size.mas_equalTo(CGSizeMake(25, 25));
			}];
			imageView;
		});
		
		QMWeak(self);
		[RACObserve(self, showArrow) subscribeNext:^(id  _Nullable x) {
			weakself.arrowImageView.hidden = ![x boolValue];
		}];
		
		/** 图标 */
		self.iconImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[self.contentView addSubview: imageView];
			QMSetImage(imageView, @"logo");
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(_arrowImageView.mas_left).offset(-10).priority(1000);
				make.right.mas_equalTo(_backView.mas_right).offset(-10).priority(900);
				make.top.mas_equalTo(13);
				make.bottom.mas_equalTo(-13);
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
			QMLabelFontColorText(label, @"titleLabel", QMTextColor, 16);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(self.contentView.mas_left).offset(20);
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
  
  if (_cellHeight != 0) {
    QMViewBorderRadius(self.iconImageView, (_cellHeight-26)/2, 0, DQMMainColor);
  } else {
    QMViewBorderRadius(self.iconImageView, 32, 0, DQMMainColor);
  }
}

#pragma mark - dataSource
- (void)setModel:(DQMRightImageViewTableViewCellModel *)model {
  
  _model = model;
  /** 标题 */
  self.titleLabel.text = model.title;
	self.iconImageView.hidden = true;
	self.iconImageView.hidden = true;
	
	if (model.subImage != nil) {
		self.iconImageView.hidden = false;
		[self.iconImageView setImage:model.subImage];
	}
	else if ([model.subTitle length] != 0) {
		self.subTitleLabel.hidden = false;
		self.subTitleLabel.text = [NSString stringWithFormat:@"%@",model.subTitle];
	}
	else if ([model.subImageUrl length] > 1) {
		self.iconImageView.hidden = false;
		self.subTitleLabel.text = @"";
		[self.iconImageView qm_setWithImageURL:[NSURL URLWithString:model.subImageUrl] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
	}
	
  
	
  
}


@end


@implementation DQMRightImageViewTableViewCellModel

+(DQMRightImageViewTableViewCellModel *)initWithtitle:(NSString *)title andSubTitle:(NSString *)subTitle andsubImageUrl:(NSString *)subImageUrl {
  
  DQMRightImageViewTableViewCellModel *model = [[DQMRightImageViewTableViewCellModel alloc] init];
  model.title = title;
  model.subTitle = subTitle;
  model.subImageUrl = subImageUrl;
  return model;
  
}


+(DQMRightImageViewTableViewCellModel *)initWithtitle:(NSString *)title andSubTitle:(NSString *)subTitle andsubImageUrl:(NSString *)subImageUrl IfNeedCreateWithdestVc:(Class)destVc andviewType:(NSInteger)viewType {
  
  DQMRightImageViewTableViewCellModel *model = [[DQMRightImageViewTableViewCellModel alloc] init];
  model.title = title;
  model.subTitle = subTitle;
  model.subImageUrl = subImageUrl;
  model.destVc = destVc;
  model.viewType = viewType;
  return model;
}


@end


