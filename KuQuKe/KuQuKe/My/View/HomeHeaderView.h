//
//  HomeHeaderView.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeaderView : UIView

/** 组头 */
@property(nonatomic,copy) NSString          *titleString;

/** 子标题 */
@property(nonatomic,copy) NSString          *subTitleString;

@end

NS_ASSUME_NONNULL_END
