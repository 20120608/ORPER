//
//  SettingUserInfoWithInputViewController.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/10.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SettingInputStyle) {
  SettingInputStyleNickName,//昵称
  SettingInputStyleBirthday,//生日
  SettingInputStyleWeChat,//微信
  SettingInputStyleQQ,//QQ
  SettingInputStylePhone//电话
};

@interface SettingUserInfoWithInputViewController : DQMBaseViewController

/** 类型 */
@property(nonatomic,assign) SettingInputStyle          settingInputStyle;




@end

NS_ASSUME_NONNULL_END
