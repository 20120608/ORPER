//
//  MyInComeAndWithDrawModel.h
//  KuQuKe
//
//  Created by hallelujah on 2019/3/3.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyInComeAndWithDrawModel : NSObject

//收入的
/** 钱 */
@property(nonatomic,copy) NSString          *user_money;
/** 类型 */
@property(nonatomic,copy) NSString          *type;
/** 时间 */
@property(nonatomic,copy) NSString          *change_time;
/** 说明 */
@property(nonatomic,copy) NSString          *desc;
/** 图片 */
@property(nonatomic,copy) NSString          *pic;

//提现的特别字段
/** 钱 */
@property(nonatomic,copy) NSString          *money;
/** 审核状态 */
@property(nonatomic,copy) NSString          *status;
/** 添加时间 */
@property(nonatomic,copy) NSString          *add_time;



@end

NS_ASSUME_NONNULL_END
