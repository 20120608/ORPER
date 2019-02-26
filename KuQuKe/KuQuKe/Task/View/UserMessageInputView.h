//
//  UserMessageInputView.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXPhotoPicker.h"
#import "SDWebImageManager.h"

NS_ASSUME_NONNULL_BEGIN

@class UserMessageInputView;
@protocol UserMessageInputViewDelegate <NSObject>

/**
 提交审核
 */
- (void)saveToInvestigateWithUserMessageInputView:(UserMessageInputView *)userMessageInputView ImageArray:(NSArray <HXPhotoModel *>  *)imageArray code:(NSString *)code phone:(NSString *)phone name:(NSString *)name;

/**
 开始任务
 */
- (void)getCodeWithUserMessageInputView:(UserMessageInputView *)userMessageInputView code:(NSString *)code phone:(NSString *)phone name:(NSString *)name;

@end

@interface UserMessageInputView : UIView

/** 代理 */
@property(nonatomic,weak) id<UserMessageInputViewDelegate>          delegate;

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

/** 数据 */
@property(nonatomic,strong) NSArray <HXPhotoModel *> *imageArray;

@end

NS_ASSUME_NONNULL_END
