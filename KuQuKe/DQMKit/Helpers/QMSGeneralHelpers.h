//
//  QMSGeneralHelpers.h
//  QM_EnlargementHeaderTableView
//
//  Created by 漂读网 on 2018/12/20.
//  Copyright © 2018 漂读网. All rights reserved.
//

/** 通用文件工具类 */
#import <Foundation/Foundation.h>
@interface QMSGeneralHelpers : NSObject

//获取单利
+(instancetype)shareInstance;


/**
 颜色转图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;


/**
 由NSString 转成带颜色字体大小的 NSMutableAttributedString
 
 @param curTitle 文字
 @param font 字体大小
 @param rangeOfFont 字体大小范围
 @param color 文字颜色
 @param rangeOfColor 文字颜色范围
 @return 带颜色字体大小的富文本 NSMutableAttributedString
 */
+ (NSMutableAttributedString *)changeStringToMutableAttributedStringTitle:(NSString *)curTitle font:(UIFont *)font rangeOfFont:(NSRange)rangeOfFont color:(UIColor *)color rangeOfColor:(NSRange)rangeOfColor;


/**
 快速由NSString 转成带颜色字体大小的 NSMutableAttributedString
 */
+ (NSMutableAttributedString *)changeStringToMutableAttributedStringTitle:(NSString *)curTitle color:(UIColor *)color;


/**
 打开或关闭闪光灯功能

 @return 是否打开成功
 */
+ (BOOL)modifyFlashLight;


/**
 获取栈顶视图控制器
 */
+ (UIViewController *)topViewControllerInNavi;

/**
 获取顶部活动的控制器
 */
+ (UIViewController *)visibleViewControllerInNavi;

/**
 从bundle中取出图片

 @param imageName 图片名称
 @param bundleName bundle名称
 @return 图片
 */
- (UIImage *)imageWithName:(NSString *)imageName bundle:(NSString *)bundleName;




/**
 将View生成Image

 @param view 要生成图片的视图
 @return 图片
 */
+ (UIImage *)imageWithCaputureView:(UIView *)view;


/**
 把params根据ksort方法排序
 */
+ (NSString *)md5Codesign:(NSDictionary *)dict;

/**
 把params在get请求下转换成/a/b/c的字符串
 */
+ (NSString *)changeParamsToString:(NSDictionary *)params keySortArray:(NSArray *)ksortArray;

/**
 获取当前时间戳
 */
+ (NSString *)currentTimeStr;

/**
 传入 秒  得到  xx分钟xx秒
 */
+ (NSString *)getMMSSFromSS:(NSString *)totalTime;

/**
 在window上加一个loading视图

 @param alpha 背景色
 @param showHUD 是否显示HUD--loading样式
 */
+ (void)showAlertMaskViewAlpha:(CGFloat)alpha AndLoadingAlwaysHUD:(BOOL)showHUD animated:(BOOL)animated graceTime:(CGFloat)graceTime delayAfter:(CGFloat)delay completeBlock:(void(^)(UIView *maskView, MBProgressHUD *hud))completeBlock;




@end
