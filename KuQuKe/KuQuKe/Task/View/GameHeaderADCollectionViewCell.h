//
//  GameHeaderADCollectionViewCell.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/22.
//  Copyright © 2019 kuquke. All rights reserved.
//

//顶部的广告cell的collectionCell
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameHeaderADCollectionViewCell : UICollectionViewCell

/** 数据 */
@property(nonatomic,strong) NSDictionary          *model;

+(GameHeaderADCollectionViewCell *)cellWithcollectionView:(UICollectionView *)collectionView forIndexPath:indexPath;

@end

NS_ASSUME_NONNULL_END
