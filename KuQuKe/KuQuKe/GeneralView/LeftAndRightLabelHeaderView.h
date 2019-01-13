//
//  LeftAndRightLabelHeaderView.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LeftAndRightLabelHeaderViewModel;

@interface LeftAndRightLabelHeaderView : UIView

/** 数据 */
@property(nonatomic,strong) LeftAndRightLabelHeaderViewModel          *headerModel;

@end

@interface LeftAndRightLabelHeaderViewModel : NSObject

/** 左标题 */
@property(nonatomic,copy) NSString          *leftString;
/** 右标题 */
@property(nonatomic,copy) NSString          *rightString;

+(LeftAndRightLabelHeaderViewModel *)initWithleftString:(NSString *)leftString rightString:(NSString *)rightString;

@end

NS_ASSUME_NONNULL_END
