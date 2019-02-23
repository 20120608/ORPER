//
//  HomeMyTaskTableViewCell.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/13.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//我的专属任务
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeMyTaskTableViewCell : UITableViewCell



/** 内容 */
@property(nonatomic,copy) NSMutableAttributedString          *contentMAString;

+(HomeMyTaskTableViewCell *)cellWithTableView:(UITableView *)tableview;


@end


NS_ASSUME_NONNULL_END
