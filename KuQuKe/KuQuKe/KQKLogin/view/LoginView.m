//
//  LoginView.m
//  KuQuKe
//
//  Created by hallelujah on 2019/3/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		UIImageView *logoImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[self addSubview: imageView];
			QMSetImage(imageView, @"logo");
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerX.mas_equalTo(self.centerX);
				make.top.mas_equalTo(self).offset(120);
				make.size.mas_equalTo(CGSizeMake(100, 100));
			}];
			imageView;
		});
		
		
		NSArray *dataArr = @[@{@"place":@"请填写账号",@"icon":@"用户"},@{@"place":@"请填写密码",@"icon":@"密码"}];
		NSMutableArray *inputTFArray = [[NSMutableArray alloc] init];
		for (int i = 0; i < 2; i++) {
			UITextField *inputTextField = ({
				UITextField *textField = [[UITextField alloc] init];
				[self addSubview:textField];
				textField.placeholder = dataArr[i][@"place"];
				textField.textColor = QMTextColor;
				textField.font = KQMFont(16);
				QMViewBorderRadius(textField, 4, 1, DQMMainColor);
				[textField mas_makeConstraints:^(MASConstraintMaker *make) {
					make.top.mas_equalTo(logoImageView.mas_bottom).offset(80+i*(74));
					make.height.mas_equalTo(54);
					make.left.mas_equalTo(20);
					make.right.mas_equalTo(-20);
				}];
				[inputTFArray addObject:textField];
				textField;
			});
			inputTextField.leftViewMode = UITextFieldViewModeAlways;
			UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 54, 34)];
			[inputTextField setLeftView:leftView];
			
			UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 24, 24)];
			[leftView addSubview: iconImageView];
			QMSetImage(iconImageView, dataArr[i][@"icon"]);
			
			UIView *line = [[UIView alloc] initWithFrame:CGRectMake(44, 5, 1, 24)];
			line.backgroundColor = DQMMainColor;
			[leftView addSubview: line];
		}
		
		UIButton *loginButton = ({
			UIButton *button = [[UIButton alloc] init];
			[self addSubview:button];
			button.backgroundColor = DQMMainColor;
			QMSetButton(button, @"登录", 18, nil, UIColor.whiteColor, UIControlStateNormal);
			QMViewBorderRadius(button, 6, 0, DQMMainColor);
			[button mas_makeConstraints:^(MASConstraintMaker *make) {
				make.top.mas_equalTo(logoImageView.mas_bottom).offset(234);
				make.height.mas_equalTo(54);
				make.left.mas_equalTo(20);
				make.right.mas_equalTo(-20);
			}];
			button;
		});
		[loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];

		UIView *line = ({
			UIView *view = [[UIView alloc] init];
			[self addSubview: view];
			view.backgroundColor = QMTextColor;
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerX.mas_equalTo(self.mas_centerX);
				make.height.mas_equalTo(25);
				make.width.mas_equalTo(1);
				make.top.mas_equalTo(loginButton.mas_bottom).offset(25);
			}];
			view;
		});
		
		UIButton *passWordChangeButton = ({
			UIButton *button = [[UIButton alloc] init];
			[self addSubview:button];
			QMSetButton(button, @"忘记密码？", 16, nil, QMTextColor, UIControlStateNormal);
			[button mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(line.mas_left);
				make.width.mas_equalTo(100);
				make.height.mas_equalTo(44);
				make.top.mas_equalTo(loginButton.mas_bottom).offset(20);
			}];
			button;
		});
		[passWordChangeButton addTarget:self action:@selector(passWordChangeButtonClick:) forControlEvents:UIControlEventTouchUpInside];

		UIButton *registerButton = ({
			UIButton *button = [[UIButton alloc] init];
			[self addSubview:button];
			QMSetButton(button, @"一键注册", 16, nil, DQMMainColor, UIControlStateNormal);
			[button mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(line.mas_right);
				make.width.mas_equalTo(100);
				make.height.mas_equalTo(44);
				make.top.mas_equalTo(loginButton.mas_bottom).offset(20);
			}];
			button;
		});
		[registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		
		
		[[self rac_signalForSelector:@selector(loginButtonClick:)] subscribeNext:^(id  _Nullable x) {
			if ([((UITextField *)inputTFArray[0]).text length] < 3) {
				[self makeToast:@"请输入电话！"];
				return ;
			} else if ([((UITextField *)inputTFArray[1]).text length] < 3)  {
				[self makeToast:@"请输入密码！"];
				return ;
			}
			NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
			[params setValue:((UITextField *)inputTFArray[0]).text forKey:@"mobile"];
			[params setValue:((UITextField *)inputTFArray[1]).text forKey:@"password"];
			[KuQuKeNetWorkManager POST_bindLoginParams:params View:self success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
				//保存信息
				[kUserDefaults setValue:dataDic[@"data"][@"head_pic"] forKey:@"HEADPIC"];
				[kUserDefaults setValue:dataDic[@"data"][@"nickname"] forKey:@"NICKNAME"];
				[kUserDefaults setValue:dataDic[@"data"][@"user_id"] forKey:@"USERID"];
				[self makeToast:@"登录成功"];
				dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
					[self.currentVC dismissViewControllerAnimated:true completion:nil];
				});
				
			} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
				
			} failure:^(NSError *error) {
				
			}];
			
		}];
		
		//忘记密码
		[[self rac_signalForSelector:@selector(passWordChangeButtonClick:)] subscribeNext:^(id  _Nullable x) {
			if ([((UITextField *)inputTFArray[0]).text length] < 3) {
				[self makeToast:@"请输入电话！"];
				return ;
			}
			NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
			[params setValue:((UITextField *)inputTFArray[0]).text forKey:@"mobile"];
			[KuQuKeNetWorkManager POST_findPasswordParams:params View:self success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
				[self makeToast:dataDic[@"msg"]];
			} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
				
			} failure:^(NSError *error) {
				
			}];
		}];
		
	}
	return self;
}

- (void)loginButtonClick:(UIButton *)sender {
	if ([_delegate respondsToSelector:@selector(LoginView:loginButtonClick:)]) {
		[_delegate LoginView:self loginButtonClick:sender];
	}
}

- (void)passWordChangeButtonClick:(UIButton *)sender {
	if ([_delegate respondsToSelector:@selector(LoginView:passWordChangeButtonClick:)]) {
		[_delegate LoginView:self passWordChangeButtonClick:sender];
	}
}

- (void)registerButtonClick:(UIButton *)sender {
	if ([_delegate respondsToSelector:@selector(LoginView:registerButtonClick:)]) {
		[_delegate LoginView:self registerButtonClick:sender];
		//登录
		[self loadData];
		
	}
}


#pragma mark - get data
- (void)loadData {
	//用设备号登入
	NSString *deviceID = GET_USERDEFAULT(@"DEVICEID");
	if (deviceID.length == 0) {
		[self makeToast:@"获取不到UDID"];
		return;
	}
	NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
	[postDic setValue:deviceID forKey:@"deviceid"];
	[postDic setValue:[NSNumber numberWithInteger:2] forKey:@"phonetype"];
	
	[KuQuKeNetWorkManager POST_Kuqukelogin:postDic View:self success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
		//登录成功
		[self logInSuccess:dataDic];
		
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
	} failure:^(NSError *error) {
		
	}];
}

/**
 登录成功 设置信息并 请求广告信息
 */
- (void)logInSuccess:(NSDictionary *)dataDic {
	[kUserDefaults setValue:dataDic[@"data"][@"head_pic"] forKey:@"HEADPIC"];
	[kUserDefaults setValue:dataDic[@"data"][@"nickname"] forKey:@"NICKNAME"];
	[kUserDefaults setValue:dataDic[@"data"][@"user_id"] forKey:@"USERID"];
	[self.currentVC dismissViewControllerAnimated:true completion:nil];
}

@end
