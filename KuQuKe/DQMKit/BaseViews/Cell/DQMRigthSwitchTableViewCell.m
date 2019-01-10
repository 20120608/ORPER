//
//  DQMRigthSwitchTableViewCell.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/10.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMRigthSwitchTableViewCell.h"

@interface DQMRigthSwitchTableViewCell ()

/** 背景图层 */
@property (nonatomic,strong) UIView      *backView;
/** 标题 */
@property (nonatomic,strong) UILabel     *titleLabel;

/** 下标 */
@property (nonatomic,copy  ) NSIndexPath *indexPath;
/** 固定高度 0则自适应 */
@property (nonatomic,assign) CGFloat     cellHeight;

@end

@implementation DQMRigthSwitchTableViewCell


+(DQMRigthSwitchTableViewCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath andFixedHeightIfNeed:(CGFloat)height
{
  static NSString *identifier = @"DQMRigthSwitchTableViewCell";
  DQMRigthSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil)
  {
    cell = [[DQMRigthSwitchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  cell.indexPath = indexPath;
  if (height != 0) {
    cell.cellHeight = height;
  } else {
    cell.cellHeight = 56;
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
        make.width.mas_equalTo(kScreenWidth);
        if (_cellHeight != 0) {
          make.height.mas_equalTo(_cellHeight);
        } else {
          make.height.mas_equalTo(89);
        }
      }];
      view;
    });
    
    /** 标题 */
    self.titleLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [_backView addSubview:label];
      QMLabelFontColorText(label, @"titleLabel", QMTextColor, 16);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.centerY.mas_equalTo(_backView.mas_centerY);
      }];
      label;
    });
    
    self.rightSwitch = ({
      UISwitch *rSwitch = [[UISwitch alloc] init];
      [_backView addSubview: rSwitch];
      [rSwitch addTarget:self action:@selector(rSwitchClick:) forControlEvents:UIControlEventValueChanged];
      [rSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 25));
        make.right.mas_equalTo(_backView.mas_right).offset(-10);
      }];
      rSwitch;
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

- (void)setSwitchOn:(BOOL)switchOn {
  
  [self.rightSwitch setOn:switchOn];
  
}


#pragma mark - event
- (void)rSwitchClick:(UISwitch *)sender {
  if (_rightSwitchValueChangeBlock) {
    NSLog(@"触发了点击事件的回调");
    _rightSwitchValueChangeBlock(sender.isOn);
  }
}


#pragma mark - dataSource
- (void)setModel:(DQMRigthSwitchTableViewCellModel *)model {
  
  /** 标题 */
  self.titleLabel.text = model.title;
  
  [self.rightSwitch setOn:[model.isOn boolValue]];
  
}


@end


@implementation DQMRigthSwitchTableViewCellModel


+(DQMRigthSwitchTableViewCellModel *)initWithtitle:(NSString *)title andison:(NSString *)isOn {
  DQMRigthSwitchTableViewCellModel *model = [[DQMRigthSwitchTableViewCellModel alloc] init];
  model.title = title;
  model.isOn = isOn;
  return model;
}

@end

