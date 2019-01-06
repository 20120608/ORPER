//
//  HomeViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/6.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "HomeViewController.h"
#import "CheckInViewController.h"//签到


@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		CheckInViewController *vc = [[CheckInViewController alloc] initWithTitle:@"每日签到"];
		[self.navigationController pushViewController:vc animated:true];
	});

}



#pragma mark - dqm_navibar
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(DQMNavUIBaseViewController *)navUIBaseViewController {
	return false;
}



@end
