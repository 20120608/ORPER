//
//  GameTaskDetailStepTableViewCell.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/23.
//  Copyright © 2019 kuquke. All rights reserved.
//


//游戏活动任务的步骤cell  自增高度fixedcellheight给0
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GameTaskDetailStepTableViewCellModel;
@interface GameTaskDetailStepTableViewCell : UITableViewCell

/** 固定高度 0则自适应 */
@property (nonatomic,assign) CGFloat     fixedCellHeight;


/** 模型 */
@property(nonatomic,strong) GameTaskDetailStepTableViewCellModel          *cellModel;


+(GameTaskDetailStepTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight;

@end

@interface GameTaskDetailStepTableViewCellModel : NSObject

/** 步骤数组 */
@property(nonatomic,strong) NSMutableArray          *stepMArray;

@end

NS_ASSUME_NONNULL_END
