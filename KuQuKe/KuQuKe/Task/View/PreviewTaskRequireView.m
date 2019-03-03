//
//  PreviewTaskRequireView.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "PreviewTaskRequireView.h"
#import "UILabel+LineSpacing.h"//带间距
#import "PreViewTaskTotalStepView.h"//步骤数统计
#import "PreviewStepsCollectionViewCell.h"//图片步骤的样式
#import "YBImageBrowser.h"//图片浏览器

@interface PreviewTaskRequireView () <UICollectionViewDelegate,UICollectionViewDataSource,YBImageBrowserDataSource, YBImageBrowserDelegate>
/** 视图 */
@property (nonatomic,strong) UICollectionView *collectionView;
/** 任务模型数组 */
@property (nonatomic,strong) NSMutableArray   *taskPreviewStepModelMArray;

/** 价格 */
@property (nonatomic,strong) UILabel          *priceLabel;
/** 截止时间或开始时间 */
@property (nonatomic,strong) UILabel          *timeLabel;
/** 图标 */
@property (nonatomic,strong) UIImageView      *iconImageView;
/** 名称 */
@property (nonatomic,strong) UILabel          *nameLabel;
/** 任务描述 */
@property (nonatomic,strong) UILabel          *contentLabel;
/** 图片数组背景 */
@property (nonatomic,strong) UIView           *imageBackView;
/** 开始按钮 */
@property (nonatomic,strong) UIButton         *beginButton;

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
      make.top.mas_equalTo(self.mas_top).offset(40);
    }];
    
    /** 截止时间或开始时间 */
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.mas_equalTo(self.mas_centerX);
      make.height.mas_equalTo(30);
      make.top.mas_equalTo(_priceLabel.mas_bottom).offset(15);
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
      make.height.mas_equalTo((kScreenWidth-54)/4);
    }];
    
    //图片滚动
    [self createUIWithFrame:frame];
    
    
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
    
    
    //订阅模型
    @weakify(self)
    [[RACObserve(self, earnModel) skip:1] subscribeNext:^(EarnMoneyDetailModel*  _Nullable x) {
      @strongify(self)
      
      /** 价格 */
      NSString *price = [NSString stringWithFormat:@"+%@元",x.price];
      self.priceLabel.attributedText = [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:price font:KQMFont(40) rangeOfFont:NSMakeRange(0, price.length-1) color:QMPriceColor rangeOfColor:NSMakeRange(0, price.length-1)] ;
      
      /** 截止时间或开始时间 */
      self.timeLabel.text = [NSString stringWithFormat:@"  有效时间:%@分钟  ",x.dealy_time];
      
      /** 图标 */
      [self.iconImageView qm_setImageUrlString:x.appicon_url];
      
      /** 名称 */
      self.nameLabel.text = x.appname;
      
      /** 任务描述 */
      __block NSString *stempString;
      [x.step_info enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        stempString = [NSString stringWithFormat:@"%@\n\n%@",[stempString length]==0 ? @"":stempString, obj];
      }];
      NSString *content = [NSString stringWithFormat:@"须知:    %@%@",x.desc,stempString];
      QMLabelFontColorText(self.contentLabel, content, QMTextColor, 13);
      
      
      //是否可以点击开始按钮  join_status  5是未参与 0是已经开始任务了 1是已经提交任务审核了 2是审核通过 3是审核不通过 6是过时失效了
      [self.beginButton setEnabled:false];
      [self.beginButton setBackgroundColor:QMBackColor forState:UIControlStateNormal];

      switch ([x.join_info[@"join_status"] intValue]) {
          case 5:
          [self.beginButton setEnabled:true];
          [self.beginButton setBackgroundColor:QMBlueColor forState:UIControlStateNormal];
          break;
          case 0:
          [self.beginButton setTitle:@"任务进行中" forState:UIControlStateNormal];
          break;
          case 1:
          [self.beginButton setTitle:@"审核中" forState:UIControlStateNormal];
          break;
          case 2:
          [self.beginButton setTitle:@"审核已通过" forState:UIControlStateNormal];
          break;
          case 3:
          [self.beginButton setTitle:@"审核不通过" forState:UIControlStateNormal];
          [self.beginButton setBackgroundColor:QMPriceColor forState:UIControlStateNormal];

          break;
          case 6:
          [self.beginButton setTitle:@"任务超时失效" forState:UIControlStateNormal];
          [self.beginButton setBackgroundColor:QMPriceColor forState:UIControlStateNormal];
          break;
        default:
          break;
      }
    }];
    
  }
  return self;
}


#pragma mark - UI
- (void)createUIWithFrame:(CGRect)frame {
  
  CGFloat kStepWidth = (kScreenWidth-54)/4;
  
  PreViewTaskTotalStepView *stepView =  ({
    PreViewTaskTotalStepView *stepView = [[PreViewTaskTotalStepView alloc] init];
    [_imageBackView addSubview: stepView];
    [stepView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(12);
      make.top.mas_equalTo(0);
      make.size.mas_equalTo(CGSizeMake(kStepWidth, kStepWidth));
    }];
    stepView;
  });
  
  UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
  [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; //设置竖直滚动
  layout.minimumInteritemSpacing = 10;
  layout.minimumLineSpacing = 10;
  layout.itemSize = CGSizeMake(kStepWidth, kStepWidth);

  self.collectionView = ({
    UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(12+kStepWidth+5, 0, kScreenWidth-17-kStepWidth, kStepWidth) collectionViewLayout:layout];
    [_imageBackView addSubview: view];
    view.delegate = self;
    view.dataSource = self;
    view.backgroundColor = [UIColor whiteColor];
	  view.showsHorizontalScrollIndicator = false;
    [view registerClass:[PreviewStepsCollectionViewCell class] forCellWithReuseIdentifier:@"PreviewStepsCollectionViewCell"];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.mas_equalTo(UIEdgeInsetsMake(0, kStepWidth+12+5, 0, 0));
    }];
    view;
  });
  
  
  //步骤数 图片数组 订阅
  QMWeak(self);
  [[RACObserve(self,imagesUrlStringArray) skip:1] subscribeNext:^(NSMutableArray<NSString *> *x) {
    stepView.totalNum = [x count];
    for (NSString *imageUrl in x) {
      TaskPreviewStepModel *model = [[TaskPreviewStepModel alloc] init];
      model.imageUrl = imageUrl;
      [weakself.taskPreviewStepModelMArray addObject:model];
    }
    [weakself.collectionView reloadData];
  }];
  
}


#pragma mark - UICollection dataSource
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.imagesUrlStringArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  PreviewStepsCollectionViewCell *cell = [PreviewStepsCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
  cell.stepModel = self.taskPreviewStepModelMArray[indexPath.row];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	// 设置数据源代理并展示
	YBImageBrowser *browser = [YBImageBrowser new];
	browser.dataSource = self;
	browser.currentIndex = indexPath.item;
	[browser show];
	
	
}

// 实现 <YBImageBrowserDataSource> 协议方法配置数据源
- (NSUInteger)yb_numberOfCellForImageBrowserView:(YBImageBrowserView *)imageBrowserView {
	return [self.imagesUrlStringArray count];
}
- (id<YBImageBrowserCellDataProtocol>)yb_imageBrowserView:(YBImageBrowserView *)imageBrowserView dataForCellAtIndex:(NSUInteger)index {
	YBImageBrowseCellData *data = [YBImageBrowseCellData new];
	data.url = [NSURL URLWithString:_imagesUrlStringArray[index]];
	data.sourceObject = [_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
	return data;
}


#pragma mark - load
- (NSMutableArray *)imagesUrlStringArray {
  if (!_imagesUrlStringArray) {
    _imagesUrlStringArray = [[NSMutableArray alloc] init];
  }
  return _imagesUrlStringArray;
}

-(NSMutableArray *)taskPreviewStepModelMArray {
  if (!_taskPreviewStepModelMArray) {
    _taskPreviewStepModelMArray = [[NSMutableArray alloc] init];
  }
  return _taskPreviewStepModelMArray;
}

/** 价格 */
- (UILabel *)priceLabel {
  if (!_priceLabel) {
    _priceLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      label.textAlignment = NSTextAlignmentCenter;
      QMLabelFontColorText(label, @"+7.50元", QMPriceColor, 20);
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
      QMViewBorderRadius(label, 8, 0, DQMMainColor);
      label.backgroundColor = QMBackColor;
      QMLabelFontColorText(label, @"2019年01月09日  11:42:57", QMSubTextColor, 15);
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
      QMLabelFontColorText(label, @"招商银行", QMTextColor, 16);
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
	if ([self.delegate respondsToSelector:@selector(beginButtonClickPreviewTaskRequireView:)]) {
		[self.delegate beginButtonClickPreviewTaskRequireView:self];
	}
}


@end
