//
//  GameHeaderADCollectionViewCell.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/22.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "GameHeaderADCollectionViewCell.h"

@interface GameHeaderADCollectionViewCell ()

/** 内容 */
@property(nonatomic,strong) UILabel          *contnetLabel;
/** 图片 */
@property(nonatomic,strong) UIImageView          *faceImageView;

@end

@implementation GameHeaderADCollectionViewCell

+(GameHeaderADCollectionViewCell *)cellWithcollectionView:(UICollectionView *)collectionView forIndexPath:indexPath
{
  static NSString *identifier = @"GameHeaderADCollectionViewCell";
  GameHeaderADCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
  if (cell == nil)
  {
    cell = [[GameHeaderADCollectionViewCell alloc] initWithFrame:CGRectZero];
  }
  return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    UIImageView *faceImageView = ({
      UIImageView *imageView = [[UIImageView alloc] init];
      QMViewBorderRadius(imageView, 20, 1, [UIColor whiteColor]);
      [self addSubview: imageView];
      imageView.image = [UIImage imageNamed:@"logo"];
      [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(3);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 40));
      }];
      imageView;
    });
    self.faceImageView = faceImageView;
    
    self.contnetLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      QMLabelFontColorText(label, @"name", UIColor.whiteColor, 20);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(faceImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.right.mas_equalTo(self.mas_right).offset(-10);
      }];
      label;
    });
  }
  return self;
}

- (void)setModel:(NSDictionary *)model
{
  _model = model;
  self.contnetLabel.text = _model[@"name"];
  
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
  // 获得每个cell的属性集
  UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
  // 计算cell里面textfield的宽度
  CGRect frame = [self.contnetLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 79) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.contnetLabel.font,NSFontAttributeName, nil] context:nil];
  
  // 这里在本身宽度的基础上 又增加了10
  frame.size.width += 80;
  frame.size.height = 79;
  
  // 重新赋值给属性集
  attributes.frame = frame;
  
  return attributes;
}


@end
