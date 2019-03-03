//
//  StudentModel.h
//  KuQuKe
//
//  Created by hallelujah on 2019/3/3.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//学生模型
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StudentModel : NSObject

/** 徒弟ID */
@property(nonatomic,copy) NSString          *user_id;
/** 头像 */
@property(nonatomic,copy) NSString          *head_pic;
/** 昵称 */
@property(nonatomic,copy) NSString          *nickname;
/** 钱 */
@property(nonatomic,copy) NSString          *sum_money;

@end

NS_ASSUME_NONNULL_END
