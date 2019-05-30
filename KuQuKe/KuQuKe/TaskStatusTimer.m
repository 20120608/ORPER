//
//  TaskStatusTimer.m
//  KuQuKe
//
//  Created by Xcoder on 2019/5/20.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "TaskStatusTimer.h"

@interface TaskStatusTimer()
	
	
@property (nonatomic , assign) BOOL 		showRemove;

@end

@implementation TaskStatusTimer
	
	
+ (id)sharedTimerManager {
	
	static TaskStatusTimer *manager = nil;
	
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		
		if (manager == nil) {
			
			manager = [[self alloc] init];
		}
		
	});
	
	return manager;
	
}
	
	
-(NSMutableArray *)modelsArray {
	if (!_modelsArray) {
		self.modelsArray = [[NSMutableArray alloc] init];
	}
	return _modelsArray;
}
	
	
	
- (void)countDown {
	
	
	if (_timeout == 0) {
		
		dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		
		dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
		
		dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
		
		QMWeak(self);
		dispatch_source_set_event_handler(_timer, ^{
			NSLog(@"有进入计时器");
			
			if (_timeout < -100) {
				dispatch_suspend(_timer);
			}
			
			NSDate *datenow = [NSDate date];
			__block NSString *msg = @"任务已超时,请重新领取任务！";
			
			[weakself.modelsArray enumerateObjectsUsingBlock:^(EarnMoneyDetailModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
				
				if ([obj.beginDate isEqualToDate:[obj.beginDate earlierDate:datenow]]) {

					[weakself removeTask:obj.id];
					if (!_showRemove) {
						_showRemove = true;
						
						dispatch_sync_on_main_queue(^{
							[JXTAlertController qm_showAlertWithTitle:@"任务失败"
															  message:msg
													appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
														alertMaker.
														addActionCancelTitle(@"我知道了");
														
														
													} actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
														_showRemove = false;
													}];
						});
						
						//通知后台移除任务
						NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
						[params setValue:obj.id forKey:@"id"];
						[params setValue:obj.applyid forKey:@"applyid"];
						[params setValue:@"6" forKey:@"nowstatus"];
						
						[KuQuKeNetWorkManager POST_addExclusiveTaskOk:params View:nil success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
							
						} unknown:nil failure:nil];
					}
					
				}
				
			}];
			
		});
		
		dispatch_resume(_timer);
	}
}
	
	
- (void)removeTask:(NSString *)taskid {
	[_modelsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		
		if ([((EarnMoneyDetailModel *)obj).id isEqualToString:taskid] ) {
			[_modelsArray removeObjectAtIndex:idx];
			return;
		}
	}];
}
	
	@end




