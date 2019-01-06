
//
//  ZJCalenderConst.h
//
//
//  Created by Zj on 17/3/25.
//  Copyright © 2017年 Zj. All rights reserved.
//

#ifndef ZJCalenderConst_h
#define ZJCalenderConst_h

#define ZJScreenWidth [UIScreen mainScreen].bounds.size.width
#define ZJScreenHeight [UIScreen mainScreen].bounds.size.height
#define ZJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ZJPadding 0
#define ZJCMonthCount 120  //120个月  10年  往前一年往后九年
#define ZJCalenderBundle @"ZJCalender.bundle"

// 防止循环引用
#define WeakObj(obj) __weak typeof(obj) obj##Weak = obj

// 默认
#define ZJCalenderLargeTextSize 24
#define ZJCalenderCommonTextSize 16
#define ZJCalenderSmallTextSize 11

//ZJColor(187, 38, 14)
#define ZJCalenderThemeColor ZJColor(0, 204, 203)
#define ZJCalenderThemeTintColor ZJCalenderThemeColor
#define ZJCalenderHighlightThemeColor ZJColor(0, 179, 179)
#define ZJCalenderBackgroundColor [UIColor whiteColor]
#define ZJCalenderCommonTextColor [UIColor blackColor]
#define ZJCalenderDisabledTextColor [UIColor lightGrayColor]
#define ZJCalenderSelectedTextColor [UIColor whiteColor]
#define ZJCalenderSelectedBackgroundColor ZJCalenderThemeColor
#define ZJCalenderDeselectedBackgroundColor [UIColor whiteColor]
#define ZJCalenderMonthTitleColor [UIColor whiteColor]
#define ZJCalenderMonthTitleBackgroundColor [UIColor darkGrayColor]

#define ZJCalenderLineFullScreenSpacing 0
#define ZJCalenderLinePartScreenSpacing 0
#define ZJCalenderMonthTitleViewHeight ZJCalenderItemHeight + ZJCalenderLinePartScreenSpacing
#define ZJCalenderMonthTitleWidth (ZJScreenWidth - 70) / 7
#define ZJCalenderMonthTitleHeight 22
#define ZJCalenderWeekViewHeight 44
#define ZJCalenderItemWidth (ZJScreenWidth - 70) / 7
#define ZJCalenderItemHeight ZJCalenderItemWidth
#define ZJCalenderPartScreenSwichViewHeight 58
#define ZJCalenderPartScreenHeight ZJCalenderWeekViewHeight + ZJCalenderPartScreenSwichViewHeight + 6 * ZJCalenderItemHeight

#define ZJCalenderFirstSelectedText @"入住"
#define ZJCalenderSecondSelectedText @"离开"
#define ZJCalenderDisabledSelectedText @"无房"

#define ZJNotificationCalenderNeedsRefresh @"notificationCalenderNeedsRefresh"

#endif /* ZJCalenderConst_h */
