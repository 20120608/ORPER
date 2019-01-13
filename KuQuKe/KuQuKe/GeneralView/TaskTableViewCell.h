//
//  TaskTableViewCell.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/7.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//任务cell
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TaskTableViewCellStyle) {
	TaskTableViewCellStylePriceLabelRedColor,//价格为红色
	TaskTableViewCellStylePriceLabelGreenColor,//价格为绿色
	TaskTableViewCellStyleNoImage,//不带图片
	TaskTableViewCellStyleSubTag,//标签
	TaskTableViewCellStyleOnGoing,//活动进行中
	TaskTableViewCellStyleInCome,//收入
};

@interface TaskTableViewCell : UITableViewCell

/** 样式 */
@property(nonatomic,assign) TaskTableViewCellStyle          cellStyle;

/** 是否显示下划线 */
@property(nonatomic,assign) BOOL          showSeperaterLine;

+(TaskTableViewCell *)cellWithTableView:(UITableView *)tableview initWithCellStyle:(TaskTableViewCellStyle)style indexPath:(NSIndexPath *)indexPath andFixedHeightIfNeed:(CGFloat)height;



@end

NS_ASSUME_NONNULL_END
