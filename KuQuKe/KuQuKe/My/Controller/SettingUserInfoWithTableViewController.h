//
//  SettingUserInfoWithTableViewController.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/10.
//  Copyright © 2019 kuquke. All rights reserved.
//

//设置用户信息  列表选择
#import "DQMStaticTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SettingTableStyle) {
  SettingTableStyleJob,//工作
};

@interface SettingUserInfoWithTableViewController : DQMStaticTableViewController

/** 类型 */
@property(nonatomic,assign) SettingTableStyle          settingTableStype;

@end

NS_ASSUME_NONNULL_END
