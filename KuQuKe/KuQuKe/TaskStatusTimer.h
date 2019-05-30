//
//  TaskStatusTimer.h
//  KuQuKe
//
//  Created by Xcoder on 2019/5/20.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EarnMoneyDetailModel.h"

@interface TaskStatusTimer : NSObject
	
@property(nonatomic,strong) NSMutableArray *modelsArray;

@property (nonatomic, assign)__block int timeout;
	
+ (id)sharedTimerManager;
	
- (void)removeTask:(NSString *)taskid;
	
- (void)countDown;
	
@end
