//
//  EarnMoneyDetailModel.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/2/26.
//  Copyright © 2019 kuquke. All rights reserved.
//


//注册赚钱模型
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EarnMoneyDetailModel : NSObject

/** ID */
@property(nonatomic,copy) NSString          *id;
/** 标题 */
@property(nonatomic,copy) NSString          *title;
/** 详情 */
@property(nonatomic,copy) NSString          *desc;
/** 内容 */
@property(nonatomic,copy) NSArray          *mark;
/** 图片 */
@property(nonatomic,copy) NSString          *img_url;
/** 价格 */
@property(nonatomic,copy) NSString          *price;
/** 名称 */
@property(nonatomic,copy) NSString          *appname;
/** 图标路径 */
@property(nonatomic,copy) NSString          *appicon_url;
/** 步骤 */
@property(nonatomic,copy) NSArray          *step_info;
/** 步骤图片 */
@property(nonatomic,copy) NSArray<NSString *>  *exp_img;
/** 信息 */
@property(nonatomic,copy) NSDictionary     *join_info;
/** 最多时间内要提交 */
@property(nonatomic,copy) NSString          *dealy_time;


@end

NS_ASSUME_NONNULL_END
