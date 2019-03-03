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

/** 用户信息字典 */
@property(nonatomic,strong) NSMutableDictionary          *userMessageDictionary;

@end

@implementation CheckOutCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = QMBackColor;
		self.buttonArray = [[NSMutableArray alloc] init];
		self.userMessageDictionary = [NSMutableDictionary new];
		
		UIView *whiteBack = ({
			UIView *view = [[UIView alloc] init];
			[self addSubview: view];
			view.backgroundColor = UIColor.whiteColor;
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.right.mas_equalTo(0);
				make.top.mas_equalTo(0);
				make.height.mas_equalTo(360);
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
			textField.returnKeyType = UIReturnKeyDone;
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
			textField.returnKeyType = UIReturnKeyDone;
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
		
		[[alpayCodeTF rac_textSignal] subscribeNext:^(NSString *x) {
			[self.userMessageDictionary setValue:x forKey:@"real_name"];
		}];
		[[alipayTF rac_textSignal] subscribeNext:^(NSString *x) {
			[self.userMessageDictionary setValue:x forKey:@"account"];
		}];
		
		UILabel *needLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			NSString *price = [NSString stringWithFormat:@"需要%.2lf元", [@"0" floatValue]];
			QMLabelFontColorText(label, price, QMTextColor, 16);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(20);
				make.top.mas_equalTo(whiteBack.mas_bottom).offset(20);
			}];
			label;
		});
		
		
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
		[fitstMArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:((kScreenWidth-61)/3) leadSpacing:20 tailSpacing:20];
		[fitstMArray mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(120);
			make.height.mas_equalTo(40);
		}];
		
		NSMutableArray *secondArray = [[NSMutableArray alloc] init];
		for (int i = 0; i < 3; i++) {
			UIButton *button = ({
				UIButton *button = [[UIButton alloc] init];
				[self addSubview:button];
				button.tag = i+3;
				button;
			});
			[secondArray addObject:button];
			[_buttonArray addObject:button];
		}
		[secondArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:((kScreenWidth-61)/3) leadSpacing:20 tailSpacing:20];
		[secondArray mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(180);
			make.height.mas_equalTo(40);
		}];
		
		NSMutableArray *threeArray = [[NSMutableArray alloc] init];
		for (int i = 0; i < 3; i++) {
			UIButton *button = ({
				UIButton *button = [[UIButton alloc] init];
				[self addSubview:button];
				button.tag = i+6;
				button;
			});
			[threeArray addObject:button];
			[_buttonArray addObject:button];
		}
		[threeArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:((kScreenWidth-61)/3) leadSpacing:20 tailSpacing:20];
		[threeArray mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(240);
			make.height.mas_equalTo(40);
		}];
		
		NSMutableArray *fourArray = [[NSMutableArray alloc] init];
		for (int i = 0; i < 3; i++) {
			UIButton *button = ({
				UIButton *button = [[UIButton alloc] init];
				[self addSubview:button];
				button.tag = i+9;
				button;
			});
			[fourArray addObject:button];
			[_buttonArray addObject:button];
		}
		[fourArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:((kScreenWidth-61)/3) leadSpacing:20 tailSpacing:20];
		[fourArray mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(300);
			make.height.mas_equalTo(40);
		}];
		
		
		[_buttonArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
			obj.layer.borderColor = QMBackColor.CGColor;
			obj.layer.borderWidth = 1;
			[obj setBackgroundColor:DQMMainColor forState:UIControlStateSelected];
			[obj setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
			NSString *price = [NSString stringWithFormat:@"%@元",@"0.00"];
			QMSetButton(obj, price, 14, nil, QMTextColor, UIControlStateNormal);
			QMSetButton(obj, price, 14, nil, UIColor.whiteColor, UIControlStateSelected);
			[obj setSelected:idx == 0 ? true : false];//默认选中第一个
			[obj addTarget:self action:@selector(changeSelectedWithButton:) forControlEvents:UIControlEventTouchUpInside];
			
			//订阅每个按钮的点击事件
			[[obj rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
				NSString *price = [ NSString stringWithFormat:@"需要%.2lf元",[x.titleLabel.text floatValue]];
				QMLabelFontColorText(needLabel, price, QMTextColor, 16);
			}];
		}];
		
		
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
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(20);
				make.right.mas_equalTo(-20);
				make.top.mas_equalTo(checkOutButton.mas_bottom).offset(20);
			}];
			label;
		});
		QMLabelFontColorText(msgLabel, @"审核后立即到账;\n所产生的手续费由官方承担。", QMSubTextColor, 14);
		
		[[RACObserve(self, checkOutThreePartType) skip:1] subscribeNext:^(id  _Nullable x) {
			CheckOutThreePartType type = [x intValue];
			QMSetImage(icon1, type == CheckOutThreePartTypeWeChat ? @"s01" : @"支付宝");
			alipayTF.placeholder = type == CheckOutThreePartTypeWeChat ? @"请输入微信账号" : @"请输入支付宝账号";
			alpayCodeTF.placeholder = type == CheckOutThreePartTypeWeChat ? @"请输入微信认证的姓名" : @"请输入支付宝认证的姓名";
			NSString *string = [NSString stringWithFormat:@"提现到%@,审核后立即到账;\n所产生的手续费由官方承担。", type == CheckOutThreePartTypeWeChat ? @"微信" : @"支付宝"];
			QMLabelFontColorText(msgLabel, string, QMSubTextColor, 14);
		}];
		
		
		QMWeak(self);
		[[RACObserve(self, moneyArray) skip:1] subscribeNext:^(NSArray *  _Nullable x) {
			NSString *price = [NSString stringWithFormat:@"需要%.2lf元",[x[0] floatValue]];
			needLabel.text = price;
			
			for (int i = (int)([weakself.buttonArray count] - 1); i >= 0; i--) {
				UIButton *button = weakself.buttonArray[i];
				if (i < [x count]) {
					NSString *price = [NSString stringWithFormat:@"%.2lf元",[x[i] floatValue]];
					QMSetButton(button, price, 14, nil, QMTextColor, UIControlStateNormal);
					QMSetButton(button, price, 14, nil, UIColor.whiteColor, UIControlStateSelected);
				} else {
					button.hidden = true;
				}
			}
			[whiteBack mas_updateConstraints:^(MASConstraintMaker *make) {
				make.height.mas_equalTo(120 + ([x count]/3 *60) + ([x count]%3 ? 60 : 0));
			}];
			
		}];
		
		
		RACSignal * clickSignal = [self rac_signalForSelector:@selector(changeSelectedWithButton:)];
		RACSignal *arraysSignal = [RACObserve(self, moneyArray) skip:1];
		RACSignal * myBalaneSignal = [RACObserve(self, myBalane) skip:1];
		RACSignal *mergeSignal = [[myBalaneSignal merge:clickSignal] merge:arraysSignal];
		[[mergeSignal skip:1] subscribeNext:^(id x) {
			int index = 0;
			if ([x isKindOfClass:[NSString class]]) {

			} else if ([x isKindOfClass:[UIButton class]]) {
				index = (int)((UIButton *)x).tag;
			}
			if ([_myBalane floatValue] >= [_moneyArray[index] floatValue]) {
				checkOutButton.userInteractionEnabled = true;
				QMSetButton(checkOutButton, @"提现", 18, nil, UIColor.whiteColor, UIControlStateNormal);
			} else {
				checkOutButton.userInteractionEnabled = false;
				QMSetButton(checkOutButton, @"余额不足", 18, nil, UIColor.whiteColor, UIControlStateNormal);
			}
		}];
		
		
		
		
	}
	return self;
}


- (void)changeSelectedWithButton:(UIButton *)sender {
  for (UIButton *button in _buttonArray) {
    [button setSelected:sender.tag == button.tag ? true : false];
  }
  if ([self.delegate respondsToSelector:@selector(CheckOutCollectionView:didSelectButton:)]) {
    [self.delegate CheckOutCollectionView:self didSelectButton:sender];
  }
}



- (void)checkOutButtonClick:(UIButton *)sender {
	if ([_userMessageDictionary allKeys].count >= 2) {
		if ([self.delegate respondsToSelector:@selector(CheckOutCollectionView:didSelectSure:DataDictionary:)]) {
			[self.delegate CheckOutCollectionView:self didSelectSure:sender DataDictionary:_userMessageDictionary];
		}
	} else {
		[self makeToast:@"请填写信息!"];
	}
}

@end
