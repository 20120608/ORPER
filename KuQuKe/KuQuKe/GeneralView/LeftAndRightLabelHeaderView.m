//
//  LeftAndRightLabelHeaderView.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//
#import "LeftAndRightLabelHeaderView.h"

@interface LeftAndRightLabelHeaderView ()

/** 左标题 */
@property(nonatomic,strong) UILabel          *leftLabel;
/** 右标题 */
@property(nonatomic,strong) UILabel          *rightLabel;

@end

@implementation LeftAndRightLabelHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		self.backgroundColor = QMBackColor;
		
		/** 左标题 */
		self.leftLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			QMLabelFontColorText(label, @"左边标题", QMTextColor, 14);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(20);
				make.top.bottom.mas_equalTo(0);
			}];
			label;
		});
		
		
		/** 右标题 */
		self.rightLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			QMLabelFontColorText(label, @"右边标题", QMTextColor, 14);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(-20);
				make.top.bottom.mas_equalTo(0);
			}];
			label;
		});
		
		//订阅
		QMWeak(self);
		[RACObserve(self, headerModel) subscribeNext:^(LeftAndRightLabelHeaderViewModel *x) {
			weakself.leftLabel.text = x.leftString;
			weakself.rightLabel.text = x.rightString;
		}];
		
	}
	return self;
}





@end



@implementation LeftAndRightLabelHeaderViewModel

+(LeftAndRightLabelHeaderViewModel *)initWithleftString:(NSString *)leftString rightString:(NSString *)rightString {
	LeftAndRightLabelHeaderViewModel *model = [[LeftAndRightLabelHeaderViewModel alloc] init];
	model.leftString = leftString;
	model.rightString = rightString;
	return model;
}

@end
