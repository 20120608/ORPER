//
//  RACMVVMListTableViewCell.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/25.
//  Copyright © 2019 kuquke. All rights reserved.
//

//MVVM的cell
#import <UIKit/UIKit.h>
#import "RACMVVMListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RACMVVMListTableViewCell : UITableViewCell

@property (nonatomic, strong) RACMVVMListModel *cellModel;


/** 固定高度 0则自适应 */
@property (nonatomic,assign) CGFloat     fixedCellHeight;

+(RACMVVMListTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight;



@end

NS_ASSUME_NONNULL_END
