//
//  DQMModalNavUIBaseViewController.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/18.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DQMModalNavUIBaseViewController;
@protocol DQMModalNavUIBaseViewControllerDataSource <NSObject>

@optional

- (BOOL)DQMModalnavUIBaseViewControllerIsNeedNavBar:(DQMModalNavUIBaseViewController *)navUIBaseViewController;

- (UIColor *)DQMModalnavUIBaseViewControllerNaviBackgroundColor:(DQMModalNavUIBaseViewController *)navUIBaseViewController;

- (NSMutableAttributedString *)DQMModalnavUIBaseViewControllerNaviTitle:(DQMModalNavUIBaseViewController *)navUIBaseViewController;

@end

@protocol DQMModalNavUIBaseViewControllerDelegate <NSObject>

@optional
/** 左边的按钮的点击 */
-(void)DQMModalleftButtonEvent:(UIButton *)sender navigationBar:(DQMModalNavUIBaseViewController *)navUIBaseViewController;
/** 右边的按钮的点击 */
-(void)DQMModalrightButtonEvent:(UIButton *)sender navigationBar:(DQMModalNavUIBaseViewController *)navUIBaseViewController;

@end

@interface DQMModalNavUIBaseViewController : UIViewController <DQMModalNavUIBaseViewControllerDataSource,DQMModalNavUIBaseViewControllerDelegate>

/** 数据源  */
@property(nonatomic,weak) id<DQMModalNavUIBaseViewControllerDataSource>        dataSource;

/** 代理 */
@property(nonatomic,weak) id<DQMModalNavUIBaseViewControllerDelegate>          delegate;



- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle;

@end

NS_ASSUME_NONNULL_END
