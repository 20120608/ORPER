//
//  DQMModalRequestBaseViewController.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/18.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMModalTextViewController.h"

@class DQMModalRequestBaseViewController;
@protocol DQMModalRequestBaseViewControllerDelegate <NSObject>

@optional
#pragma mark - 网络监听
/*
 NotReachable = 0,
 ReachableViaWiFi = 2,
 ReachableViaWWAN = 1,
 ReachableVia2G = 3,
 ReachableVia3G = 4,
 ReachableVia4G = 5,
 */
- (void)networkStatus:(NetworkStatus)networkStatus inViewController:(DQMModalRequestBaseViewController *)inViewController;

@end



@interface DQMModalRequestBaseViewController : DQMModalTextViewController<DQMModalRequestBaseViewControllerDelegate>
#pragma mark - 加载框

- (void)showLoading;

- (void)dismissLoading;

@end

