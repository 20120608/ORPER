//
//  DQMRigthSwitchTableViewCell.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/10.
//  Copyright © 2019 kuquke. All rights reserved.
//

//右边带switch的cell
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DQMRigthSwitchTableViewCellModel;
@interface DQMRigthSwitchTableViewCell : UITableViewCell

/** 数据源 */
@property(nonatomic,strong) DQMRigthSwitchTableViewCellModel          *model;


/** 选择按钮 */
@property (nonatomic,strong) UISwitch    *rightSwitch;
/** 是否选中 */
@property(readonly,nonatomic,assign,getter=isSwitchOn) BOOL          switchOn;
/** 开关 */
@property(nonatomic,copy) void(^rightSwitchValueChangeBlock)(BOOL switvhOn);


+(DQMRigthSwitchTableViewCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath andFixedHeightIfNeed:(CGFloat)height;

@end





@interface DQMRigthSwitchTableViewCellModel : NSObject

/** 左边主标题 */
@property(nonatomic,copy) NSString          *title;
/** 是否选中  传0 1的值*/
@property(nonatomic,copy) NSString          *isOn;

+(DQMRigthSwitchTableViewCellModel *)initWithtitle:(NSString *)title andison:(NSString *)isOn;

@end


NS_ASSUME_NONNULL_END
