//
//  AvgButtonMenuTableViewCell.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/8.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "AvgButtonMenuTableViewCell.h"

@interface AvgButtonMenuTableViewCell ()

/** 下标 */
@property (nonatomic,copy  ) NSIndexPath    *indexPath;
/** 固定高度 0则自适应 */
@property (nonatomic,assign) CGFloat        cellHeight;
/** 按钮数组 */
@property (nonatomic,strong) NSMutableArray *buttonArray;
/** 个数 */
@property(nonatomic,assign) NSInteger       num;
/** 数组 */
@property(nonatomic,strong) NSArray          *datasArray;


@property (nonatomic,assign) CGFloat        fixedSpcing;
@property (nonatomic,assign) CGFloat        leadSpacing;
@property (nonatomic,assign) CGFloat        tailSpacing;

@end


@implementation AvgButtonMenuTableViewCell

+(AvgButtonMenuTableViewCell *)cellWithTableView:(UITableView *)tableView initWithButtonsNum:(NSInteger)num  indexPath:(NSIndexPath *)indexPath andFixedHeightIfNeed:(CGFloat)height WithDatasArray:(NSArray *)datasArray withFixedSpacing:(CGFloat)fixedSpcing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;
{
  static NSString *identifier = @"AvgButtonMenuTableViewCell";
  AvgButtonMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil) {
    cell = [[AvgButtonMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
	cell.num = num;
	//比num晚设置
	cell.datasArray = datasArray;
	//最后设置
	cell.cellHeight = height;
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self)
  {
    self.buttonArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
      UIButton *button = ({
        QMButton *button = [QMButton buttonWithType:UIButtonTypeCustom withSpace:5];
        button.padding = 5;
        button.buttonStyle = QMButtonImageTop;
        [self.contentView addSubview:button];
        button.tag = i;
        QMSetButton(button, @"menu", 12, @"ic_reading_trails_yellow", QMTextColor, UIControlStateNormal);
        QMSetButton(button, @"menu", 12, @"ic_reading_trails_yellow", QMTextColor, UIControlStateSelected);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button;
      });
      [_buttonArray addObject:button];
    }
    
  }
  return self;
}

#pragma mark - setting
- (void)setCellHeight:(CGFloat)cellHeight {
  _cellHeight = cellHeight;
  if (cellHeight != 0) {
    [_buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [_buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(0);
      make.bottom.mas_equalTo(0).priority(1000);
      make.height.mas_equalTo(cellHeight).priority(1000);
    }];
  }
}

- (void)setNum:(NSInteger)num {
  //移除不要的按钮
  _num = num;
  NSMutableArray *needButtonArray = [[NSMutableArray alloc] init];
  for (int i = ((int)_buttonArray.count-1); i >= 0; i--) {
    if (i >= num) {
      [_buttonArray[i] removeFromSuperview];
    } else {
      [needButtonArray addObject:_buttonArray[i]];
    }
  }
  //倒叙
  needButtonArray = (NSMutableArray *)[[needButtonArray reverseObjectEnumerator] allObjects];
  self.buttonArray = needButtonArray;
}

- (void)setDatasArray:(NSArray *)datasArray {
  _datasArray = datasArray;
  if (datasArray.count <= _buttonArray.count) {
    for (int i = 0; i < datasArray.count; i++) {
      
      //设置按钮的样式
      QMButton *btn = _buttonArray[i];
      NSDictionary *dataDic = datasArray[i];
      QMSetButton(btn, dataDic[@"name"], 12, dataDic[@"icon"], QMTextColor, UIControlStateNormal);
      QMSetButton(btn, dataDic[@"name"], 12, dataDic[@"icon"], QMTextColor, UIControlStateSelected);
    }
  }
}

- (void)setButtonTitleFont:(UIFont *)buttonTitleFont {
  _buttonTitleFont = buttonTitleFont;
  for (QMButton *btn in _buttonArray) {
    [btn.titleLabel setFont:buttonTitleFont];
  }
}


- (void)buttonClick:(QMButton *)sender {
  NSLog(@"选中的下标");
  if ([self.delegate respondsToSelector:@selector(avgButtonMenuTableViewCell:didSelectRowAtIndex:superIndexPath:)]) {
    [self.delegate avgButtonMenuTableViewCell:self didSelectRowAtIndex:sender.tag superIndexPath:_indexPath];
  }
}


@end
