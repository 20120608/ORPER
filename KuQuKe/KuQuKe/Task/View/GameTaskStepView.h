//
//  GameTaskStepView.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/23.
//  Copyright © 2019 kuquke. All rights reserved.
//


//游戏互动的步骤view
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GameTaskStepViewStyle){
  GameTaskStepViewStyleDefault,
  GameTaskStepViewStyleBackgroundColorGary,
};

@class GameTaskStepViewModel;
@interface GameTaskStepView : UIView

/** 类型 */
@property(nonatomic,assign) GameTaskStepViewStyle          style;


/** 模型 */
@property(nonatomic,strong) GameTaskStepViewModel          *viewModel;


@end



@interface GameTaskStepViewModel : NSObject

/** 下标 */
@property (nonatomic,assign) NSInteger index;

/** 颜色 */
@property (nonatomic,strong) UIColor   *backColor;

/** 颜色 */
@property (nonatomic,strong) UIColor   *buttonTitleColor;

/** 颜色 */
@property (nonatomic,strong) UIColor   *buttonBackColor;

/** 颜色 */
@property(nonatomic,copy) NSMutableAttributedString *attriString;



@end

NS_ASSUME_NONNULL_END
