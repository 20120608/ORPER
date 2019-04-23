//
//  MessageCenterListModel.h
//  KuQuKe
//
//  Created by hallelujah on 2019/3/3.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageCenterListModel : NSObject

/** id */
@property(nonatomic,copy) NSString          *id;
/** 用户id */
@property(nonatomic,copy) NSString          *uid;

/** 用户id */
@property(nonatomic,copy) NSString          *title;
/** 消息 */
@property(nonatomic,copy) NSString          *content;

/** 消息 */
@property(nonatomic,copy) NSString          *msg;
/** 时间*/
@property(nonatomic,copy) NSString          *add_time;
/**  图标 */
@property(nonatomic,copy) NSString          *pic;
@end

NS_ASSUME_NONNULL_END
