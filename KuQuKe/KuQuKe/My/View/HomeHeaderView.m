//
//  HomeHeaderView.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView ()


@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = UIColor.whiteColor;
		UIView *line = ({
			UIView *view = [[UIView alloc] init];
			[self addSubview: view];
			view.backgroundColor = DQMMainColor;
			QMViewBorderRadius(view, 2, 1, DQMMainColor);
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(20);
				make.centerY.mas_equalTo(self.mas_centerY);
				make.size.mas_equalTo(CGSizeMake(2, 15));
			}];
			view;
		});
		
		UILabel *titleLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			QMLabelFontColorText(label, @"赚钱方式", QMTextColor, 15);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(line.mas_right).offset(5);
				make.centerY.mas_equalTo(self.mas_centerY);
			}];
			label;
		});
		
		UILabel *smallTitleLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			QMLabelFontColorText(label, @"", QMTextColor, 15);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(titleLabel.mas_right).offset(2);
				make.centerY.mas_equalTo(self.mas_centerY);
			}];
			label;
		});
		
		
		UILabel *subTitleLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			QMLabelFontColorText(label, @"赚钱方式", QMTextColor, 15);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(line.mas_right).offset(kScreenWidth/2);
				make.centerY.mas_equalTo(self.mas_centerY);
			}];
			label;
		});
		
		[RACObserve(self, titleString)subscribeNext:^(NSString *x) {
			titleLabel.text = x;
		}];
		[RACObserve(self, littleTitleString)subscribeNext:^(NSString *x) {
			smallTitleLabel.text = x;
		}];
		[RACObserve(self, subTitleString) subscribeNext:^(NSString *x) {
			subTitleLabel.text = x;
		}];
		
		
	}
	return self;
}

@end
