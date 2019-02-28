//
//  SettingUserInfoWithInputViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/10.
//  Copyright © 2019 kuquke. All rights reserved.
//

//带输入框和标题的设置界面 
#import "SettingUserInfoWithInputViewController.h"

@interface SettingUserInfoWithInputViewController ()

/** 标题 */
@property(nonatomic,copy) NSString *naviName;

/** 输入框 */
@property(nonatomic,strong) UITextField *textField;


@end

@implementation SettingUserInfoWithInputViewController


-(void)viewDidLoad {
  [super viewDidLoad];
  
  self.naviName = _settingInputStyle == SettingInputStyleNickName ? @"昵称" : _settingInputStyle == SettingInputStyleBirthday ? @"生日" : _settingInputStyle == SettingInputStyleWeChat ? @"微信" : _settingInputStyle == SettingInputStyleQQ ? @"QQ" : _settingInputStyle == SettingInputStylePhone ? @"电话" : _settingInputStyle == SettingInputStyleAliPay ? @"支付宝" : _settingInputStyle == SettingInputStyleEmail ? @"邮箱" : @"其他";
	
	UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+10, kScreenWidth, 50)];
  self.textField = textField;
  textField.backgroundColor = UIColor.whiteColor;
	textField.placeholder = _naviName;
	UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 50)];
	textField.leftView = leftView;
	textField.leftViewMode = UITextFieldViewModeAlways;
  textField.returnKeyType = UIReturnKeyDone;
  textField.keyboardType = _settingInputStyle == SettingInputStyleNickName ? UIKeyboardTypeDefault : _settingInputStyle == SettingInputStyleBirthday ? UIKeyboardTypeDefault : _settingInputStyle == SettingInputStyleWeChat ? UIKeyboardTypeDefault : _settingInputStyle == SettingInputStyleQQ ? UIKeyboardTypeNumberPad : _settingInputStyle == SettingInputStylePhone ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
	[self.view addSubview:textField];
	
  
}

/**
 保存到后台
 */
- (void)saveUserInfoWithType:(NSString *)type Value:(NSString *)value {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
  [params setValue:type forKey:@"type"];
  [params setValue:value forKey:@"data"];
  
  [KuQuKeNetWorkManager POST_updateUserInfoParams:params View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
    
    [self.view makeToast:@"修改成功"];
    
  } unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
    
  } failure:^(NSError *error) {
    
  }];
}

#pragma mark - dqm_navibar
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar {
  return true;
}

/** 导航条左边的按钮 */
- (UIImage *)dqmNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(DQMNavigationBar *)navigationBar {
  [leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];
  return [UIImage imageNamed:@"NavgationBar_white_back"];
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
  [self.navigationController popViewControllerAnimated:true];
}

-(UIView *)dqmNavigationBarRightView:(DQMNavigationBar *)navigationBar {
  UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
  [saveButton setTitle:@"保存" forState:UIControlStateNormal];
  [saveButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
  [saveButton.titleLabel setFont:KQMFont(14)];
  return saveButton;
}

-(void)rightButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
  NSString *newString = self.textField.text;
  
  switch (_settingInputStyle) {
      case SettingInputStyleNickName:
      [self saveUserInfoWithType:@"1" Value:newString];
      break;
      case SettingInputStyleWeChat:
      [self saveUserInfoWithType:@"5" Value:newString];
      break;
      case SettingInputStyleQQ:
      [self saveUserInfoWithType:@"10" Value:newString];
      break;
      case SettingInputStylePhone:
      [self saveUserInfoWithType:@"6" Value:newString];
      break;
      case SettingInputStyleAliPay:
      [self saveUserInfoWithType:@"11" Value:newString];
      break;
      case SettingInputStyleEmail:
      [self saveUserInfoWithType:@"7" Value:newString];
      break;
    default:
      break;
  }
  
  [self.navigationController popViewControllerAnimated:true];
}

- (NSMutableAttributedString *)dqmNavigationBarTitle:(DQMNavigationBar *)navigationBar {
  
  return [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:_naviName color:UIColor.whiteColor];
}

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
  return DQMMainColor;
}


@end
