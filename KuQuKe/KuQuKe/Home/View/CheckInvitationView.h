//
//  CheckInvitationView.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/2/25.
//  Copyright © 2019 kuquke. All rights reserved.
//

//是否绑定了邀请码
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CheckInvitationView;
@protocol CheckInvitationViewDelegate <NSObject>

- (void)CheckInvitationView:(CheckInvitationView *)invitationView DidSelectInvitation:(NSString *)codeString;

- (void)CheckInvitationViewDidSelectAddQQSection:(CheckInvitationView *)invitationView;

@end

@interface CheckInvitationView : UIView

/** 代理 */
@property(nonatomic,weak) id<CheckInvitationViewDelegate>          delegate;

- (void)show;
- (void)hide;


@end

NS_ASSUME_NONNULL_END
