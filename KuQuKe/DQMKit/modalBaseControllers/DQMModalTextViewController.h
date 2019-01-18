//
//  DQMModalTextViewController.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/18.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "DQMModalNavUIBaseViewController.h"

@class DQMModalTextViewController;
@protocol DQMModalTextViewControllerDataSource <NSObject>

@optional
- (UIReturnKeyType)textViewControllerLastReturnKeyType:(DQMModalTextViewController *)textViewController;

- (BOOL)textViewControllerEnableAutoToolbar:(DQMModalTextViewController *)textViewController;

//  控制是否可以点击点击的按钮
- (NSArray <UIButton *> *)textViewControllerRelationButtons:(DQMModalTextViewController *)textViewController;

@end


@protocol DQMModalTextViewControllerDelegate <UITextViewDelegate, UITextFieldDelegate>

@optional
#pragma mark - 最后一个输入框点击键盘上的完成按钮时调用
- (void)textViewController:(DQMModalTextViewController *)textViewController inputViewDone:(id)inputView;
@end

@interface DQMModalTextViewController : DQMModalNavUIBaseViewController<DQMModalTextViewControllerDataSource, DQMModalTextViewControllerDelegate>

- (BOOL)textFieldShouldClear:(UITextField *)textField NS_REQUIRES_SUPER;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string NS_REQUIRES_SUPER;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_REQUIRES_SUPER;
- (BOOL)textFieldShouldReturn:(UITextField *)textField NS_REQUIRES_SUPER;


@end




#pragma mark - design UITextField
IB_DESIGNABLE
@interface UITextField (DQMModalTextViewController)

@property (assign, nonatomic) IBInspectable BOOL isEmptyAutoEnable;

@end


@interface DQMModalTextViewControllerTextField : UITextField

@end

