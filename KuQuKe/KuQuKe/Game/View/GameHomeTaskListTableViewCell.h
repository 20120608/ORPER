//
//  GameHomeTaskListTableViewCell.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/18.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//游戏首页列表单元格
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class GameListModel;
@interface GameHomeTaskListTableViewCell : UITableViewCell

/** 模型 */
@property(nonatomic,strong) GameListModel          *gameListModel;



/** 固定高度 0则自适应 */
@property (nonatomic,assign) CGFloat     fixedCellHeight;

+(GameHomeTaskListTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight;


@end




//游戏列表模型
@interface GameListModel : NSObject

/** id */
@property(nonatomic,assign) NSInteger       gameId;
/** logo */
@property(nonatomic,copy) NSString          *logoImageUrl;
/** 背景图 */
@property(nonatomic,copy) NSString          *backIamgeUrl;
/** 价格 */
@property(nonatomic,copy) NSString          *price;
/** 名称 */
@property(nonatomic,copy) NSString          *name;



@end


NS_ASSUME_NONNULL_END
