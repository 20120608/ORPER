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

- (void)CheckOutCollectionView:(CheckOutCollectionView *)checkView didSelectButton:(UIButton *)button;

- (void)CheckOutCollectionView:(CheckOutCollectionView *)checkView didSelectSure:(UIButton *)button DataDictionary:(NSMutableDictionary *)dataDictionary;

@end

typedef NS_ENUM(NSInteger, CheckOutThreePartType) {
  CheckOutThreePartTypeWeChat,
  CheckOutThreePartTypeAliPay,
};


@interface CheckOutCollectionView : UIView

/** 代理 */
@property(nonatomic,weak) id<CheckOutCollectionViewDelegate>          delegate;

/** 我的余额 */
@property(nonatomic,copy) NSString          *myBalane;

/** 类型 */
@property(nonatomic,assign) CheckOutThreePartType          checkOutThreePartType;

@property(nonatomic,strong) NSArray *moneyArray; /* 可选的数组 */



@end

NS_ASSUME_NONNULL_END
