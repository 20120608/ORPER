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
/** 用户id */
@property(nonatomic,copy) NSString          *userId;
/** 头像 */
@property(nonatomic,copy) NSString       	*userface;
/** 余额 */
@property(nonatomic,copy) NSString          *balance;
/** 总收益 */
@property(nonatomic,copy) NSString          *total;
/** 学徒 */
@property(nonatomic,copy) NSString          *students;

@end

NS_ASSUME_NONNULL_END
