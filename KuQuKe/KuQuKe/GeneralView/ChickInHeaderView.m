//
//  ChickInHeaderView.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "ChickInHeaderView.h"

@implementation ChickInHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		[self setGradientBackgroundWithColors:@[QMHexColor(@"88ec9b"), QMHexColor(@"5bbd7d")] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
		
		UIButton *checkInButton = ({
			UIButton *button = [[UIButton alloc] init];
			[self addSubview:button];
			[button setBackgroundImage:[UIImage imageNamed:@"qd01"] forState:UIControlStateNormal];
			[button addTarget:self action:@selector(checkInButtonClick:) forControlEvents:UIControlEventTouchUpInside];
			[button mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerX.mas_equalTo(self.mas_centerX);
				make.centerY.mas_equalTo(self.mas_centerY);
				make.height.mas_equalTo(self.mas_height).multipliedBy(0.6);
				make.width.mas_equalTo(button.mas_height);
			}];
			button;
		});
		
		UILabel *checkInLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[checkInButton addSubview:label];
			label.numberOfLines = 0;
			label.font = [UIFont boldSystemFontOfSize:20];
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerY.mas_equalTo(checkInButton.mas_centerY);
				make.centerX.mas_equalTo(checkInButton.mas_centerX);
			}];
			label;
		});
		QMLabelFontColorText(checkInLabel, @"点击\n签到", DQMMainColor, 20);
		
		
//		UILabel *titleLabel = ({
//			UILabel *label = [[UILabel alloc] init];
//			[self addSubview:label];
//			[label mas_makeConstraints:^(MASConstraintMaker *make) {
//				make.centerX.mas_equalTo(self.mas_centerX);
//				make.bottom.mas_equalTo(checkInButton.mas_top).offset(-10);
//			}];
//			label;
//		});
//		QMLabelFontColorText(titleLabel, @"每日签到", UIColor.whiteColor, 20);
		
		
		UIView *shadowView = ({
			UIView *view = [[UIView alloc] init];
			[self addSubview: view];
			view.layer.shadowOffset =CGSizeMake(1,3);
			view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
			view.layer.shadowRadius = 6;
			view.layer.shadowOpacity = 2;
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.top.mas_equalTo(self.mas_bottom).offset(20);
				make.left.mas_equalTo((kScreenWidth-ZJCalenderWidth)/2);
				make.right.mas_equalTo(-(kScreenWidth-ZJCalenderWidth)/2);
				make.height.mas_equalTo(ZJCalenderPartScreenHeight);
			}];
			view;
		});
		shadowView.backgroundColor = UIColor.whiteColor;
		
	}
	return self;
}

-(void)checkInButtonClick:(UIButton *)sender {
	if ([self.delegate respondsToSelector:@selector(ChickInHeaderView:didDidseleted:)]) {
		[self.delegate ChickInHeaderView:self didDidseleted:sender.tag];
	}
}


@end
