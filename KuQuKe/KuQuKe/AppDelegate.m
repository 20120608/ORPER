//
//  AppDelegate.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/6.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "YYFPSLabel.h"
#import "DQMTabBarController.h"
#include <objc/runtime.h>
#import "ShopCategoryViewController.h"

@interface AppDelegate ()

@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier taskId;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AppDelegate

    
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
    /*配置键盘*/
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;//    控制整个功能是否启用。
    manager.overrideKeyboardAppearance = YES;
    manager.shouldResignOnTouchOutside = YES;//控制点击背景是否收起键盘
    manager.enableAutoToolbar = YES;//控制是否显示键盘上的工具条。
    manager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    manager.toolbarDoneBarButtonItemText = @"完成";// 将英文done换成中文
	
		

	self.window.rootViewController = [[DQMTabBarController alloc] init];

//    self.window.rootViewController = [[ShopCategoryViewController alloc] init];

    [self.window makeKeyAndVisible];
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id1251303871"]]];
		
		
		

		
	});
    
    
    return YES;
}
	

	
//传入任务id和时间后开启定时器
- (void)startearnMoneyModelTimer:(EarnMoneyDetailModel *)earnModel {
	NSLog(@"进入定时器");
	if (!_stateTimer) {
		self.stateTimer = [TaskStatusTimer sharedTimerManager];
			[_stateTimer countDown];
	}
	[_stateTimer.modelsArray addObject:earnModel];
}
	
- (void)removeTimeTask:(NSString *)taskid {
	if (_stateTimer) {
		[_stateTimer removeTask:taskid];
	}
}
	
    
    //获取app的属性。
- (NSDictionary *)properties_aps:(id)objc
    
    {
      
      NSMutableDictionary *props = [NSMutableDictionary dictionary];
      
      unsigned int outCount, i;
      
      objc_property_t *properties = class_copyPropertyList([objc class], &outCount);
      
      for (i = 0; i<outCount; i++)
      
      {
        
        objc_property_t property = properties[i];
        
        const char* char_f =property_getName(property);
        
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        id propertyValue = [objc valueForKey:(NSString *)propertyName];
        
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
        
      }
      
      free(properties);
      
      return props;
      
    }
    
- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    return true;
}
    
    
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
    
    
- (void)applicationDidEnterBackground:(UIApplication *)application {
	self.taskId =[application beginBackgroundTaskWithExpirationHandler:^(void) {
		//当申请的后台时间用完的时候调用这个block
		//此时我们需要结束后台任务，
		[self endTask];
	}];
	// 模拟一个长时间的任务 Task
	self.timer =[NSTimer scheduledTimerWithTimeInterval:1.0f
												 target:self
											   selector:@selector(longTimeTask:)
											   userInfo:nil
												repeats:YES];
}
#pragma mark - 停止timer
-(void)endTask {
	if (_timer != nil||_timer.isValid) {
		[_timer invalidate];
		_timer = nil;
		//结束后台任务
		[[UIApplication sharedApplication] endBackgroundTask:_taskId];
		_taskId = UIBackgroundTaskInvalid;
	}
}
- (void) longTimeTask:(NSTimer *)timer {
	// 系统留给的我们的时间
	NSTimeInterval time =[[UIApplication sharedApplication] backgroundTimeRemaining];
}
    
    
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}
    
    
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
    
    
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
    
    
    @end

