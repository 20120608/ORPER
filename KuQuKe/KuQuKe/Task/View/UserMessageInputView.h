//
//  UserMessageInputView.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserMessageInputView : UIView

/** 姓名 */
@property (nonatomic,strong) UILabel     *nameLabel;
/** 电话 */
@property (nonatomic,strong) UILabel     *phoneLabel;
/** 验证码 */
@property (nonatomic,strong) UILabel     *codeLabel;

/** 姓名 */
@property (nonatomic,strong) UITextField *nameTextFiled;
/** 电话 */
@property (nonatomic,strong) UITextField *phoneTextFiled;
/** 验证码 */
@property (nonatomic,strong) UITextField *codeTextFiled;

/** 验证码 */
@property (nonatomic,strong) UIButton    *codeButton;

/** 提交的图片数组 */
@property (nonatomic,strong) UIView      *printScreensView;

/** 提交审核按钮 */
@property (nonatomic,strong) UIButton    *putButton;
/** 介绍 */
@property (nonatomic,strong) UILabel     *msgLabel;

@end

NS_ASSUME_NONNULL_END
