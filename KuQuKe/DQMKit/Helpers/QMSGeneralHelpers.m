//
//  QMSGeneralHelpers.m
//  QM_EnlargementHeaderTableView
//
//  Created by 漂读网 on 2018/12/20.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "QMSGeneralHelpers.h"

//闪光灯用到的
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>


@implementation QMSGeneralHelpers


//获取单利
+(instancetype)shareInstance
{
  static QMSGeneralHelpers *helpers = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    helpers = [[self alloc] init];
    
  });
  return helpers;
}


/**
 颜色转图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color {
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return theImage;
}


/**
 由NSString 转成带颜色字体大小的 NSMutableAttributedString

 @param curTitle 文字
 @param font 字体大小
 @param rangeOfFont 字体大小范围
 @param color 文字颜色
 @param rangeOfColor 文字颜色范围
 @return 带颜色字体大小的富文本 NSMutableAttributedString
 */
+ (NSMutableAttributedString *)changeStringToMutableAttributedStringTitle:(NSString *)curTitle font:(UIFont *)font rangeOfFont:(NSRange)rangeOfFont color:(UIColor *)color rangeOfColor:(NSRange)rangeOfColor
{
  NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
  [title addAttribute:NSForegroundColorAttributeName value:color range:rangeOfColor];
  [title addAttribute:NSFontAttributeName value:font range:rangeOfFont];
  return title;
}



/**
 快速由NSString 转成带颜色字体大小的 NSMutableAttributedString
 */
+ (NSMutableAttributedString *)changeStringToMutableAttributedStringTitle:(NSString *)curTitle color:(UIColor *)color {
	NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
	[title addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [curTitle length])];
	return title;
}


/**
 获取顶层视图控制器 visibleViewController
 */
+ (UIViewController *)visibleViewControllerInNavi {
  UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
  while (1) {
    if ([vc isKindOfClass:[UITabBarController class]]) {
      vc = ((UITabBarController*)vc).selectedViewController;
    }
    if ([vc isKindOfClass:[UINavigationController class]]) {
      vc = ((UINavigationController*)vc).visibleViewController;
    }
    if (vc.presentedViewController) {
      vc = vc.presentedViewController;
    }else{
      break;
    }
  }
  return vc;
}

/**
 获取栈顶视图控制器 topViewController
 */
+ (UIViewController *)topViewControllerInNavi
{
  UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
  UITabBarController *tabbar = ((UITabBarController *)keyWindow.rootViewController);
  UINavigationController *navi = tabbar.selectedViewController;
  UIViewController *vc = [navi topViewController];
  return vc;
}






/** 开或关 闪光灯 */
+ (BOOL)modifyFlashLight {
  AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  //修改前必须先锁定
  [device lockForConfiguration:nil];
  //必须判定是否有闪光灯，否则如果没有闪光灯会崩溃
  BOOL isopen = false;
  if ([device hasFlash]) {
    if (device.flashMode == AVCaptureFlashModeOff) {
      device.flashMode = AVCaptureFlashModeOn;
      device.torchMode = AVCaptureTorchModeOn;
      isopen = true;
    } else if (device.flashMode == AVCaptureFlashModeOn) {
      device.flashMode = AVCaptureFlashModeOff;
      device.torchMode = AVCaptureTorchModeOff;
      isopen = false;
    }
  }
  [device unlockForConfiguration];
  return isopen;
}








/**
 从bundle中取出图片

 @param imageName 图片名称
 @param bundleName 哪个bundle文件的文件名
 @return UIImage
 */
- (UIImage *)imageWithName:(NSString *)imageName bundle:(NSString *)bundleName {
  
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  NSURL *url = [bundle URLForResource:bundleName withExtension:@"bundle"];
  NSBundle *imageBundle = [NSBundle bundleWithURL:url];
  
  NSString *fileName = [NSString stringWithFormat:@"%@@2x", imageName];
  NSString *path = [imageBundle pathForResource:fileName ofType:@"png"];
  
  return [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  
}






/**
 将View生成Image
 
 @param view 要生成图片的视图
 @return 图片
 */
+ (UIImage *)imageWithCaputureView:(UIView *)view
{
  // 开启位图上下文
  UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
  
  // 获取上下文
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  
  // 把控件上的图层渲染到上下文,layer只能渲染
  [view.layer renderInContext:ctx];
  
  // 生成一张图片
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  
  // 关闭上下文
  UIGraphicsEndImageContext();
  
  return image;
}



/**
 把params根据ksort方法排序
 */
+ (NSString *)md5Codesign:(NSDictionary *)dict {
	NSArray *allKeyArray = [dict allKeys];
	NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1,id _Nonnull obj2) {
		NSComparisonResult resuest = [obj1 compare:obj2];
		return resuest;
	}];
	//通过排列的key值获取value
	NSMutableArray *valueArray = [NSMutableArray array];
	for(NSString *sortsing in afterSortKeyArray)
	{
		NSString *valueString = [dict objectForKey:sortsing];
		[valueArray addObject:valueString];
	}
	NSMutableString *signString = [[NSMutableString alloc] initWithFormat:@"kuquke_"];
	for(int i =0; i < afterSortKeyArray.count; i++) {
		NSString *keyValue = [NSString stringWithFormat:@"%@",valueArray[i]];
		[signString appendString:[NSString stringWithFormat:@"%@kuquke666",[keyValue md5String]]];
	}
	[signString appendString:@"_666"];
	return [signString md5String];
}

/**
 把params在get请求下转换成/a/b/c的字符串
 */
+ (NSString *)changeParamsToString:(NSDictionary *)params keySortArray:(NSArray *)ksortArray {
  
  NSMutableString *signString = [[NSMutableString alloc] init];
  for(int i =0; i < ksortArray.count; i++) {
    NSString *value = params[[NSString stringWithFormat:@"%@",ksortArray[i]]];
    [signString appendString:[NSString stringWithFormat:@"/%@",value]];
  }
  return signString;
  
}



/**
 获取当前时间戳
 */
+ (NSString *)currentTimeStr {
	NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
	NSTimeInterval time=[date timeIntervalSince1970]*10;// *1000 是精确到毫秒，不乘就是精确到秒
	NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
	return timeString;
}

/**
 传入 秒  得到  xx分钟xx秒
 */
+ (NSString *)getMMSSFromSS:(NSString *)totalTime {
	NSInteger seconds = [totalTime integerValue];
	NSString *str_minute = [NSString stringWithFormat:@"%d",seconds/60];
	NSString *str_second = [NSString stringWithFormat:@"%d",seconds%60];
	NSString *format_time = [NSString stringWithFormat:@"%@分钟%@秒",str_minute,str_second];
	return format_time;
}

/**
 在window上加一个loading视图
 
 @param alpha 背景色
 @param showHUD 是否显示HUD--loading样式
 */
+ (void)showAlertMaskViewAlpha:(CGFloat)alpha AndLoadingAlwaysHUD:(BOOL)showHUD animated:(BOOL)animated graceTime:(CGFloat)graceTime delayAfter:(CGFloat)delay completeBlock:(void(^)(UIView *maskView, MBProgressHUD *hud))completeBlock {
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    hud.mode = MBProgressHUDModeIndeterminate;
    [maskView addSubview:hud];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.backgroundColor = QMHexColor(@"ffffff");
    hud.graceTime = graceTime;
    [hud showAnimated:true];
    
    if (animated) {
      maskView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.01];
      hud.alpha = 0.01;
      [UIView animateWithDuration:0.35 animations:^{
        maskView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:alpha];
        hud.alpha = 1;
      }];
    }
    if (completeBlock) {
      completeBlock(maskView,hud);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [maskView removeFromSuperview];
    });
    
  });
}

/**  自定义投影 不能有setMasksToBounds */
//#define QMViewShadows(View, Offset, CGColor, Radius, Opacity)\
//\
//[view setBackgroundColor:UIColor.blackColor];\
//[view.layer setShadowOffset:Offset];\
//[view.layer setShadowOffset:Offset];\
//[view.layer setShadowColor:CGColor];\
//[view.layer setShadowRadius:Radius];\
//[view.layer setShadowOpacity:Opacity]







@end
