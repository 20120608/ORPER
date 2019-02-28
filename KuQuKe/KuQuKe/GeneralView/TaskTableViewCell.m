//
//  TaskTableViewCell.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/7.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "TaskTableViewCell.h"

@interface TaskTableViewCell ()

/** 背景图层 */
@property(nonatomic,strong) UIView 			*backView;
/** 图标 */
@property(nonatomic,strong) UIImageView      *iconImageView;
/** 标题 */
@property(nonatomic,strong) UILabel          *titleLabel;
/** 子标题 */
@property(nonatomic,strong) UILabel          *subTitleLabel;
/** 价格 */
@property(nonatomic,strong) UILabel          *priceLabel;
/** 来源 */
@property(nonatomic,strong) UILabel          *sourceLabel;
/** 状态 */
@property(nonatomic,strong) UILabel          *statusLabel;

/** 子标签1 */
@property(nonatomic,strong) UILabel          *subLabel1;
/** 子标签2 */
@property(nonatomic,strong) UILabel          *subLabel2;
/** 子标签3 */
@property(nonatomic,strong) UILabel          *subLabel3;
/** 子标签4 */
@property(nonatomic,strong) UILabel          *subLabel4;


/** 下标 */
@property(nonatomic,copy) NSIndexPath          *indexPath;
/** 固定高度 0则自适应 */
@property(nonatomic,assign) CGFloat          cellHeight;

@end

@implementation TaskTableViewCell


+(TaskTableViewCell *)cellWithTableView:(UITableView *)tableview initWithCellStyle:(TaskTableViewCellStyle)style indexPath:(NSIndexPath *)indexPath andFixedHeightIfNeed:(CGFloat)height
{
	static NSString *identifier = @"TaskTableViewCell";
	TaskTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil)
	{
		cell = [[TaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	cell.indexPath = indexPath;
	cell.cellStyle = style;
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
				}
			}];
			view;
		});
		
		/** 图标 */
		self.iconImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[self.contentView addSubview: imageView];
			QMSetImage(imageView, @"logo");
			QMViewBorderRadius(imageView, 4, 0, DQMMainColor);
      imageView.contentMode = UIViewContentModeScaleAspectFit;
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(24);
				make.top.mas_equalTo(13);
				make.bottom.mas_equalTo(-13);
				make.width.mas_equalTo(imageView.mas_height);
			}];
			imageView;
		});
		/** 标题 */
		self.titleLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self.contentView addSubview:label];
			QMLabelFontColorText(label, @"京东白条-获额版", QMTextColor, 16);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(_iconImageView.mas_right).offset(8);
				make.top.mas_equalTo(_iconImageView.mas_top);
				make.right.mas_equalTo(self.mas_right).offset(-60);
			}];
			label;
		});
		
		/** 子标题 */
		self.subTitleLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self.contentView addSubview:label];
			QMLabelFontColorText(label, @"线上完成 高通过率", QMSubTextColor, 14);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(_iconImageView.mas_right).offset(8);
				make.bottom.mas_equalTo(_iconImageView.mas_bottom);
				make.right.mas_equalTo(self.mas_right).offset(-60);
			}];
			label;
		});
		
		/** 子标签1 */
		self.subLabel1 = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			label.hidden = true;
			QMViewBorderRadius(label, 2, 1, QMSubTextColor);
			QMLabelFontColorText(label, @" 子标签1 ", QMSubTextColor, 12);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(_iconImageView.mas_right).offset(8);
				make.bottom.mas_equalTo(_iconImageView.mas_bottom);
				make.height.mas_equalTo(18);
			}];
			label;
		});
		/** 子标签2 */
		self.subLabel2 = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			label.hidden = true;
			QMViewBorderRadius(label, 2, 1, QMSubTextColor);
			QMLabelFontColorText(label, @" 子标签2 ", QMSubTextColor, 12);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(_subLabel1.mas_right).offset(4);
				make.bottom.mas_equalTo(_iconImageView.mas_bottom);
				make.height.mas_equalTo(18);
			}];
			label;
		});
		/** 子标签3 */
		self.subLabel3 = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			label.hidden = true;
			QMViewBorderRadius(label, 2, 1, QMSubTextColor);
			QMLabelFontColorText(label, @" 子标签3 ", QMSubTextColor, 12);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(_subLabel2.mas_right).offset(4);
				make.bottom.mas_equalTo(_iconImageView.mas_bottom);
				make.height.mas_equalTo(18);
			}];
			label;
		});
		/** 子标签4 */
		self.subLabel4 = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			label.hidden = true;
			QMViewBorderRadius(label, 2, 1, QMSubTextColor);
			QMLabelFontColorText(label, @" 子标签4 ", QMSubTextColor, 12);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(_subLabel3.mas_right).offset(4);
				make.bottom.mas_equalTo(_iconImageView.mas_bottom);
				make.height.mas_equalTo(18);
			}];
			label;
		});
		
		/** 来源 */
		self.sourceLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self.contentView addSubview:label];
			QMLabelFontColorText(label, @"支付宝", QMTextColor, 14);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(-13);
				make.bottom.mas_equalTo(_iconImageView.mas_bottom);
				make.height.mas_equalTo(15);
			}];
			label;
		});
		
		/** 状态 */
		self.statusLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self.contentView addSubview:label];
			QMViewBorderRadius(label, 7.5, 1, QMPriceColor);
			QMLabelFontColorText(label, @" 进行中 ", QMPriceColor, 11);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(-13);
				make.height.mas_equalTo(15);
				make.bottom.mas_equalTo(_iconImageView.mas_bottom);
			}];
			label;
		});
		
		/** 价格 */
		self.priceLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self.contentView addSubview:label];
			QMLabelFontColorText(label, @"+1.5元", QMPriceColor, 15);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(-13);
				make.bottom.mas_equalTo(_iconImageView.mas_bottom).priority(700);
				make.bottom.mas_equalTo(_sourceLabel.mas_top).offset(-6).priority(800);
				make.bottom.mas_equalTo(_statusLabel.mas_top).offset(-6).priority(900);
			}];
			label;
		});
		
		
		//分割线
		UIView *seperaterLine = [[UIView alloc] initWithFrame: CGRectZero];
		seperaterLine.backgroundColor = QMBackColor;
		[self.contentView addSubview:seperaterLine];
		[seperaterLine mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.right.bottom.mas_equalTo(0);
			make.height.mas_equalTo(2);
		}];
		
		[RACObserve(self, showSeperaterLine) subscribeNext:^(id  _Nullable x) {
			seperaterLine.hidden = ![x boolValue];
		}];
    
    
    
    //设置数据
    [[RACObserve(self, homeTaskModel) skip:1] subscribeNext:^(HomeTaskRecommendModel *x) {
      
      /** 图标 */
      [self.iconImageView qm_setImageUrlString:x.img_url];
      
      /** 标题 */
      self.titleLabel.text = x.title;
      
      /** 子标题 */
      self.subTitleLabel.text = x.desc;
      
      /** 价格 */
      NSString *priceString = [NSString stringWithFormat:@"+%0.2f元",[x.price floatValue]];
      self.priceLabel.attributedText = [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:priceString font:kQmFont(16) rangeOfFont:NSMakeRange(0, priceString.length) color:DQMMainColor rangeOfColor:NSMakeRange(0, priceString.length)];
      
    }];
    
    //设置数据
    [[RACObserve(self, appTaskModel) skip:1] subscribeNext:^(APPTaskModel *x) {
      
      /** 图标 */
      [self.iconImageView qm_setImageUrlString:x.img_url];
      
      /** 标题 */
      self.titleLabel.text = x.title;
      
      /** 子标题 */
      self.subTitleLabel.text = x.desc;
      
      /** 价格 */
      NSString *priceString = [NSString stringWithFormat:@"+%0.2f元",[x.price floatValue]];
      self.priceLabel.attributedText = [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:priceString font:kQmFont(16) rangeOfFont:NSMakeRange(0, priceString.length) color:QMPriceColor rangeOfColor:NSMakeRange(0, priceString.length)];
      @weakify(self)
      [x.mark enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        self.subLabel1.hidden = self.subLabel2.hidden = self.subLabel3.hidden =  self.subLabel4.hidden = true;
        for (int i = 0; i < [x.mark count]; i++) {
          if (i == 0) {
            self.subLabel1.hidden = false;
            self.subLabel1.text = [NSString stringWithFormat:@"  %@  ",x.mark[i]];
          } else if (i == 1) {
            self.subLabel2.hidden = false;
            self.subLabel2.text = [NSString stringWithFormat:@"  %@  ",x.mark[i]];
          } else if (i == 2) {
            self.subLabel3.hidden = false;
            self.subLabel3.text = [NSString stringWithFormat:@"  %@  ",x.mark[i]];
          } else if (i == 3) {
            self.subLabel4.hidden = false;
            self.subLabel4.text = [NSString stringWithFormat:@"  %@  ",x.mark[i]];
          }
        }
      }];
    }];
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

- (void)setCellStyle:(TaskTableViewCellStyle)cellStyle {
	_cellStyle = cellStyle;
	
	_subLabel1.hidden = _subLabel2.hidden = _subLabel3.hidden = _subLabel4.hidden = true;
	
	
	switch (cellStyle) {
		case TaskTableViewCellStylePriceLabelRedColor:
		{
			[_statusLabel removeFromSuperview];
			[_sourceLabel removeFromSuperview];
			_priceLabel.textColor = QMPriceColor;
			[_priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(-13);
				make.centerY.mas_equalTo(_iconImageView.mas_centerY);
			}];

		}
			break;
		case TaskTableViewCellStylePriceLabelGreenColor:
		{
			[_statusLabel removeFromSuperview];
			[_sourceLabel removeFromSuperview];
			_priceLabel.textColor = DQMMainColor;
		}
			break;
		case TaskTableViewCellStyleSubTag:
		{
			[_statusLabel removeFromSuperview];
			[_subTitleLabel removeFromSuperview];
			[_sourceLabel removeFromSuperview];
			_priceLabel.textColor = QMPriceColor;
			_subLabel1.hidden = _subLabel2.hidden = _subLabel3.hidden = _subLabel4.hidden = false;
			[_priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(-13);
				make.centerY.mas_equalTo(_iconImageView.mas_centerY);
			}];
		}
			break;
		case TaskTableViewCellStyleNoImage:
		{
			[_statusLabel removeFromSuperview];
			_iconImageView.hidden = true;
			_titleLabel.text = @"提现到微信";
			_subTitleLabel.text = @"2019年01月13日12:04:32";
			/** 标题 */
			[self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(8);
				make.top.mas_equalTo(8);
				make.right.mas_equalTo(self.mas_right).offset(-60);
			}];
			
			/** 子标题 */
			[self.subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(8);
				make.bottom.mas_equalTo(-8);
				make.right.mas_equalTo(self.mas_right).offset(-60);
			}];
			
			/** 子标签1 */
			[self.subLabel1 mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(8);
				make.top.mas_equalTo(8);
				make.height.mas_equalTo(15);
			}];
		}
			break;
			
		case TaskTableViewCellStyleOnGoing:
		{
			[_sourceLabel removeFromSuperview];
			_priceLabel.textColor = QMPriceColor;
			[_priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(-13);
				make.centerY.mas_equalTo(_iconImageView.mas_centerY);
			}];
			
		}
			break;
		case TaskTableViewCellStyleInCome:
		{
			[_sourceLabel removeFromSuperview];
			[_statusLabel removeFromSuperview];
			_priceLabel.textColor = QMPriceColor;
			_priceLabel.font = [UIFont systemFontOfSize:15];
			[_priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(-13);
				make.centerY.mas_equalTo(_iconImageView.mas_centerY);
			}];
			
			/** 图标 */
			[_iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(20);
				make.top.mas_equalTo(10);
				make.bottom.mas_equalTo(-10);
				make.width.mas_equalTo(_iconImageView.mas_height);
			}];
			/** 时间标题 */
			_subTitleLabel.font = [UIFont systemFontOfSize:12];
			_subTitleLabel.text = @"2019年01月13日12:04:32";
			[_subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(_iconImageView.mas_right).offset(8);
				make.bottom.mas_equalTo(_iconImageView.mas_bottom);
				make.right.mas_equalTo(self.mas_right).offset(-60);
			}];
			
			
		}
			break;
			
			
		default:
			break;
	}
	
	
}




@end
