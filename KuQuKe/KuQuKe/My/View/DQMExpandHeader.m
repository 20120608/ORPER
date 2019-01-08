//
//  DQMExpandHeader.m
//  QM_EnlargementHeaderTableView
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMExpandHeader.h"

@interface DQMExpandHeader ()

/** scrollerView或tableView collectionView */
@property (weak, nonatomic) UIScrollView *scrollView;

/** 可变大小的视图 */
@property (weak, nonatomic) UIView *expandView;

/** 高度 */
@property (assign, nonatomic) CGFloat expandHeight;

/** 距离顶部高度 基本为0 或者为负高度 */
@property (assign, nonatomic) CGFloat originTop;

@end

@implementation DQMExpandHeader

- (void)dealloc{
  NSLog(@"可变顶部视图移除");
  [self removeObserver];
}

+(instancetype)expandWithScrollView:(UIScrollView *)scrollView expandView:(UIView *)expandView {
  DQMExpandHeader *expandHeader = [DQMExpandHeader new];
  [expandHeader expandWithScrollView:scrollView expandView:expandView];
  return expandHeader;
}

-(void)expandWithScrollView:(UIScrollView *)scrollView expandView:(UIView *)expandView {
  _scrollView = scrollView;
  _expandView = expandView;
  _expandHeight = CGRectGetHeight(expandView.frame);
  
  [_scrollView insertSubview:expandView atIndex:0];
  
  UIEdgeInsets edgeInsets = _scrollView.contentInset;
  _originTop = edgeInsets.top;
  
  //这里会设置列表的偏移量 所以外边不用另外添加
  edgeInsets.top += _expandHeight;
  _scrollView.contentInset = edgeInsets;
  [_scrollView setContentOffset:CGPointMake(0, -edgeInsets.top)];
  
  
  //使View可以伸展效果  重要属性
  _expandView.contentMode = UIViewContentModeScaleAspectFill;
  _expandView.clipsToBounds = YES;
  [self reSizeView];
  
  [_scrollView addObserver:self forKeyPath:QMKeyPath(_scrollView, contentOffset) options:NSKeyValueObservingOptionNew context:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeObserver) name:DQMTableViewControllerDeallocNotification object:_scrollView.viewController];
}


/**
 移除键值观察和tableView释放的通知  防止内存泄露
 */
-(void)removeObserver {
  if (_scrollView) {
    [_scrollView removeObserver:self forKeyPath:QMKeyPath(_scrollView, contentOffset)];//移除键值观察
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DQMTableViewControllerDeallocNotification object:_scrollView.viewController];//移除来自_scrollView.viewController的通知 (因为可能多个所以要指定移除某个)
    _scrollView = nil; //移除后置为空
  }
  _expandView = nil;
}



/** 监听来自对应的某个顶部的通知 需要对应的scrollview和keypath对应的上 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
  if ([keyPath isEqualToString:QMKeyPath(_scrollView, contentOffset)] && object == _scrollView) {
    [self scrollViewDidScroll:_scrollView];
  }
}

/**
 *  监听scrollViewDidScroll方法
 *
 *  @param scrollView 当前滚动的滚动视图
 */
- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
  CGFloat offsetY = scrollView.contentOffset.y;
  if(offsetY < (_expandHeight + _originTop) * -1) {
    CGRect currentFrame = _expandView.frame;
    currentFrame.origin.y = offsetY + _originTop;
    currentFrame.size.height = -1*(offsetY + _originTop);
    _expandView.frame = currentFrame;
  }
}

//重置_expandView位置
- (void)reSizeView{
  [_expandView setFrame:CGRectMake(0, -1*(_expandHeight), CGRectGetWidth(_expandView.frame), _expandHeight)];
}

//外界通过.header获取到e可变大的顶部
- (UIView *)headerView
{
  return _expandView;
}


@end
