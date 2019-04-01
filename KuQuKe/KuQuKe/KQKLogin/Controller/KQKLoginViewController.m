//
//  KQKLoginViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/3/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "KQKLoginViewController.h"
#import "LoginView.h"//登录界面

@interface KQKLoginViewController () <LoginViewDelegate>

@end

@implementation KQKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self createUI];
	
}

- (void)LoginView:(LoginView *)loginView loginButtonClick:(UIButton *)button {
	
}

- (void)LoginView:(LoginView *)loginView passWordChangeButtonClick:(UIButton *)button {
	
}

- (void)LoginView:(LoginView *)loginView registerButtonClick:(UIButton *)button {
	
}





#pragma mark - UI
- (void)createUI {
	LoginView *loginView = ({
		LoginView *view = [[LoginView alloc] initWithFrame:CGRectZero];
		[self.view addSubview: view];
		view.delegate = self;
		view.currentVC = self;
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.mas_equalTo(self.view);
		}];
		view;
	});
	loginView.backgroundColor = QMBackColor;
}


#pragma mark - dqm_navibar
- (UIColor *)DQMModalnavUIBaseViewControllerNaviBackgroundColor:(DQMModalNavUIBaseViewController *)navUIBaseViewController {
	return UIColor.clearColor;
}

- (BOOL)DQMModalnavUIBaseViewControllerIsNeedNavBar:(DQMModalNavUIBaseViewController *)navUIBaseViewController {
	return false;
}


@end
