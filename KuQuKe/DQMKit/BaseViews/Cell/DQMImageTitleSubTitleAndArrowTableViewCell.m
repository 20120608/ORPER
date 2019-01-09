//
//  DQMImageTitleSubTitleAndArrowTableViewCell.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMImageTitleSubTitleAndArrowTableViewCell.h"

@interface DQMImageTitleSubTitleAndArrowTableViewCell ()

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

@implementation DQMImageTitleSubTitleAndArrowTableViewCell


 +(DQMImageTitleSubTitleAndArrowTableViewCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath andFixedHeightIfNeed:(CGFloat)height showArrow:(BOOL)showArrow
{
  static NSString *identifier = @"DQMImageTitleSubTitleAndArrowTableViewCell";
  DQMImageTitleSubTitleAndArrowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil) {
    cell = [[DQMImageTitleSubTitleAndArrowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        }
      }];
      view;
    });
    
    /** 图标 */
    self.iconImageView = ({
      UIImageView *imageView = [[UIImageView alloc] init];
      [self.contentView addSubview: imageView];
      QMSetImage(imageView, @"10");
      QMViewBorderRadius(imageView, 4, 0, DQMMainColor);
      [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.top.mas_equalTo(8);
        make.bottom.mas_equalTo(-8);
        make.width.mas_equalTo(imageView.mas_height);
      }];
      imageView;
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
    
    /** 标题 */
    self.titleLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self.contentView addSubview:label];
      QMLabelFontColorText(label, @"titleLabel", QMTextColor, 16);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_right).offset(8);
        make.top.mas_equalTo(_iconImageView.mas_top);
        make.right.mas_equalTo(self.mas_right).offset(-10).priority(800);
        make.right.mas_equalTo(_arrowImageView.mas_left).offset(-10).priority(900);
      }];
      label;
    });
    
    /** 子标题 */
    self.subTitleLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self.contentView addSubview:label];
      QMLabelFontColorText(label, @"sub_titleLabel", QMSubTextColor, 16);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_right).offset(8);
        make.bottom.mas_equalTo(_iconImageView.mas_bottom);
        make.right.mas_equalTo(self.mas_right).offset(-10).priority(800);
        make.right.mas_equalTo(_arrowImageView.mas_left).offset(-10).priority(900);
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

