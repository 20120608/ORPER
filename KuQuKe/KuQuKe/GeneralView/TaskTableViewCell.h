//
//  TaskTableViewCell.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/7.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//任务cell
#import <UIKit/UIKit.h>

#import "HomeTaskRecommendModel.h"//首页_推荐赚钱模型
#import "APPTaskModel.h"//应用_任务列表模型
#import "MyInComeAndWithDrawModel.h"//收支模型

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


/** 首页_推荐赚钱模型 */
@property (nonatomic,strong) HomeTaskRecommendModel   *homeTaskModel;
/** 应用_任务列表模型 */
@property (nonatomic,strong) APPTaskModel             *appTaskModel;
/** 个人中心_任务列表模型 */
@property (nonatomic,strong) MyInComeAndWithDrawModel *myInDrowModel;



@end

NS_ASSUME_NONNULL_END
