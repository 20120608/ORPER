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

//@protocol GameTaskCheckInTableViewCellDatasource <NSObject>
//
//-(NSMutableArray *)cellModelArrayForGameTaskCheckInTableViewCell:(GameTaskCheckInTableViewCell *)cell andCollectionView:(UICollectionView *)collectionView;
//
//@end

@class GameTaskCheckInTableViewCellModel;
@interface GameTaskCheckInTableViewCell : UITableViewCell

/** 模型 */
@property(nonatomic,strong) GameTaskCheckInTableViewCellModel          *cellModel;

///** 数据源 */
//@property(nonatomic,weak) id<GameTaskCheckInTableViewCellDatasource>          *dataSource;

/** 视图 */
@property (nonatomic,strong) UICollectionView *collectionView;

/** 固定高度 0则自适应 */
@property (nonatomic,assign) CGFloat     fixedCellHeight;

+(GameTaskCheckInTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight;

@end


//第一个cell
@interface GameTaskCheckInTableViewCellModel : NSObject

/** 名称 */
@property (nonatomic,copy  ) NSString       *name;

/** 图片 */
@property (nonatomic,copy  ) NSString       *imageUrl;

/** 日期 */
@property (nonatomic,copy  ) NSString       *taskTime;

/** 价格 */
@property (nonatomic,copy  ) NSString       *price;

/** 记录跑马灯数据 */
@property (nonatomic,strong) NSMutableArray *historyArray;



@end

NS_ASSUME_NONNULL_END
