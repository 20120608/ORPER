//
//  DQMImageTitleSubTitleAndArrowTableViewCell.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//


//左边图标主标题副标题   右边箭头
#import <UIKit/UIKit.h>
#import "MessageCenterListModel.h"//模型

NS_ASSUME_NONNULL_BEGIN

@interface DQMImageTitleSubTitleAndArrowTableViewCell : UITableViewCell


+(DQMImageTitleSubTitleAndArrowTableViewCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath andFixedHeightIfNeed:(CGFloat)height showArrow:(BOOL)showArrow;

/** 视图模型 */
@property(nonatomic,strong) MessageCenterListModel          *msgModel;

@end

NS_ASSUME_NONNULL_END
