//
//  CategoryModel.h
//  KuQuKe
//
//  Created by Xcoder on 2019/4/16.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountList :NSObject
@property (nonatomic , copy) NSString              * discountTitle;
@property (nonatomic , copy) NSString              * discountDesc;
@property (nonatomic , copy) NSString              * discountType;
@property (nonatomic , copy) NSString              * discountIcon;
@property (nonatomic , copy) NSString              * discountId;

@end

@interface ServiceList :NSObject
@property (nonatomic , copy) NSString              * serviceName;
@property (nonatomic , copy) NSString              * serviceIcon;
@property (nonatomic , copy) NSString              * serviceDesc;

@end

@interface AttributeValueList :NSObject
@property (nonatomic , copy) NSString              * attributeValue;
@property (nonatomic , copy) NSString              * attributeValueId;
@property (nonatomic , copy) NSString              * previewImage;
@property (nonatomic , copy) NSString              * valueAlias;
@property (nonatomic , copy) NSString              * attributeId;
@property (nonatomic , copy) NSString              * skuId;

@end

@interface AttributeList :NSObject
@property (nonatomic , copy) NSString              * isSku;
@property (nonatomic , copy) NSArray<AttributeValueList *>              * attributeValueList;
@property (nonatomic , copy) NSString              * supportImage;
@property (nonatomic , copy) NSString              * attributeId;
@property (nonatomic , copy) NSString              * attributeName;

@end



@interface SkuInfoList :NSObject
@property (nonatomic , copy) NSArray<AttributeValueList *>              * attributeValueList;
@property (nonatomic , copy) NSString              * marketPrice;
@property (nonatomic , copy) NSString              * salePrice;
@property (nonatomic , copy) NSString              * skuId;
@property (nonatomic , copy) NSString              * stockQuantity;
@property (nonatomic , copy) NSString              * previewImage;

@end

@interface Data :NSObject
@property (nonatomic , copy) NSString              * leafCategoryId;
@property (nonatomic , copy) NSString              * ipId;
@property (nonatomic , copy) NSString              * productCode;
@property (nonatomic , copy) NSString              * stockQuantity;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * productDesc;
@property (nonatomic , copy) NSString              * supId;
@property (nonatomic , copy) NSString              * hasFavor;
@property (nonatomic , copy) NSString              * minSalePrice;
@property (nonatomic , copy) NSString              * minMarketPrice;
@property (nonatomic , copy) NSString              * maxPurchaseQuantity;
@property (nonatomic , copy) NSString              * monthlySales;
@property (nonatomic , copy) NSArray<NSString *>              * spuImageList;
@property (nonatomic , copy) NSArray<DiscountList *>              * discountList;
@property (nonatomic , copy) NSArray<ServiceList *>              * serviceList;
@property (nonatomic , copy) NSString              * imageUrl;
@property (nonatomic , copy) NSString              * brandId;
@property (nonatomic , copy) NSString              * minPurchaseQuantity;
@property (nonatomic , copy) NSString              * maxSalePrice;
@property (nonatomic , copy) NSArray<AttributeList *>              * attributeList;
@property (nonatomic , copy) NSString              * maxMarketPrice;
@property (nonatomic , copy) NSString              * productName;
@property (nonatomic , copy) NSArray<SkuInfoList *>              * skuInfoList;

@end

@interface CategoryModel :NSObject
@property (nonatomic , strong) Data              * data;
@property (nonatomic , assign) NSInteger              code;

@end
