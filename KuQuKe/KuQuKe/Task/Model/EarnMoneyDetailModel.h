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
/** nowtype = 3 专属任务nowtype = 2 正在进行中nowtype = 1 新参加的 */
@property(nonatomic,copy) NSString          *type_id;
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
/** 例子图片 */
@property(nonatomic,copy) NSArray<NSString *>  *exp_img;
/** 步骤图片 */
@property(nonatomic,copy) NSArray<NSString *>  *step_img;
/** 步骤图片 */
@property(nonatomic,copy) NSString 			 *ios_url;
/** 详情 */
@property(nonatomic,copy) NSString          *timer;

/* 任务ID */
@property(nonatomic,copy) NSString *bundleID;

/* 包装包大小 */
@property(nonatomic,copy) NSString *apk_size;

/* 参加的ID */
@property(nonatomic,copy) NSString *applyid;

/* 参加的ID */
@property(nonatomic,copy) NSString *jump_url;



/** 信息
 "join_info" =     {
 applyid = 3;
 "join_status" = 0;
 "start_time" = 1551181440;
 };
  join_status  5是未参与 0是已经开始任务了 1是已经提交任务审核了 2是审核通过 3是审核不通过 6是过时失效了
 */
@property(nonatomic,copy) NSDictionary     *join_info;

/** 最多时间内要提交 */
@property(nonatomic,copy) NSString          *dealy_time;


- (NSString *)msgForJoinStatus;


@end

NS_ASSUME_NONNULL_END
