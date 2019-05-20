//
//  ShareToMyFriendImageTableViewCell.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "ShareToMyFriendImageTableViewCell.h"
#import "QMButton.h"

@interface ShareToMyFriendImageTableViewCell ()

/** 按钮数组 */
@property(nonatomic,strong) NSMutableArray          *buttonArray;

@end

@implementation ShareToMyFriendImageTableViewCell

+(ShareToMyFriendImageTableViewCell *)cellWithTableView:(UITableView *)tableview
{
	static NSString *identifier = @"ShareToMyFriendImageTableViewCell";
	ShareToMyFriendImageTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil)
	{
		cell = [[ShareToMyFriendImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self)
	{
		self.buttonArray = [[NSMutableArray alloc] init];
		NSMutableArray *fitstMArray = [[NSMutableArray alloc] init];
		for (int i = 0; i < 3; i++) {
			QMButton *button = ({
				QMButton *button = [QMButton buttonWithType:UIButtonTypeCustom withSpace:5];
				button.padding = 5;
				button.buttonStyle = QMButtonImageTop;
				[self.contentView addSubview:button];
				button.tag = i;
				QMSetButton(button, @"menu", 12, @"ic_reading_trails_yellow", QMTextColor, UIControlStateNormal);
				QMSetButton(button, @"menu", 12, @"ic_reading_trails_yellow", QMTextColor, UIControlStateSelected);
				[button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
				button;
			});
			[fitstMArray addObject:button];
			[_buttonArray addObject:button];
		}
		[fitstMArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:20 tailSpacing:20];
		[fitstMArray mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(0);
			make.height.mas_equalTo(90);
		}];
		
//		NSMutableArray *secondArray = [[NSMutableArray alloc] init];
//		for (int i = 0; i < 3; i++) {
//			QMButton *button = ({
//				QMButton *button = [QMButton buttonWithType:UIButtonTypeCustom withSpace:5];
//				button.padding = 5;
//				button.buttonStyle = QMButtonImageTop;
//				[self.contentView addSubview:button];
//				button.tag = i+3;
//				QMSetButton(button, @"menu", 12, @"ic_reading_trails_yellow", QMTextColor, UIControlStateNormal);
//				QMSetButton(button, @"menu", 12, @"ic_reading_trails_yellow", QMTextColor, UIControlStateSelected);
//				[button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//				button;
//			});
//			[secondArray addObject:button];
//			[_buttonArray addObject:button];
//		}
//		[secondArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:20 tailSpacing:20];
//		[secondArray mas_makeConstraints:^(MASConstraintMaker *make) {
//			make.top.mas_equalTo(90);
//			make.height.mas_equalTo(90);
//		}];
		
		UILabel *codeLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			self.codeLabel = label;
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerX.mas_equalTo(self.mas_centerX);
				make.top.mas_equalTo(self.contentView.mas_top).offset(100);
				make.height.mas_equalTo(34);
			}];
			label;
		});
		QMLabelFontColorText(codeLabel, @"我的邀请码:______", QMTextColor, 16);

		
		NSArray *imageArray = @[@"s01",@"s03",@"s06"];
		NSArray *titleArray = @[@"微信",@"QQ",@"二维码"];
//		NSArray *imageArray = @[@"s01",@"s02",@"s03",@"s04",@"s05",@"s06"];
//		NSArray *titleArray = @[@"微信",@"朋友圈",@"QQ",@"QQ空间",@"新浪微博",@"二维码"];
		[_buttonArray enumerateObjectsUsingBlock:^(QMButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
			QMSetButton(obj, titleArray[idx], 14, imageArray[idx], QMTextColor, UIControlStateNormal);
		}];
		
		UIButton *copyButton = ({
			UIButton *button = [[UIButton alloc] init];
			[self.contentView addSubview:button];
			button.tag = 7;
			QMSetButton(button, @"复制邀请码", 20, nil, UIColor.whiteColor, UIControlStateNormal);
			QMViewBorderRadius(button, 15, 0, QMTextColor);
			[button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
			[button mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerX.mas_equalTo(self.mas_centerX);
				make.top.mas_equalTo(self.contentView.mas_top).offset(134);
				make.height.mas_equalTo(30);
				make.width.mas_equalTo(156);
				make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
			}];
			button;
		});
		[copyButton setBackgroundColor:DQMMainColor forState:UIControlStateNormal];

		
	}
	return self;
}


-(void)buttonClick:(QMButton *)sender {
  if (_copyCodeSuccess) {
    _copyCodeSuccess();
  }
}

@end
