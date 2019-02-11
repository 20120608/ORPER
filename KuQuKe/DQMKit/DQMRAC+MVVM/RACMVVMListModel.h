//
//  RACMVVMListModel.h
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/25.
//  Copyright © 2019 kuquke. All rights reserved.
//


//MVVMDemo的model
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACMVVMListModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *publishHouse;
@property (nonatomic, copy) NSString *isbn;

@end

NS_ASSUME_NONNULL_END
