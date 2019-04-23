//
//  TaskingAlertView.m
//  KuQuKe
//
//  Created by Xcoder on 2019/4/22.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "TaskingAlertView.h"

@interface TaskingAlertView ()

/** 白色背景 */
@property(nonatomic,strong) UIView          *whiteBackView;
/** 控件容器 */
@property(nonatomic,strong) UIView          *backView;
@end

@implementation TaskingAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.4];
		
		self.backView = ({
			UIView *view = [[UIView alloc] init];
			[self addSubview: view];
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
			}];
			view;
		});
		
		UIView *whiteBackView = ({
			UIView *view = [[UIView alloc] init];
			[_backView addSubview: view];
			view.backgroundColor = UIColor.whiteColor;
			QMViewBorderRadius(view, 4, 0, DQMMainColor);
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerX.mas_equalTo(self.mas_centerX);
				make.centerY.mas_equalTo(self.mas_centerY).offset(-40);
				make.size.mas_equalTo(CGSizeMake(250, 187));//217去掉按钮剩下187
			}];
			view;
		});
		self.whiteBackView = whiteBackView;
		
		UIButton *closeButton = ({
			UIButton *button = [[UIButton alloc] init];
			[self addSubview:button];
			button.tag = 0;
			QMSetButton(button, nil, 12, @"icon_dqm_ring_close_white", QMRandomColor, UIControlStateNormal);
			[button mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(self.centerX);
				make.top.mas_equalTo(self.centerY);
				make.size.mas_equalTo(CGSizeMake(50, 50));
			}];
			button;
		});
		[[closeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
			[self removeFromSuperview];
		}];
		
		
		
	}
	return self;
}


- (void)showAnimation {
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	animation.fromValue = [NSNumber numberWithFloat:0.01f];
	animation.toValue = [NSNumber numberWithFloat:1.0f];
	animation.duration = 0.35f;
	animation.fillMode = kCAFillModeForwards;
	animation.removedOnCompletion = NO;
	[self.backView.layer addAnimation:animation forKey:@"scaleAnimation"];
	CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
	animation2.fromValue = [NSNumber numberWithFloat:0.01f];
	animation2.toValue = [NSNumber numberWithFloat:1.0f];
	animation2.duration = 0.35f;
	animation2.fillMode = kCAFillModeForwards;
	animation2.removedOnCompletion = NO;
	[self.backView.layer addAnimation:animation2 forKey:@"opacityAnimation"];
}


@end
