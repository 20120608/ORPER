//
//  ADHorizontalCollectionViewCell.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/7.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "ADHorizontalCollectionViewCell.h"

@interface ADHorizontalCollectionViewCell ()

/** 内容 */
@property(nonatomic,strong) UILabel          *contnetLabel;
/** 图片 */
@property(nonatomic,strong) UIImageView          *faceImageView;

@end

@implementation ADHorizontalCollectionViewCell

+(ADHorizontalCollectionViewCell *)cellWithcollectionView:(UICollectionView *)collectionView forIndexPath:indexPath
{
  static NSString *identifier = @"ADHorizontalCollectionViewCell";
  ADHorizontalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
  if (cell == nil)
  {
    cell = [[ADHorizontalCollectionViewCell alloc] initWithFrame:CGRectZero];
  }
  return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
     UIImageView *faceImageView = ({
      UIImageView *imageView = [[UIImageView alloc] init];
      QMViewBorderRadius(imageView, 12.5, 1, [UIColor redColor]);
      [self addSubview: imageView];
      [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(3);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(25, 25));
      }];
      imageView;
    });
    self.faceImageView = faceImageView;
    
    self.contnetLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      QMLabelFontColorText(label, @"name", DQMMainColor, 12);
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

#pragma mark — 实现自适应文字宽度的关键步骤:item的layoutAttributes
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
  
  UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
  CGRect rect = [self.contnetLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 38) options:NSStringDrawingTruncatesLastVisibleLine| NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
  rect.size.width +=8;
  rect.size.height+=8;
attributes.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width+35, rect.size.height);
 return attributes;
  
}

@end
