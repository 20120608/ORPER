//
//  GameTaskCheckInTableViewCell.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/19.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "GameTaskCheckInTableViewCell.h"
@interface  GameTaskCheckInTableViewCell ()

/** 下标 */
@property (nonatomic,copy  ) NSIndexPath *indexPath;
/** 用来撑开高度的View */
@property(nonatomic,strong) UIView          *backView;

@end

@implementation GameTaskCheckInTableViewCell

+(GameTaskCheckInTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight
{
  static NSString *identifier = @"GameTaskCheckInTableViewCell";
  GameTaskCheckInTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil)
  {
    cell = [[GameTaskCheckInTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
    
  }
  return self;
}


- (void)setFixedCellHeight:(CGFloat)fixedCellHeight {
  _fixedCellHeight = fixedCellHeight;
  if (fixedCellHeight != 0) {
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
      make.height.mas_equalTo(fixedCellHeight);
    }];
  }
}




@end

