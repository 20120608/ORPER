//
//  ShareToMyFriendImageTableViewCell.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareToMyFriendImageTableViewCell : UITableViewCell

+(ShareToMyFriendImageTableViewCell *)cellWithTableView:(UITableView *)tableview;

/** 复制邀请码 */
@property(nonatomic,copy) void(^copyCodeSuccess)(void);

@end

NS_ASSUME_NONNULL_END
