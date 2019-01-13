//
//  CheckOutCollectionView.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/13.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "CheckOutCollectionView.h"

@interface CheckOutCollectionView ()

/** 按钮数组 */
@property(nonatomic,strong) NSMutableArray          *buttonArray;

@end

@implementation CheckOutCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = QMBackColor;
		self.buttonArray = [[NSMutableArray alloc] init];

		UIView *whiteBack = ({
			UIView *view = [[UIView alloc] init];
			[self addSubview: view];
			view.backgroundColor = UIColor.whiteColor;
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.right.mas_equalTo(0);
				make.top.mas_equalTo(0);
				make.height.mas_equalTo(240);
			}];
			view;
		});
		
		UIImageView *icon1 = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[self addSubview: imageView];
			QMSetImage(imageView, @"支付宝");
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.size.mas_equalTo(CGSizeMake(25, 25));
				make.left.mas_equalTo(20);
				make.top.mas_equalTo(17.5);
			}];
			imageView;
		});
		UITextField *alipayTF = ({
			UITextField *textField = [[UITextField alloc] init];
			[self addSubview:textField];
			textField.placeholder = @"请输入支付宝账号";
			textField.textColor = QMTextColor;
			textField.font = KQMFont(16);
			[textField mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(icon1.mas_right).offset(20);
				make.centerY.mas_equalTo(icon1.mas_centerY);
				make.top.mas_equalTo(10);
				make.right.mas_equalTo(-10);
			}];
			textField;
		});
		UIView *line1View = ({
			UIView *view = [[UIView alloc] init];
			[alipayTF addSubview: view];
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.right.bottom.mas_equalTo(0);
				make.height.mas_equalTo(1);
			}];
			view;
		});
		line1View.backgroundColor = QMBackColor;

		
		UIImageView *icon2 = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[self addSubview: imageView];
			QMSetImage(imageView, @"用户");
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.size.mas_equalTo(CGSizeMake(25, 25));
				make.left.mas_equalTo(20);
				make.top.mas_equalTo(77.5);
			}];
			imageView;
		});
		UITextField *alpayCodeTF = ({
			UITextField *textField = [[UITextField alloc] init];
			[self addSubview:textField];
			textField.placeholder = @"请输入支付宝认证的姓名";
			textField.textColor = QMTextColor;
			textField.font = KQMFont(16);
			[textField mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(icon2.mas_right).offset(20);
				make.centerY.mas_equalTo(icon2.mas_centerY);
				make.top.mas_equalTo(67.5);
				make.right.mas_equalTo(-10);
			}];
			textField;
		});
		UIView *line2View = ({
			UIView *view = [[UIView alloc] init];
			[alpayCodeTF addSubview: view];
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.right.bottom.mas_equalTo(0);
				make.height.mas_equalTo(1);
			}];
			view;
		});
		line2View.backgroundColor = QMBackColor;
		
		
		
		
		self.buttonArray = [[NSMutableArray alloc] init];
		NSMutableArray *fitstMArray = [[NSMutableArray alloc] init];
		for (int i = 0; i < 3; i++) {
			UIButton *button = ({
				UIButton *button = [[UIButton alloc] init];
				[self addSubview:button];
				button.tag = i;
				button;
			});
			[fitstMArray addObject:button];
			[_buttonArray addObject:button];
		}
		[fitstMArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
		[fitstMArray mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(120);
			make.height.mas_equalTo(40);
		}];
		
		NSMutableArray *secondArray = [[NSMutableArray alloc] init];
		for (int i = 0; i < 3; i++) {
			UIButton *button = ({
				UIButton *button = [[UIButton alloc] init];
				[self addSubview:button];
				button.tag = i;
				button;
			});
			[secondArray addObject:button];
			[_buttonArray addObject:button];
		}
		[secondArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
		[secondArray mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(180);
			make.height.mas_equalTo(40);
		}];
		
		
		NSArray *titleArray = @[@"20元",@"50元",@"100元",@"200元",@"500元",@"1000元"];
		[_buttonArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
			obj.layer.borderColor = QMBackColor.CGColor;
			obj.layer.borderWidth = 1;
			[obj setBackgroundColor:DQMMainColor forState:UIControlStateSelected];
			[obj setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
			QMSetButton(obj, titleArray[idx], 14, nil, QMTextColor, UIControlStateNormal);
			QMSetButton(obj, titleArray[idx], 14, nil, UIColor.whiteColor, UIControlStateSelected);
		}];
		
		
		UILabel *needLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			QMLabelFontColorText(label, @"需要20.00元", QMTextColor, 16);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(20);
				make.top.mas_equalTo(whiteBack.mas_bottom).offset(20);
			}];
			label;
		});
		
		UIButton *checkOutButton = ({
			UIButton *button = [[UIButton alloc] init];
			[self addSubview:button];
			[button setBackgroundColor:DQMMainColor forState:UIControlStateNormal];
			QMSetButton(button, @"余额不足", 18, nil, UIColor.whiteColor, UIControlStateNormal);
			QMViewBorderRadius(button, 6, 0, DQMMainColor);
			[button addTarget:self action:@selector(checkOutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
			[button mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(20);
				make.right.mas_equalTo(-20);
				make.top.mas_equalTo(needLabel.mas_bottom).offset(10);
				make.height.mas_equalTo(44);
			}];
			button;
		});
		
		UILabel *msgLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			label.numberOfLines = 2;
			QMLabelFontColorText(label, @"提现到支付宝,审核后立即到账;\n所产生的手续费由学生赚官方承担。", QMSubTextColor, 14);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(20);
				make.right.mas_equalTo(-20);
				make.top.mas_equalTo(checkOutButton.mas_bottom).offset(20);
			}];
			label;
		});
		
	}
	return self;
}

- (void)checkOutButtonClick:(UIButton *)sender {
	
}

@end
