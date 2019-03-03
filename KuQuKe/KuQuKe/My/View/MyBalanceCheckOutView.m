//
//  MyBalanceCheckOutView.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/13.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "MyBalanceCheckOutView.h"

@interface MyBalanceCheckOutView ()

/** 白色背景 */
@property(nonatomic,strong) UIView          *whiteBackView;
/** 控件容器 */
@property(nonatomic,strong) UIView          *backView;
@end

@implementation MyBalanceCheckOutView

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
    
		UIButton *closeButton = ({
			UIButton *button = [[UIButton alloc] init];
			[self addSubview:button];
			button.tag = 0;
			QMSetButton(button, nil, 12, @"icon_dqm_ring_close_white", QMRandomColor, UIControlStateNormal);
			[button mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(self.mas_right).offset(-30);
				make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT+30);
				make.size.mas_equalTo(CGSizeMake(30, 30));
			}];
			button;
		});
		[closeButton addTarget:self action:@selector(AlertViewbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
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
		
		UIImageView *iconImageView = ({
			UIImageView *view = [[UIImageView alloc] init];
			[whiteBackView addSubview: view];
			[view setImage:[UIImage imageNamed:@"001"]];
			view.contentMode = UIViewContentModeScaleAspectFit;
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerX.mas_equalTo(whiteBackView.mas_centerX);
				make.top.mas_equalTo(whiteBackView.mas_top).offset(35);
				make.size.mas_equalTo(CGSizeMake(70, 70));
			}];
			view;
		});
		
		UILabel *priceLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[iconImageView addSubview:label];
			QMLabelFontColorText(label, @"12.00", DQMMainColor, 18);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerX.mas_equalTo(whiteBackView.mas_centerX);
				make.top.mas_equalTo(iconImageView.mas_bottom).offset(7);
			}];
			label;
		});
		
		UILabel *msgLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[iconImageView addSubview:label];
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerX.mas_equalTo(whiteBackView.mas_centerX);
				make.top.mas_equalTo(priceLabel.mas_bottom).offset(7);
        make.bottom.mas_equalTo(whiteBackView.mas_bottom).offset(-7);
			}];
			label;
		});
		QMLabelFontColorText(msgLabel, @"可用余额", QMTextColor, 13);

		NSArray *imgaRRAY = @[@"s01",@"s07"];
		NSMutableArray *buttonArray = [[NSMutableArray alloc] init];
		for (int i = 0; i < [imgaRRAY count]; i++) {
			UIButton *button = ({
				UIButton *button = [[UIButton alloc] init];
				[_backView addSubview:button];
				button.tag = i + 2;
				button.imageView.contentMode = UIViewContentModeScaleAspectFit;
				QMViewBorderRadius(button, 38, 0, DQMMainColor);
				[button setImage:[UIImage imageNamed:imgaRRAY[i]] forState:UIControlStateNormal];
				[button addTarget:self action:@selector(AlertViewbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
				
				button;
			});
			[buttonArray addObject: button];
		}
		[buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:76 leadSpacing:(kScreenWidth-152)/3 tailSpacing:(kScreenWidth-152)/3];
		[buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(whiteBackView.mas_bottom).offset(70);
			make.height.mas_equalTo(76);
		}];
		
		[[RACObserve(self, canUseMoney) skip:1] subscribeNext:^(NSString *  _Nullable x) {
			priceLabel.text = [NSString stringWithFormat:@"¥%.2lf元", [x floatValue]];
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


- (void)AlertViewbuttonClick:(UIButton *)sender {
	if ([self.delegete respondsToSelector:@selector(MyBalanceCheckOutView:didSelected:)]) {
		[self.delegete MyBalanceCheckOutView:self didSelected:sender.tag];
		[self removeFromSuperview];
	}
}

@end
