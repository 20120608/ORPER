//
//  APPTaskModel.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/2/20.
//  Copyright © 2019 kuquke. All rights reserved.
//

//应用任务模型
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APPTaskModel : NSObject

/** 添加时间 */
@property(nonatomic,copy) NSString          *add_time;
/** 介绍 */
@property(nonatomic,copy) NSString          *desc;
/** 图片 */
@property(nonatomic,copy) NSString          *img_url;
/** mark */
@property(nonatomic,copy) NSString          *mark;
/** 价格 */
@property(nonatomic,copy) NSString          *price;
/** 标题 */
@property(nonatomic,copy) NSString          *title;


@end

NS_ASSUME_NONNULL_END
