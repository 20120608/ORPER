//
//  ShareResultsTableViewCell.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareResultsTableViewCell : UITableViewCell

+(ShareResultsTableViewCell *)cellWithTableView:(UITableView *)tableview;

/** 我的成绩字典 */
@property(nonatomic,copy) NSDictionary          *dataDic;

@end

NS_ASSUME_NONNULL_END
