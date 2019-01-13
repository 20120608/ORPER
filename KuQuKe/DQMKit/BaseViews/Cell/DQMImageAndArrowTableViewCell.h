//
//  DQMImageAndArrowTableViewCell.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/7.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//图片带箭头
#import <UIKit/UIKit.h>
#import "DQMTeam.h"

NS_ASSUME_NONNULL_BEGIN

@interface DQMImageAndArrowTableViewCell : UITableViewCell

/** 数据模型 */
@property(nonatomic,strong) DQMTeam          *teamModel;

/** 图标 */
@property(nonatomic,strong) UIImageView      *iconImageView;
/** 标题 */
@property(nonatomic,strong) UILabel          *titleLabel;
/** 下标 */
@property(nonatomic,copy) NSIndexPath        *indexPath;
/** 箭头 */
@property(nonatomic,strong) UIImageView      *arrowImageView;

+(DQMImageAndArrowTableViewCell *)cellWithTableView:(UITableView *)tableview andIndexPath:(NSIndexPath *)indexPath andFixedCellHeight:(CGFloat)fixedCellHeight;



@end

NS_ASSUME_NONNULL_END
