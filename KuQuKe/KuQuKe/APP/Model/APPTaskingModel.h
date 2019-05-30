//
//  APPTaskingModel.h
//  KuQuKe
//
//  Created by Xcoder on 2019/4/24.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APPTaskingModel : NSObject

@property (nonatomic , copy) NSString              * desc;
@property (nonatomic , assign) NSInteger              applyid;
@property (nonatomic , assign) NSInteger              type_id;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , assign) NSString              *task_id;
@property (nonatomic , copy) NSArray              * mark;
@property (nonatomic , copy) NSString              * appicon_url;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , assign) NSInteger              timer;
@property (nonatomic , assign) NSInteger              start_time;
@property (nonatomic , assign) NSInteger              add_time;
	
/** 过期时间 */
@property (nonatomic , assign) NSDate 		*beginDate;


@end

NS_ASSUME_NONNULL_END
