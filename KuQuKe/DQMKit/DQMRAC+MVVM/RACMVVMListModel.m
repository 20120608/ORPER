//
//  RACMVVMListModel.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/25.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "RACMVVMListModel.h"

@implementation RACMVVMListModel

- (void)setImgUrl:(NSString *)imgUrl {
  _imgUrl = [NSString stringWithFormat:@"https://mobile.piaoduwang.cn/%@",imgUrl];
}

@end

