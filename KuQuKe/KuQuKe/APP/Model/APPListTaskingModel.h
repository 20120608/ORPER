//
//  APPListTaskingModel.h
//  KuQuKe
//
//  Created by Xcoder on 2019/4/24.
//  Copyright © 2019 kuquke. All rights reserved.
//
//APP列表

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APPListTaskingModel : NSObject


@property (nonatomic , copy) NSString              * type_id;
@property (nonatomic , copy) NSString              * applyid;
@property (nonatomic , copy) NSString              * appicon_url;
@property (nonatomic , copy) NSArray               * mark;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * start_time;
@property (nonatomic , copy) NSString              * task_id;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * timer;
@property (nonatomic , copy) NSString              * desc;
@property (nonatomic , copy) NSString              * add_time;


@end

NS_ASSUME_NONNULL_END
