//
//  HXCollectionViewCell.h
//  KuQuKe
//
//  Created by Xcoder on 2019/5/31.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXModel.h"
#import "HXPhotoPicker.h"

NS_ASSUME_NONNULL_BEGIN
@class HXPhotoView;
@interface HXCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) HXModel *model;
/**  照片视图  */
@property (nonatomic, strong) HXPhotoView *photoView;
/**  示例视图  */
@property (nonatomic, strong) UIImageView *exImageView;

@property(nonatomic,strong) NSString          *imgUrl;

//选中的图片
@property(nonatomic,strong) HXPhotoModel * __nullable selectHXPhotoModel;


/** 图片容器 暴露出去用于l浏览图片用 */
@property(nonatomic,strong) UIImageView 	  *taskImageView;

+(HXCollectionViewCell *)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

-(void)settingExImg:(NSString *)img;


@end

NS_ASSUME_NONNULL_END
