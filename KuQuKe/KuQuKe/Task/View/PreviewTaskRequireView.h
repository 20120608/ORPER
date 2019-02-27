//
//  PreviewTaskRequireView.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//


//预览任务的界面  上面有价格时间，中间有图标  下面有任务内容  再下去是图片预览  最后有个开始任务
#import <UIKit/UIKit.h>
#import "EarnMoneyDetailModel.h"//模型

NS_ASSUME_NONNULL_BEGIN
@class PreviewTaskRequireView;
@protocol PreviewTaskRequireViewDelegate <NSObject>

- (void)beginButtonClickPreviewTaskRequireView:(PreviewTaskRequireView *)view;

@end

@interface PreviewTaskRequireView : UIView

/** 代理 */
@property(nonatomic,weak) id<PreviewTaskRequireViewDelegate>  delegate;

/** 数据 */
@property(nonatomic,strong) EarnMoneyDetailModel          *earnModel;

/** 图片数组 */
@property (nonatomic, copy) NSMutableArray<NSString *> *imagesUrlStringArray;

@end

NS_ASSUME_NONNULL_END
