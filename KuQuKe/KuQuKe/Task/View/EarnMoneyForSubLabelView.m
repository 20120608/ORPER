//
//  EarnMoneyForSubLabelView.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "EarnMoneyForSubLabelView.h"

@interface EarnMoneyForSubLabelView ()

/** 图片 */
@property (nonatomic,strong) UIImageView *iconImageView;

/** 子标签1 */
@property (nonatomic,strong) UILabel     *subLabel1;
/** 子标签2 */
@property (nonatomic,strong) UILabel     *subLabel2;
/** 子标签3 */
@property (nonatomic,strong) UILabel     *subLabel3;
/** 子标签4 */
@property (nonatomic,strong) UILabel     *subLabel4;



@end

@implementation EarnMoneyForSubLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    /** 图片 */
    self.iconImageView =  ({
      UIImageView *imageView = [[UIImageView alloc] init];
      [self addSubview: imageView];
      QMSetImage(imageView,@"banner");
      [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.top.mas_equalTo(self.mas_top).offset(12);
        make.width.mas_equalTo(kScreenWidth);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-60);
        make.size.mas_equalTo(CGSizeMake(140, 44));
      }];
      imageView;
    });
    
    /** 子标签1 */
    self.subLabel1 = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
//      label.hidden = true;
      label.backgroundColor = QMBackColor;
      QMViewBorderRadius(label, 2, 1, QMSubTextColor);
      QMLabelFontColorText(label, @" 子标签1 ", QMSubTextColor, 12);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
      }];
      label;
    });
    /** 子标签2 */
    self.subLabel2 = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
//      label.hidden = true;
      label.backgroundColor = QMBackColor;
      QMViewBorderRadius(label, 2, 1, QMSubTextColor);
      QMLabelFontColorText(label, @" 子标签2 ", QMSubTextColor, 12);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_subLabel1.mas_right).offset(10);
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
      }];
      label;
    });
    /** 子标签3 */
    self.subLabel3 = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
//      label.hidden = true;
      label.backgroundColor = QMBackColor;
      QMViewBorderRadius(label, 2, 1, QMSubTextColor);
      QMLabelFontColorText(label, @" 子标签3 ", QMSubTextColor, 12);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_subLabel2.mas_right).offset(10);
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
      }];
      label;
    });
    /** 子标签4 */
    self.subLabel4 = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
//      label.hidden = true;
      label.backgroundColor = QMBackColor;
      QMViewBorderRadius(label, 2, 1, QMSubTextColor);
      QMLabelFontColorText(label, @" 子标签4 ", QMSubTextColor, 12);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_subLabel3.mas_right).offset(10);
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
      }];
      label;
    });
    
    
    UIView *garyView = ({
      UIView *view = [[UIView alloc] init];
      [self addSubview: view];
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 10));
      }];
      view;
    });
    garyView.backgroundColor = QMBackColor;

    
  }
  return self;
}

@end
