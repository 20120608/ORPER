//
//  DQMHorizontalViewScrollerView.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/7.
//  Copyright © 2019 kuquke. All rights reserved.
//

//滚动的广告视图
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//数据代理
@class DQMHorizontalViewScrollerView;

@protocol DQMHorizontalViewScrollerViewDataSource <NSObject>

- (NSArray *)horizontalViewScrollViewDataArray:(DQMHorizontalViewScrollerView *)horizontalScrollView;

@end

@interface DQMHorizontalViewScrollerView : UIView 

/** 数据源 */
@property (weak, nonatomic) id<DQMHorizontalViewScrollerViewDataSource> dataSource;

-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
