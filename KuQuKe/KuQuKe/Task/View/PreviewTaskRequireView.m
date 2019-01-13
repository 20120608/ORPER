//
//  PreviewTaskRequireView.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "PreviewTaskRequireView.h"
#import "UILabel+LineSpacing.h"//带间距

@interface PreviewTaskRequireView ()

/** 价格 */
@property (nonatomic,strong) UILabel        *priceLabel;
/** 截止时间或开始时间 */
@property (nonatomic,strong) UILabel        *timeLabel;
/** 图标 */
@property (nonatomic,strong) UIImageView    *iconImageView;
/** 名称 */
@property (nonatomic,strong) UILabel        *nameLabel;
/** 任务描述 */
@property (nonatomic,strong) UILabel        *contentLabel;
/** 图片数组背景 */
@property (nonatomic,strong) UIView         *imageBackView;
/** 开始按钮 */
@property (nonatomic,strong) UIButton       *beginButton;

/** 图片数组 */
@property (nonatomic,strong) NSMutableArray *imageMArray;



@end


@implementation PreviewTaskRequireView


- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    /** 价格 */
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.mas_left);
      make.right.mas_equalTo(self.mas_right);
      make.width.mas_equalTo(kScreenWidth);
      make.top.mas_equalTo(self.mas_top).offset(20);
    }];
    
    /** 截止时间或开始时间 */
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.mas_left);
      make.right.mas_equalTo(self.mas_right);
      make.top.mas_equalTo(_priceLabel.mas_bottom).offset(10);
    }];
    
    /** 图标 */
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.mas_equalTo(self.mas_centerX);
      make.top.mas_equalTo(_timeLabel.mas_bottom).offset(25);
      make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    /** 名称 */
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.mas_left);
      make.right.mas_equalTo(self.mas_right);
      make.top.mas_equalTo(_iconImageView.mas_bottom).offset(10);
    }];
    
    /** 任务描述 */
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.mas_left).offset(24);
      make.right.mas_equalTo(self.mas_right).offset(-24);
      make.width.mas_equalTo(kScreenWidth-48);
      make.top.mas_equalTo(_nameLabel.mas_bottom).offset(25);
    }];
    
    
    /** 图片数组背景 */
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.mas_equalTo(0);
      make.top.mas_equalTo(_contentLabel.mas_bottom).offset(30);
      make.height.mas_equalTo((kScreenWidth-50)/4);
    }];
    
    /** 开始按钮 */
    [self.beginButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.mas_equalTo(self.mas_centerX);
      make.height.mas_equalTo(45);
      make.width.mas_equalTo(150);
      make.top.mas_equalTo(_imageBackView.mas_bottom).offset(20);
      make.bottom.mas_equalTo(self.mas_bottom).offset(-30);
    }];
    
    //分割线
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







#pragma mark - load
- (NSMutableArray *)imageMArray {
  if (!_imageMArray) {
    _imageMArray = [[NSMutableArray alloc] init];
  }
  return _imageMArray;
}

/** 价格 */
- (UILabel *)priceLabel {
  if (!_priceLabel) {
    _priceLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      label.textAlignment = NSTextAlignmentCenter;
      QMLabelFontColorText(label, @"+7.50元", QMPriceColor, 18);
      label;
    });
  }
  return _priceLabel;
}





/** 截止时间或开始时间 */
-(UILabel *)timeLabel {
  if (!_timeLabel) {
    _timeLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      label.textAlignment = NSTextAlignmentCenter;
      QMLabelFontColorText(label, @"2019年01月09日  11:42:57", QMSubTextColor, 12);
      label;
    });
  }
  return _timeLabel;
}

/** 图标 */
- (UIImageView *)iconImageView {
  if (!_iconImageView) {
    _iconImageView = ({
      UIImageView *imageView = [[UIImageView alloc] init];
      QMSetImage(imageView, @"logo");
      [self addSubview: imageView];
      imageView;
    });
  }
  return _iconImageView;
}

/** 名称 */
- (UILabel *)nameLabel {
  if (!_nameLabel) {
    _nameLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      label.textAlignment = NSTextAlignmentCenter;
      QMLabelFontColorText(label, @"招商银行", QMTextColor, 14);
      label;
    });
  }
  return _nameLabel;
}

/** 任务描述 */
- (UILabel *)contentLabel {
  if (!_contentLabel) {
    _contentLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      label.numberOfLines = 0;
      QMLabelFontColorText(label, @"须知          招商银行首次安装用户;\n第一步      准备一张招商银行信用卡或储蓄卡;\n第二步      下载招商银行APP并安装;\n第三部      注册并登入招行后实名认证[截图保存];\n第四步      返回酷趣客提交截图等待审核;", QMTextColor, 13);
      [label setText:label.text lineSpacing:8];
      
      label;
    });
  }
  return _contentLabel;
}

/** 图片数组背景 */
- (UIView *)imageBackView {
  if (!_imageBackView) {
    _imageBackView =({
      UIView *view = [[UIView alloc] init];
      [self addSubview: view];
      view.backgroundColor = UIColor.whiteColor;
      view;
    });
  }
  return _imageBackView;
}


/** 开始按钮 */
- (UIButton *)beginButton {
  if (!_beginButton) {
    _beginButton = ({
      UIButton *button = [[UIButton alloc] init];
      [self addSubview:button];
      QMSetButton(button, @"开始任务", 16, nil, UIColor.whiteColor, UIControlStateNormal);
      QMViewBorderRadius(button, 4, 0, QMBlueColor);
      button.backgroundColor = QMBlueColor;
      [button addTarget:self action:@selector(beginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
      button;
    });
  }
  return _beginButton;
}

#pragma mark - event
- (void)beginButtonClick:(UIButton *)sender {
  
}


@end
