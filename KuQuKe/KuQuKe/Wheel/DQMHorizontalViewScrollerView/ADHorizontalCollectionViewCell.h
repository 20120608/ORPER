//
//  ADHorizontalCollectionViewCell.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/7.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADHorizontalCollectionViewCell : UICollectionViewCell

/** 数据 */
@property(nonatomic,strong) NSDictionary          *model;

+(ADHorizontalCollectionViewCell *)cellWithcollectionView:(UICollectionView *)collectionView forIndexPath:indexPath;


@end

NS_ASSUME_NONNULL_END
