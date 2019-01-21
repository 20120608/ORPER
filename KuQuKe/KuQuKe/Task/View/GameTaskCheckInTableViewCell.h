//
//  GameTaskCheckInTableViewCell.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/19.
//  Copyright © 2019 kuquke. All rights reserved.
//

//游戏活动验证详情 活动详情
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameTaskCheckInTableViewCell : UITableViewCell



/** 固定高度 0则自适应 */
@property (nonatomic,assign) CGFloat     fixedCellHeight;

+(GameTaskCheckInTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight;


@end

NS_ASSUME_NONNULL_END
