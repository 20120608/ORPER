//
//  CheckOutCollectionView.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/13.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//选择金额
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CheckOutCollectionView;
@protocol CheckOutCollectionViewDelegate <NSObject>

-(void)CheckOutCollectionView:(CheckOutCollectionView *)checkView didSelectIndex:(NSInteger)index;

@end
@interface CheckOutCollectionView : UIView

/** 代理 */
@property(nonatomic,weak) id<CheckOutCollectionViewDelegate>          delegate;

/** 我的余额 */
@property(nonatomic,copy) NSString          *myBalane;

@end

NS_ASSUME_NONNULL_END
