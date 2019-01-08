//
//  QMButton.h
//  PiaoDuShuWu
//
//  Created by 漂读网 on 2018/7/26.
//  Copyright © 2018年 kesion. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, QMButtonStyle){
    QMButtonImageLeft = 0,   //图片在左
    QMButtonImageRight = 1,  //图片在右
    QMButtonImageTop = 2,    //图片在上
    QMButtonImageBottom = 3, //图片在下
};

@interface QMButton : UIButton

/**
 图片的位置，上、下、左、右，默认是图片居左
 */
@property (nonatomic, assign) QMButtonStyle buttonStyle;

/**
 文字与图片之间的间距，默认是0
 */
@property (nonatomic, assign) CGFloat padding;

/**
 创建button
 
 @param buttonType button的类型
 @param space 图片距离button的边距，如果图片比较大的，此时有效果；
 如果图片比较小，没有效果，默认居中；
 @return button
 */
+ (id)buttonWithType:(UIButtonType)buttonType withSpace:(CGFloat)space;

@end
