//
//  DQMRightImageViewTableViewCell.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/10.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//左边标题+右边圆形图片和箭头
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DQMRightImageViewTableViewCellModel;
@interface DQMRightImageViewTableViewCell : UITableViewCell

/** 数据源 */
@property(nonatomic,strong) DQMRightImageViewTableViewCellModel          *model;

+(DQMRightImageViewTableViewCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath andFixedHeightIfNeed:(CGFloat)height showArrow:(BOOL)showArrow;

@end



@interface DQMRightImageViewTableViewCellModel : NSObject

/** 左边主标题 */
@property(nonatomic,copy) NSString          *title;
/** subImageUrl */
@property(nonatomic,copy) NSString          *subImageUrl;
/** subImage */
@property(nonatomic,strong) UIImage          *subImage;
/** subTitle */
@property(nonatomic,copy) NSString          *subTitle;

/** 这是要调转的目标控制器 */
@property(nonatomic,assign) Class           destVc;
/** 类型 */
@property(nonatomic,assign) NSInteger       viewType;//对应要跳转的页面的类型  会被转化成012345在转成对应的



+(DQMRightImageViewTableViewCellModel *)initWithtitle:(NSString *)title andSubTitle:(NSString *)subTitle andsubImageUrl:(NSString *)subImageUrl;

+(DQMRightImageViewTableViewCellModel *)initWithtitle:(NSString *)title andSubTitle:(NSString *)subTitle andsubImageUrl:(NSString *)subImageUrl IfNeedCreateWithdestVc:(Class)destVc andviewType:(NSInteger)viewType;


@end


NS_ASSUME_NONNULL_END
