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

@interface AppDelegate ()

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
    [self.window makeKeyAndVisible];
    
//    [self.window addSubview:[[YYFPSLabel alloc] initWithFrame:CGRectMake(61, STATUS_BAR_HEIGHT, 0, 0)]];
	
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
	
	return true;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		NSLog(@"当前显示的APP %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]);
	});
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
