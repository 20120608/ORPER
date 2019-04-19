//
//  CategoryModel.m
//  KuQuKe
//
//  Created by Xcoder on 2019/4/16.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "CategoryModel.h"

@implementation DiscountList

@end
@implementation ServiceList

@end
@implementation AttributeValueList

@end

@implementation AttributeList
+ (NSDictionary *)mj_objectClassInArray{
	return @{ @"attributeValueList" : [AttributeValueList class]
			  };
}
@end

@implementation SkuInfoList
+ (NSDictionary *)mj_objectClassInArray{
	return @{ @"attributeValueList" : [AttributeValueList class]
			  };
}

@end


@implementation Data
+ (NSDictionary *)mj_objectClassInArray{
	return @{ @"discountList" : [DiscountList class],
			  @"serviceList" : [ServiceList class],
			  @"attributeList" : [AttributeList class],
			  @"skuInfoList" : [SkuInfoList class],
			  };
}

@end


@implementation CategoryModel

@end
