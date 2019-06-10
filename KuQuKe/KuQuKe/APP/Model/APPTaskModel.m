//
//  APPTaskModel.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/2/20.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "APPTaskModel.h"

@implementation APPTaskModel

	
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	/* 返回的字典，key为模型属性名，value为转化的字典的多级key */
	return @{
			 @"img_url" : @"appicon_url",
			 };
}

@end
