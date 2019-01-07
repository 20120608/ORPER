//
//  DQMHorizontalViewScrollerView.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/7.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMHorizontalViewScrollerView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "ADHorizontalCollectionViewCell.h"      //广告的

@interface DQMHorizontalViewScrollerView () <UICollectionViewDelegate,UICollectionViewDataSource>
{
  NSTimer * _timer;
  BOOL      _scrollRight;
  
}
/** 数组 */
@property(nonatomic,strong) NSArray          *dataArray;

/** 视图 */
@property(nonatomic,strong) UICollectionView          *contentView;

@end

@implementation DQMHorizontalViewScrollerView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
	  self.backgroundColor = UIColor.whiteColor;
    [self createUIWithFrame:frame];
    
  }
  return self;
}



#pragma mark - UI
- (void)createUIWithFrame:(CGRect)frame {
	
	UIImageView *imageView = ({
		UIImageView *imageView = [[UIImageView alloc] init];
		[self addSubview: imageView];
		QMSetImage(imageView, @"07");
		[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(8);
			make.left.mas_equalTo(10);
			make.size.mas_equalTo(CGSizeMake(24, 22));
		}];
		imageView;
	});
	
	UIView *line = [[UIView alloc] initWithFrame:CGRectMake(43, 8, 1, 22)];
	line.backgroundColor = DQMMainColor;
	[self addSubview:line];
	
  UICollectionViewLeftAlignedLayout  *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
  [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; //设置竖直滚动
  layout.minimumInteritemSpacing = 0;
  layout.minimumLineSpacing = 0;
  layout.estimatedItemSize = CGSizeMake(150, frame.size.height);
  
  self.contentView = ({
    UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(38, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
    [self addSubview: view];
    view.delegate = self;
    view.dataSource = self;
    view.backgroundColor = [UIColor whiteColor];
    [view registerClass:[ADHorizontalCollectionViewCell class] forCellWithReuseIdentifier:@"ADHorizontalCollectionViewCell"];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.right.top.mas_equalTo(0);
		make.left.mas_equalTo(44);
    }];
    view;
  });
  
}




#pragma mark - delegate
- (void)reloadData {
  //更新数据
  if ([_dataSource respondsToSelector:@selector(horizontalViewScrollViewDataArray:)]) {
    self.dataArray = [self.dataSource horizontalViewScrollViewDataArray:self];
  }
  
  //重新设置UI
  [self.contentView reloadData];
  
  //设置速度，开始滚动（默认为0.03）
  [self setMoveSpeed:0.03];
}


#pragma mark - uicollection
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
  return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  ADHorizontalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ADHorizontalCollectionViewCell" forIndexPath:indexPath];
  cell.model = self.dataArray[indexPath.row];
  return cell;
}





#pragma mark - 设置速度
-(void)setMoveSpeed:(CGFloat)speed{
  CGFloat timeInterval = speed;
  
  [_timer invalidate];
  _timer = nil;
  _timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(contentMove) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}


- (void)contentMove {
  
  if (self.contentView.contentSize.width < kScreenWidth-38) {
    return;//小于屏幕不滚动
  }
  
  if (self.contentView.contentOffset.x < 0) {
    _scrollRight = NO;
  }
  if (self.contentView.contentOffset.x > self.contentView.contentSize.width - (kScreenWidth-38) ) {
    _scrollRight = YES;
  }
  
  if (_scrollRight) {
    [UIView animateWithDuration:0.03 animations:^{
      self.contentView.contentOffset = CGPointMake(self.contentView.contentOffset.x - 1, 0);
    }];
  } else {
    [UIView animateWithDuration:0.03 animations:^{
      self.contentView.contentOffset = CGPointMake(self.contentView.contentOffset.x + 1, 0);
    }];
  }
  
}

- (void)dealloc{
  [_timer invalidate];
  _timer = nil;
}

@end
