//
//  GameHomeTaskListTableViewCell.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/18.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//游戏首页列表单元格
#import <UIKit/UIKit.h>
#import "GameTaskModel.h"//游戏_任务列表模型

NS_ASSUME_NONNULL_BEGIN
@interface GameHomeTaskListTableViewCell : UITableViewCell

/** 固定高度 0则自适应 */
@property (nonatomic,assign) CGFloat     fixedCellHeight;

+(GameHomeTaskListTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight;

/** 游戏_任务列表模型 */
@property (nonatomic,strong) GameTaskModel           *gameTaskModel;


@end


NS_ASSUME_NONNULL_END
