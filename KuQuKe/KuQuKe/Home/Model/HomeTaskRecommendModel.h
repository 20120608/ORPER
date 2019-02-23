//
//  HomeTaskRecommendModel.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/2/20.
//  Copyright © 2019 kuquke. All rights reserved.
//

//首页_推荐赚钱模型
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTaskRecommendModel : NSObject

@property(nonatomic,copy) NSString *desc; /* 说明 */
@property(nonatomic,assign) NSInteger id; /* 任务ID */
@property(nonatomic,copy) NSString *img_url; /* 任务图标 */
@property(nonatomic,copy) NSString *price; /* 完成任务可收入价格 */
@property(nonatomic,copy) NSString *title; /* 标题 */

@end

NS_ASSUME_NONNULL_END
