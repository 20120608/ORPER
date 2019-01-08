//
//  DQMExpandHeader.h
//  QM_EnlargementHeaderTableView
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//

//一个可以缩小和放大的headerView
#import <Foundation/Foundation.h>

@interface DQMExpandHeader : NSObject


#pragma mark - 类方法
/**
 *  生成一个DQMExpandHeader实例
 *
 *  @param scrollView scrollerView类
 *  @param expandView 可以伸展的背景View
 *
 *  @return DQMExpandHeader 对象
 */
+ (instancetype)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView;


#pragma mark - 成员方法

/**
 生成一个DQMExpandHeader对象
 *  @param scrollView scrollerView类
 *  @param expandView 可以伸展的背景View
 */
- (void)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView;


/** 头部视图 */
@property (weak, nonatomic, readonly) UIView *headerView;


@end
