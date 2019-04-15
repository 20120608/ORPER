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
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    //        NSObject * workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    //
    //        if ([workspace respondsToSelector:NSSelectorFromString(@"openApplicationWithBundleID:")])
    //        {
    //            if ([workspace performSelector:NSSelectorFromString(@"openApplicationWithBundleID:") withObject:@"com.biemaile.userapp"]) {
    //                NSLog(@"跳转成功");
    //
    ////                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    ////                    NSString *state = @"0|1"; //此处读取存好的标记0|1或其他你做的标记
    ////                    if([state isEqual:@"0"])
    ////                    {
    ////                        NSLog(@"进入后台");
    ////                    }
    ////                    else if([state isEqual:@"1"])
    ////                    {
    ////                        NSLog(@"活跃状态");
    ////                    }
    //                });
    //
    //            }
    //
    //        }
    //    });
    
    
    return YES;
}
    
    
-(void)getAppPlist {
    
    //    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    //    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    //
    //    NSArray*apps = [workspace performSelector:@selector(allApplications)];
    //
    //    //    NSArray*appsActivity = [workspace performSelector:@selector(applicationForUserActivityDomainName)];
    //
    //    NSMutableArray*appsIconArr = [NSMutableArray array];
    //
    //    NSMutableArray*appsNameArr = [NSMutableArray array];
    //
    //
    //
    //    NSLog(@"apps: %@",apps );
    //
    //    [apps enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL* stop) {
    //
    //        NSDictionary *boundIconsDictionary = [obj performSelector:@selector(boundIconsDictionary)];
    //
    //        NSString*iconPath = [NSString stringWithFormat:@"%@/%@.png", [[obj performSelector:@selector(resourcesDirectoryURL)]path], [[[boundIconsDictionary objectForKey:@"CFBundlePrimaryIcon"]objectForKey:@"CFBundleIconFiles"]lastObject]];
    //
    //        UIImage*image = [[UIImage alloc]initWithContentsOfFile:iconPath];
    //
    //        id name = [obj performSelector:@selector(localizedName)];
    //
    //        if(image)
    //
    //        {
    //
    //            [appsIconArr addObject:image];
    //
    //            [appsNameArr addObject: name];
    //        }
    //
    //        //        NSLog(@"iconPath = %@", iconPath);
    //
    //        NSLog(@"name = %@", name);
    //
    //        //        输出app的属性
    //        NSLog(@"%@",[self properties_aps:obj]);
    //
    //        NSLog(@"_____________________________________________\n");
    //        NSDictionary * appPropertices = [self properties_aps:obj];
    //
    //    }];
    //
    //
    //    //通过applicationIdentifier id。判断是否安装某个APP
    //    BOOL isInstall = [workspace performSelector:@selector(applicationIsInstalled:) withObject:@"com.tencent.xin"];
    //
    //
    //    if (isInstall) {
    //        //通过bundle id。打开一个APP
    //        [workspace performSelector:@selector(openApplicationWithBundleID:) withObject:@"com.tencent.xin"];
    //    }else{
    //        NSLog(@"您还没安装");
    //    }
    
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

