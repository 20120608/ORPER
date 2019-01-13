//
//  ChickSuccessAlertView.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "ChickSuccessAlertView.h"

@implementation ChickSuccessAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		
		UIImageView *imageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[self addSubview: imageView];
			QMSetImage(imageView, @"每日签到");
			imageView.contentMode = UIViewContentModeScaleAspectFit;
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerX.mas_equalTo(self.mas_centerX);
				make.centerY.mas_equalTo(self.mas_centerY).offset(-NAVIGATION_BAR_HEIGHT/2);
				make.width.mas_equalTo(kScreenWidth);
				make.height.mas_equalTo(kScreenWidth*1.247);
			}];
			imageView;
		});
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
		[imageView addGestureRecognizer:tap];
		
		
		UIButton *closeButton = ({
			UIButton *button = [[UIButton alloc] init];
			[self addSubview:button];
			button.tag = 1;
			QMSetButton(button, nil, 12, @"icon_dqm_ring_close_white", QMRandomColor, UIControlStateNormal);
			[button mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(self.mas_right).offset(-30);
				make.top.mas_equalTo(20);
				make.size.mas_equalTo(CGSizeMake(35, 35));
			}];
			button;
		});
		[closeButton addTarget:self action:@selector(successAlertViewbuttonClick:) forControlEvents:UIControlEventTouchUpInside];

		
		
	}
	return self;
}

-(void)tapClick {
	[self successAlertViewbuttonClick:[UIButton new]];
}

- (void)successAlertViewbuttonClick:(UIButton *)sender {
	if (_ChickSuccessAlertViewBlock) {
		_ChickSuccessAlertViewBlock(sender.tag);
	}
}


@end
