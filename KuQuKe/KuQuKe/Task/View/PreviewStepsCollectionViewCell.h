//
//  PreviewStepsCollectionViewCell.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/16.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskPreviewStepModel.h"//任务步骤模型

NS_ASSUME_NONNULL_BEGIN

@interface PreviewStepsCollectionViewCell : UICollectionViewCell

/** 任务步骤模型 */
@property(nonatomic,strong) TaskPreviewStepModel          *stepModel;

/** 图片容器 暴露出去用于l浏览图片用 */
@property(nonatomic,strong) UIImageView 				  *taskImageView;

+(PreviewStepsCollectionViewCell *)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
