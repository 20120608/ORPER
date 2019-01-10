//
//  UserDetailModel.h
//  KuQuKe
//
//  Created by hallelujah on 2019/1/9.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//用户模型
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDetailModel : NSObject

/** 姓名 */
@property(nonatomic,copy) NSString          *name;
/** 昵称 */
@property(nonatomic,copy) NSString          *nickName;
/** 用户id */
@property(nonatomic,copy) NSString          *userId;
/** 头像 */
@property(nonatomic,copy) NSString       	*userface;

/** weChat */
@property(nonatomic,copy) NSString          *weChat;
/** QQ */
@property(nonatomic,copy) NSString          *QQ;
/** 电话 */
@property(nonatomic,copy) NSString          *phone;
/** 职业 */
@property(nonatomic,copy) NSString          *job;
/** 生日 */
@property(nonatomic,copy) NSString          *birthday;
/** 性别 0男1女 */
@property(nonatomic,copy) NSString          *sex;
/** 余额 */
@property(nonatomic,copy) NSString          *balance;
/** 总收益 */
@property(nonatomic,copy) NSString          *total;
/** 学徒人数 */
@property(nonatomic,copy) NSString          *students;
/** 是否允许推送  返回0拒绝  1允许 */
@property(nonatomic,copy) NSString          *allowPushNotification;


@end

NS_ASSUME_NONNULL_END
