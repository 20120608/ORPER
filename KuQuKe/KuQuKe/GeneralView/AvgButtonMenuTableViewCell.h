//
//  AvgButtonMenuTableViewCell.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/8.
//  Copyright © 2019 kuquke. All rights reserved.
//

//等分的按钮 宽度可变高度固定
#import <UIKit/UIKit.h>
#import "QMButton.h"//图文共存的按钮
NS_ASSUME_NONNULL_BEGIN

@class AvgButtonMenuTableViewCell;
@protocol AvgButtonMenuTableViewCellDelegate <NSObject>

- (void)avgButtonMenuTableViewCell:(AvgButtonMenuTableViewCell *)cell didSelectRowAtIndex:(NSInteger)index superIndexPath:(NSIndexPath *)indexPath;

@end

@interface AvgButtonMenuTableViewCell : UITableViewCell

/** 代理 */
@property(nonatomic,weak) id<AvgButtonMenuTableViewCellDelegate>  delegate;

/**
 创建一个N按钮的cell 固定高度84
 */
+(AvgButtonMenuTableViewCell *)cellWithTableView:(UITableView *)tableView initWithButtonsNum:(NSInteger)num  indexPath:(NSIndexPath *)indexPath andFixedHeightIfNeed:(CGFloat)height WithDatasArray:(NSArray *)datasArray withFixedSpacing:(CGFloat)fixedSpcing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;

/** 字体大小 */
@property(nonatomic,copy) UIFont          *buttonTitleFont;


@end

NS_ASSUME_NONNULL_END
