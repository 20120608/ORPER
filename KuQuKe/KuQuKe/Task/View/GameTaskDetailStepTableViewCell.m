//
//  GameTaskDetailStepTableViewCell.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/23.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "GameTaskDetailStepTableViewCell.h"
#import "GameTaskStepView.h"//游戏互动的步骤view

@interface  GameTaskDetailStepTableViewCell ()

/** 下标 */
@property (nonatomic,copy  ) NSIndexPath *indexPath;
/** 用来撑开高度的View */
@property(nonatomic,strong) UIView          *backView;

@end

@implementation GameTaskDetailStepTableViewCell

+(GameTaskDetailStepTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight
{
  static NSString *identifier = @"GameTaskDetailStepTableViewCell";
  GameTaskDetailStepTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil)
  {
    cell = [[GameTaskDetailStepTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.backgroundColor = DQMMainColor;
    
    self.backView = ({
      UIView *view = [[UIView alloc] init];
      [self.contentView addSubview: view];
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
      }];
      view;
    });
    
    //最底部透明色
    UIView *alphaView = ({
      UIView *view = [[UIView alloc] init];
      [_backView addSubview: view];
      QMViewBorderRadius(view, 6, 0, UIColor.whiteColor);
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 0, 0));
      }];
      view;
    });
    alphaView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4" alpha:0.4];

    //第二个白色
    UIView *whiteView = ({
      UIView *view = [[UIView alloc] init];
      [_backView addSubview: view];
      QMViewBorderRadius(view, 6, 0, UIColor.whiteColor);
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 5, 5));
      }];
      view;
    });
    whiteView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];

    
    //参加条件
    UIImageView *coditionImageView =  ({
      UIImageView *imageView = [[UIImageView alloc] init];
      QMSetImage(imageView, @"icon_gametaskDetail_second");
      [_backView addSubview: imageView];
      [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backView.mas_left).offset(-13);
        make.top.mas_equalTo(_backView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(154, 44));
      }];
      imageView;
    });
    UILabel *coditionLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [coditionImageView addSubview:label];
      label.textAlignment = NSTextAlignmentCenter;
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(-3, 0, 0, 0));
      }];
      label;
    });
    QMLabelFontColorText(coditionLabel, @"参加条件", QMTextColor, 16);
    coditionLabel.font = [UIFont boldSystemFontOfSize:16];

    
    //提示
    UILabel *msgLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [_backView addSubview:label];
      label.textAlignment = NSTextAlignmentCenter;
      QMLabelFontColorText(label, @"请务必验证完成再完成任务", QMPriceColor, 25);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(coditionImageView.mas_right).offset(10);
        make.right.mas_equalTo(_backView.mas_right).offset(-15);
        make.height.mas_equalTo(38);
        make.centerY.mas_equalTo(coditionLabel.mas_centerY);
      }];
      label;
    });
    msgLabel.adjustsFontSizeToFitWidth = true;

    
    NSMutableArray *gameTaskStepViewArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; i++) {
      GameTaskStepView *stepView = ({
        GameTaskStepView *view = [[GameTaskStepView alloc] init];
        [_backView addSubview: view];
        view;
      });
      [gameTaskStepViewArray addObject:stepView];
    }
    
    [gameTaskStepViewArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:5 leadSpacing:54 tailSpacing:40];
    [gameTaskStepViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(5);
      make.right.mas_equalTo(_backView.mas_right).offset(-15);
    }];
    
    
    QMWeak(self);
    [[RACObserve(self, cellModel) skip:1] subscribeNext:^(GameTaskDetailStepTableViewCellModel *x) {
      
      NSMutableArray *newStepViewArray = [[NSMutableArray alloc] init];
      [gameTaskStepViewArray enumerateObjectsUsingBlock:^(GameTaskStepView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < [x.stepMArray count]) {
          [newStepViewArray addObject:obj];
        }else {
          [obj removeFromSuperview];
        }
      }];
      
      [newStepViewArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:5 leadSpacing:54 tailSpacing:40];
      [newStepViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(weakself.backView.mas_right).offset(-15);
      }];
      
      [self setNeedsLayout];
      [self layoutIfNeeded];
      
      [x.stepMArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
          ((GameTaskStepView *)newStepViewArray[idx]).style = GameTaskStepViewStyleDefault;
        } else {
          ((GameTaskStepView *)newStepViewArray[idx]).style = GameTaskStepViewStyleBackgroundColorGary;
        }
      }];
      
    }];
    
    
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



@implementation GameTaskDetailStepTableViewCellModel



@end
