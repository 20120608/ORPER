//
//  TaskProgressFailTableViewCell.h
//  KuQuKe
//
//  Created by Xcoder on 2019/4/15.
//  Copyright © 2019 kuquke. All rights reserved.
//
//失败的任务内容

#import <UIKit/UIKit.h>
#import "TaskProgressModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskProgressFailTableViewCell : UITableViewCell

/** 下标 */
@property (nonatomic,copy  ) NSIndexPath *indexPath;
/** 固定高度 0则自适应 */
@property (nonatomic,assign) CGFloat     fixedCellHeight;
/** 用来撑开高度的View */
@property(nonatomic,strong) UIView       *backView;

/** 模型 */
@property(nonatomic,strong) TaskProgressModel *model;

+(TaskProgressFailTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight;

@end

NS_ASSUME_NONNULL_END
