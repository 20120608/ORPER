//
//  ChickInHeaderView.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//


//签到的顶部视图
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ChickInHeaderView;
@protocol ChickInHeaderViewDelegate <NSObject>

- (void)ChickInHeaderView:(ChickInHeaderView *)headerView didDidseleted:(NSInteger)index;

@end
@interface ChickInHeaderView : UIView

/** 代理 */
@property(nonatomic,weak) id<ChickInHeaderViewDelegate>          delegate;


@end

NS_ASSUME_NONNULL_END
