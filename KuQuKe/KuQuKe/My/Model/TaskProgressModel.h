//
//  TaskProgressModel.h
//  KuQuKe
//
//  Created by Xcoder on 2019/4/15.
//  Copyright © 2019 kuquke. All rights reserved.
//
//任务进度模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskProgressModel : NSObject

@property(nonatomic,copy) NSString *id;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *appicon_url;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *status;
@property(nonatomic,copy) NSString *audit_msg;
@property(nonatomic,copy) NSString *finish_time;
@property(nonatomic,copy) NSString *audit_time;
	
@end

NS_ASSUME_NONNULL_END
