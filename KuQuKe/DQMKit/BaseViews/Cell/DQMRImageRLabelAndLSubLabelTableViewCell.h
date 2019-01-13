//
//  DQMRImageRLabelAndLSubLabelTableViewCell.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//


//左边有图片 图片右边有个标题   左边有个子标题
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DQMRImageRLabelAndLSubLabelTableViewCellModel;
@interface DQMRImageRLabelAndLSubLabelTableViewCell : UITableViewCell

/** 数据源 */
@property(nonatomic,strong) DQMRImageRLabelAndLSubLabelTableViewCellModel *model;

+(DQMRImageRLabelAndLSubLabelTableViewCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath andFixedHeightIfNeed:(CGFloat)height showArrow:(BOOL)showArrow;

@end



@interface DQMRImageRLabelAndLSubLabelTableViewCellModel : NSObject

/** 左边主标题 */
@property(nonatomic,copy) NSString          *title;
/** subImageUrl */
@property(nonatomic,copy) NSString          *imageUrl;
/** subTitle */
@property(nonatomic,copy) NSString          *subTitle;

/** 这是要调转的目标控制器 */
@property(nonatomic,assign) Class           destVc;
/** 类型 */
@property(nonatomic,assign) NSInteger       viewType;//对应要跳转的页面的类型  会被转化成012345在转成对应的



+(DQMRImageRLabelAndLSubLabelTableViewCellModel *)initWithtitle:(NSString *)title andSubTitle:(NSString *)subTitle andImageUrl:(NSString *)imageUrl;

+(DQMRImageRLabelAndLSubLabelTableViewCellModel *)initWithtitle:(NSString *)title andSubTitle:(NSString *)subTitle andImageUrl:(NSString *)imageUrl IfNeedCreateWithdestVc:(Class)destVc andviewType:(NSInteger)viewType;


@end


NS_ASSUME_NONNULL_END
