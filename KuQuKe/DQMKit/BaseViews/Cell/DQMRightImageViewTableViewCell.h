//
//  DQMRightImageViewTableViewCell.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/10.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//左边标题+右边圆形图片和箭头
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DQMRightImageViewTableViewCell : UITableViewCell

+(DQMRightImageViewTableViewCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath andFixedHeightIfNeed:(CGFloat)height showArrow:(BOOL)showArrow;

@end

NS_ASSUME_NONNULL_END
