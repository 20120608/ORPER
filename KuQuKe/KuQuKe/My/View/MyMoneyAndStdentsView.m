//
//  MyMoneyAndStdentsView.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/9.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "MyMoneyAndStdentsView.h"
#import "MyStudentsViewController.h"//我的徒弟们
#import "MyBalanceOfPaymentsViewController.h"//收支关系


@implementation MyMoneyAndStdentsView


- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		NSArray *msgArray = @[@"可用余额",@"总收益",@"学徒"];
		NSArray *imgArray = @[@"001",@"002",@"003"];
		NSMutableArray *buttonMArray = [[NSMutableArray alloc] init];
		for (int i = 0; i < 3; i++) {
			UIButton *backView = ({
				UIButton *view = [[UIButton alloc] init];
				view.userInteractionEnabled = true;
				[self addSubview: view];
				view.tag = i;
				[view addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
				view;
			});
			
			UILabel *msgLabel = ({
				UILabel *label = [[UILabel alloc] init];
				[backView addSubview:label];
				label.textAlignment = NSTextAlignmentCenter;
				label.userInteractionEnabled = NO;
				QMLabelFontColorText(label, @"说明文字", QMTextColor, 14);
				[label mas_makeConstraints:^(MASConstraintMaker *make) {
					make.left.right.mas_equalTo(0);
					make.bottom.mas_equalTo(backView.mas_bottom).offset(-10);
					make.centerX.mas_equalTo(backView.mas_centerX);
					make.height.mas_equalTo(14);
				}];
				label;
			});
			
			UILabel *numLabel = ({
				UILabel *label = [[UILabel alloc] init];
				[backView addSubview:label];
				label.textAlignment = NSTextAlignmentCenter;
				label.userInteractionEnabled = NO;
				QMLabelFontColorText(label, @"0.00", DQMMainColor, 18);
				[label mas_makeConstraints:^(MASConstraintMaker *make) {
					make.left.right.mas_equalTo(0);
					make.bottom.mas_equalTo(msgLabel.mas_top).offset(-6);
					make.centerX.mas_equalTo(backView.mas_centerX);
					make.height.mas_equalTo(18);
				}];
				label;
			});
			
			UIImageView *iconImageView = ({
				UIImageView *imageView = [[UIImageView alloc] init];
				[backView addSubview: imageView];
				imageView.userInteractionEnabled = NO;
				imageView.contentMode = UIViewContentModeScaleAspectFit;
				[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
					make.centerX.mas_equalTo(backView.mas_centerX);
					make.top.mas_equalTo(backView.mas_top).offset(10);
					make.width.mas_equalTo(imageView.mas_height);
					make.bottom.mas_equalTo(numLabel.mas_top).offset(-10);
				}];
				imageView;
			});
			QMSetImage(iconImageView, @"001");

			[RACObserve(self, userModel) subscribeNext:^(UserDetailModel *x) {
				msgLabel.text = msgArray[i];
				[iconImageView setImage:[UIImage imageNamed:imgArray[i]]];
				
				if (i == 0) {
					numLabel.text = [NSString stringWithFormat:@"%.2lf",[x.balance floatValue]];
				} else if (i == 1) {
					numLabel.text = [NSString stringWithFormat:@"%.2lf",[x.total floatValue]];
				} else {
					numLabel.text = [NSString stringWithFormat:@"%.0lf",[x.students floatValue]];
				}
				
			}];
			
			[buttonMArray addObject:backView];
		}
		
		[buttonMArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
		[buttonMArray mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(self.mas_top);
			make.bottom.mas_equalTo(self.mas_bottom);
		}];
		
	}
	return self;
}

-(void)menuClick:(UIButton *)sender {
	NSLog(@"点击了哪个%ld",sender.tag);
	NSArray *destVcArray = @[[MyBalanceOfPaymentsViewController class],[MyBalanceOfPaymentsViewController class],[MyStudentsViewController class]];
	if ([self.delegate respondsToSelector:@selector(myMoneyAndStdentsView:destVc:didSelect:)]) {
		[self.delegate myMoneyAndStdentsView:self destVc:destVcArray[sender.tag] didSelect:sender.tag];
	}
}


@end
