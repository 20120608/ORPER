//
//  CustomerServiceOfQQViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//


#import "CustomerServiceOfQQViewController.h"

@interface CustomerServiceOfQQViewController ()

@end

@implementation CustomerServiceOfQQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self createUI];
	
	
}

#pragma mark - 创建UI
- (void)createUI {
	UIView *backView = ({
		UIView *view = [[UIView alloc] init];
		[self.view addSubview: view];
		view.backgroundColor = UIColor.whiteColor;
		QMViewBorderRadius(view, 4, 0, DQMMainColor);
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(15);
			make.right.mas_equalTo(-15);
			make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT+15);
		}];
		view;
	});
	
	UILabel *msgLabel = ({
		UILabel *label = [[UILabel alloc] init];
		[backView addSubview:label];
		label.numberOfLines = 2;
		label.textAlignment = NSTextAlignmentCenter;
		QMLabelFontColorText(label, @"用微信扫码关注公众号:\n酷趣客-手机赚钱", QMTextColor, 15);
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.bottom.mas_equalTo(backView.mas_bottom).offset(-10);
			make.width.mas_equalTo(200);
			make.height.mas_equalTo(40);
			make.centerX.mas_equalTo(backView.mas_centerX);
		}];
		label;
	});
	
	UIImageView *QRCodeImageView = ({
		UIImageView *imageView = [[UIImageView alloc] init];
		[backView addSubview: imageView];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		QMViewBorderRadius(imageView, 0, 0, DQMMainColor);
		[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(30);
			make.size.mas_equalTo(CGSizeMake(150, 150));
			make.centerX.mas_equalTo(backView.mas_centerX);
			make.bottom.mas_equalTo(msgLabel.mas_top).offset(-20);
		}];
		imageView;
	});
	
	[QRCodeImageView qm_setImageUrlString:@"https://gss0.bdstatic.com/94o3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=fa9140accd95d143ce7bec711299e967/2934349b033b5bb571dc8c5133d3d539b600bc12.jpg"];
	
}


#pragma mark - dqm_navibar
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar {
	return true;
}

/** 导航条左边的按钮 */
- (UIImage *)dqmNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(DQMNavigationBar *)navigationBar {
	[leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];
	return [UIImage imageNamed:@"NavgationBar_white_back"];
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
	[self.navigationController popViewControllerAnimated:true];
}

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
	return DQMMainColor;
}

@end
