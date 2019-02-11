//
//  GameTaskCheckInTableViewCell.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/19.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "GameTaskCheckInTableViewCell.h"

#import "GameHeaderADCollectionViewCell.h"


@interface  GameTaskCheckInTableViewCell () <UICollectionViewDelegate,UICollectionViewDataSource>

/** 下标 */
@property (nonatomic,copy  ) NSIndexPath      *indexPath;
/** 用来撑开高度的View */
@property (nonatomic,strong) UIView           *backView;

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
    self.backgroundColor = QMBackColor;
    self.backView = ({
      UIView *view = [[UIView alloc] init];
      [self.contentView addSubview: view];
      view.backgroundColor = DQMMainColor;
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 0, 0, 0));
      }];
      view;
    });
    
    UIImageView *logoImageView = [[UIImageView alloc] init];
    [_backView addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(12);
      make.top.mas_equalTo(-25);
      make.size.mas_equalTo(CGSizeMake(AdaptedWidth(100), AdaptedWidth(100)));
    }];
    
    UIButton *strategyButton = ({
      UIButton *button = [[UIButton alloc] init];
      [_backView addSubview:button];
      QMSetButton(button, @"攻略", 16, @"icon_gametaskDetail_first", QMYellowColor, UIControlStateNormal);
      QMViewBorderRadius(button, 16, 0, DQMMainColor);
      button.backgroundColor = [UIColor colorWithHexString:@"535353" alpha:0.53];
      [button addTarget:self action:@selector(strategyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_backView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 32));
        make.top.mas_equalTo(2);
      }];
      button;
    });
    
    UILabel *titleLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [_backView addSubview:label];
      QMLabelFontColorText(label, @"红包大派送", UIColor.whiteColor, 24);
      label.font = [UIFont boldSystemFontOfSize:24];
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logoImageView.mas_right).offset(10);
        make.top.mas_equalTo(_backView.mas_top).offset(5);
        make.right.mas_equalTo(strategyButton.mas_left).offset(-10);
      }];
      label;
    });
    
    UILabel *timeLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [_backView addSubview:label];
      QMLabelFontColorText(label, @"活动时间: _ _ _ _ _", [UIColor colorWithHexString:@"f4f4f4" alpha:0.78], 14);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logoImageView.mas_right).offset(10);
        make.bottom.mas_equalTo(logoImageView.mas_bottom).offset(-5);
        make.right.mas_equalTo(_backView.mas_right).offset(-10);
      }];
      label;
    });
    
    UIView *alphaView = ({
      UIView *view = [[UIView alloc] init];
      [_backView addSubview: view];
      QMViewBorderRadius(view, 6, 0, DQMMainColor);
      view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4" alpha:0.48];
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(_backView.mas_right).offset(-12);
        make.height.mas_equalTo(79);
        make.top.mas_equalTo(logoImageView.mas_bottom).offset(5);
      }];
      view;
    });
    
    UILabel *priceLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [alphaView addSubview:label];
      QMLabelFontColorText(label, @"1234.56元", QMYellowColor, 25);
      label.font = [UIFont boldSystemFontOfSize:25];
      label.adjustsFontSizeToFitWidth = YES;
      label.textAlignment = NSTextAlignmentCenter;
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(2);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(104);
        make.height.mas_equalTo(30);
      }];
      label;
    });
    
    UILabel *msgLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [alphaView addSubview:label];
      QMLabelFontColorText(label, @"累计提取金额", UIColor.whiteColor, 14);
      label.textAlignment = NSTextAlignmentCenter;
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(2);
        make.width.mas_equalTo(104);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(priceLabel.mas_bottom);
      }];
      label;
    });
    
    UIView *line = ({
      UIView *view = [[UIView alloc] init];
      [alphaView addSubview: view];
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(108);
        make.top.mas_equalTo(18);
        make.bottom.mas_equalTo(-18);
        make.width.mas_equalTo(1);
      }];
      view;
    });
    line.backgroundColor = DQMMainColor;

    
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; //设置竖直滚动
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.estimatedItemSize = CGSizeMake(150, 79);
    
    self.collectionView = ({
      UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(38, 0, kScreenWidth-24-110, 79) collectionViewLayout:layout];
      [alphaView addSubview: view];
      view.delegate = self;
      view.dataSource = self;
      view.backgroundColor = [UIColor clearColor];
      [view registerClass:[GameHeaderADCollectionViewCell class] forCellWithReuseIdentifier:@"GameHeaderADCollectionViewCell"];
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.top.mas_equalTo(0);
        make.left.mas_equalTo(110);
      }];
      view;
    });
    
    
    QMWeak(self);
    [[RACObserve(self, cellModel) skip:1] subscribeNext:^(GameTaskCheckInTableViewCellModel *x) {
      titleLabel.text = x.name;
      timeLabel.text = [NSString stringWithFormat:@"活动时间: %@",x.taskTime];
      priceLabel.text = [NSString stringWithFormat:@"%.2lf元",[x.price floatValue]];
      [weakself.collectionView reloadData];
    }];
    
  
  }
  return self;
}


#pragma mark - uicollection
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
  return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [_cellModel.historyArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  GameHeaderADCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GameHeaderADCollectionViewCell" forIndexPath:indexPath];
  cell.model = _cellModel.historyArray[indexPath.item];
  return cell;
}

#pragma mark - touch event
- (void)strategyButtonClick:(UIButton *)sender {
  
}




#pragma mark - setting
- (void)setFixedCellHeight:(CGFloat)fixedCellHeight {
  _fixedCellHeight = fixedCellHeight;
  if (fixedCellHeight != 0) {
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.edges.mas_equalTo(UIEdgeInsetsMake(5, 0, 0, 0));
      make.height.mas_equalTo(fixedCellHeight-5).priority(1000);
    }];
  }
}






@end


@implementation GameTaskCheckInTableViewCellModel



@end

