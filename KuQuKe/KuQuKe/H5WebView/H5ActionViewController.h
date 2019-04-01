//
//  H5ActionViewController.h
//  KuQuKe
//
//  Created by hallelujah on 2019/3/11.
//  Copyright © 2019年 kuquke. All rights reserved.
//

//web界面
#import "DQMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface H5ActionViewController : DQMBaseViewController


/** 连接 */
@property(nonatomic,strong) NSString          *apartUrl;

/** 分享的参数 */
@property(nonatomic,strong) NSMutableDictionary          *shareDic;


@end

NS_ASSUME_NONNULL_END
