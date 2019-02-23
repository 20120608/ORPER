//
//  HomeBigAmazingTableViewCell.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//大礼包图片
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeBigAmazingTableViewCell : UITableViewCell

+(HomeBigAmazingTableViewCell *)cellWithTableView:(UITableView *)tableview;

@property (nonatomic,copy  ) NSString                      *adimgString;/* 广告图 */


@end

NS_ASSUME_NONNULL_END
