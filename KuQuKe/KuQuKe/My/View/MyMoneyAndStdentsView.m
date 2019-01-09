//
//  MyMoneyAndStdentsView.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/9.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "MyMoneyAndStdentsView.h"

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
				QMLabelFontColorText(label, @"说明文字", QMTextColor, 12);
				[label mas_makeConstraints:^(MASConstraintMaker *make) {
					make.left.right.mas_equalTo(0);
					make.bottom.mas_equalTo(backView.mas_bottom).offset(-10);
					make.centerX.mas_equalTo(backView.mas_centerX);
					make.height.mas_equalTo(12);
				}];
				label;
			});
			
			UILabel *numLabel = ({
				UILabel *label = [[UILabel alloc] init];
				[backView addSubview:label];
				label.textAlignment = NSTextAlignmentCenter;
				label.userInteractionEnabled = NO;
				QMLabelFontColorText(label, @"0.00", DQMMainColor, 15);
				[label mas_makeConstraints:^(MASConstraintMaker *make) {
					make.left.right.mas_equalTo(0);
					make.bottom.mas_equalTo(msgLabel.mas_top).offset(-6);
					make.centerX.mas_equalTo(backView.mas_centerX);
					make.height.mas_equalTo(15);
				}];
				label;
			});
			
			UIImageView *iconImageView = ({
				UIImageView *imageView = [[UIImageView alloc] init];
				[backView addSubview: imageView];
				imageView.userInteractionEnabled = NO;
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
}


@end
