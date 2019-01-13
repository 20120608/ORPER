//
//  CheckOutSuccessView.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/13.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "CheckOutSuccessView.h"

@implementation CheckOutSuccessView


- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.4];
//
//		UIView *whiteBackView = ({
//			UIView *view = [[UIView alloc] init];
//			[self addSubview: view];
//			view.backgroundColor = UIColor.whiteColor;
//			QMViewBorderRadius(view, 4, 0, DQMMainColor);
//			[view mas_makeConstraints:^(MASConstraintMaker *make) {
//				make.centerX.mas_equalTo(self.mas_centerX);
//				make.centerY.mas_equalTo(self.mas_centerY).offset(-40);
//				make.size.mas_equalTo(CGSizeMake(250, 217));
//			}];
//			view;
//		});
//
//		UIImageView *iconImageView = ({
//			UIImageView *view = [[UIImageView alloc] init];
//			[whiteBackView addSubview: view];
//			[view setImage:[UIImage imageNamed:@"001"]];
//			view.contentMode = UIViewContentModeScaleAspectFit;
//			[view mas_makeConstraints:^(MASConstraintMaker *make) {
//				make.centerX.mas_equalTo(whiteBackView.mas_centerX);
//				make.top.mas_equalTo(whiteBackView.mas_top).offset(35);
//				make.size.mas_equalTo(CGSizeMake(70, 70));
//			}];
//			view;
//		});
//
//		UILabel *priceLabel = ({
//			UILabel *label = [[UILabel alloc] init];
//			[iconImageView addSubview:label];
//			QMLabelFontColorText(label, @"12.00", DQMMainColor, 18);
//			[label mas_makeConstraints:^(MASConstraintMaker *make) {
//				make.centerX.mas_equalTo(whiteBackView.mas_centerX);
//				make.top.mas_equalTo(iconImageView.mas_bottom).offset(7);
//			}];
//			label;
//		});
//
//		UILabel *msgLabel = ({
//			UILabel *label = [[UILabel alloc] init];
//			[iconImageView addSubview:label];
//			[label mas_makeConstraints:^(MASConstraintMaker *make) {
//				make.centerX.mas_equalTo(whiteBackView.mas_centerX);
//				make.top.mas_equalTo(priceLabel.mas_bottom).offset(7);
//			}];
//			label;
//		});
//		QMLabelFontColorText(msgLabel, @"可用余额", QMTextColor, 13);
//
//		UIButton *checkOutBtn = ({
//			UIButton *button = [[UIButton alloc] init];
//			[whiteBackView addSubview:button];
//			button.tag = 1;
//			[button setBackgroundColor:QMHexColor(@"#75E69D") forState:UIControlStateNormal];
//			QMSetButton(button, @"余额提现", 13, nil, UIColor.whiteColor, UIControlStateNormal);
//			QMViewBorderRadius(button, 21.5, 0, QMTextColor);
//			[button mas_makeConstraints:^(MASConstraintMaker *make) {
//				make.centerX.mas_equalTo(whiteBackView.mas_centerX);
//				make.size.mas_equalTo(CGSizeMake(200,43));
//				make.bottom.mas_equalTo(whiteBackView.mas_bottom).offset(-7);
//			}];
//			button;
//		});
//		[checkOutBtn addTarget:self action:@selector(AlertViewbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
//
//		NSArray *imgaRRAY = @[@"s01",@"s07",@"logo"];
//		NSMutableArray *buttonArray = [[NSMutableArray alloc] init];
//		for (int i = 0; i < 3; i++) {
//			UIButton *button = ({
//				UIButton *button = [[UIButton alloc] init];
//				[self addSubview:button];
//				button.tag = i + 2;
//				button.imageView.contentMode = UIViewContentModeScaleAspectFit;
//				QMViewBorderRadius(button, 26.5, 0, DQMMainColor);
//				[button setImage:[UIImage imageNamed:imgaRRAY[i]] forState:UIControlStateNormal];
//				[button addTarget:self action:@selector(AlertViewbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
//
//				button;
//			});
//			[buttonArray addObject: button];
//		}
//		[buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:53 leadSpacing:(kScreenWidth-127)/5 tailSpacing:(kScreenWidth-127)/5];
//		[buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
//			make.top.mas_equalTo(whiteBackView.mas_bottom).offset(70);
//			make.height.mas_equalTo(53);
//		}];
		
		
	}
	return self;
}


@end
