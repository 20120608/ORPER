//
//  DQMInputTextFieldTableViewCell.h
//  KuQuKe
//
//  Created by hallelujah on 2019/3/3.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DQMInputTextFieldTableViewCell : UITableViewCell

+(DQMInputTextFieldTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight;

/** 标题 */
@property (nonatomic,strong) UILabel     *titleLabel;
/** 标题 */
@property (nonatomic,strong) UITextField *contentTextField;

@end

NS_ASSUME_NONNULL_END
