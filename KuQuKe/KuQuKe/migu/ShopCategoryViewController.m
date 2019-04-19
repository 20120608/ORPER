//
//  ShopCategoryViewController.m
//  KuQuKe
//
//  Created by Xcoder on 2019/4/16.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "ShopCategoryViewController.h"
#import "CategoryModel.h"
#import "AFNetworking.h"
#import "KuCunView.h"

#define NOSELECTSTRING @"-1"

@interface ShopCategoryViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)CategoryModel *categoryModel;

//已选择的SKU的数组
@property(nonatomic,strong)NSMutableArray *selectSKUArr;

@property(nonatomic,strong)UILabel *kucunLabel;

@end

@implementation ShopCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	QMURLSessionTask *sessionTask = nil;
	sessionTask = [manager GET:@"http://192.168.0.204:8088/json/a.json" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		NSDictionary *dataDic = kJSON(responseObject);
		RequestStatusModel *reqsModel = [RequestStatusModel mj_objectWithKeyValues:dataDic];
		if ([reqsModel.code intValue] == 0) {
			self.categoryModel = [CategoryModel mj_objectWithKeyValues:dataDic];
			if (_categoryModel != nil) {
				
				self.selectSKUArr = [[NSMutableArray alloc] init];
				[_categoryModel.data.attributeList enumerateObjectsUsingBlock:^(AttributeList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
					[_selectSKUArr addObject:NOSELECTSTRING];
				}];
				
				[self createUI];
				
				
				KuCunView *v = [[KuCunView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, 250)];
				v.categoryModel = _categoryModel;
				[self.view addSubview:v];
			}
		}
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
	}];
}


- (void)createUI {
	
	UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
	[layout setScrollDirection:UICollectionViewScrollDirectionVertical]; //设置竖直滚动
	layout.minimumInteritemSpacing = 0;
	layout.minimumLineSpacing = 0;
	CGFloat kStepWidth = (SCREEN_WIDTH)/3;
	layout.itemSize = CGSizeMake(kStepWidth, 50);
	layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 44);
	
	
	self.collectionView = ({
		UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 250+STATUS_BAR_HEIGHT+30, kScreenWidth, SCREEN_HEIGHT-200) collectionViewLayout:layout];
		view.delegate = self;
		view.dataSource = self;
		view.backgroundColor = QMBackColor;
		view.showsHorizontalScrollIndicator = false;
		[view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"defaultCell"];
		[view registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
		view;
	});
	[self.view addSubview: _collectionView];
	
	
	UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-150, SCREEN_WIDTH, 150)];
	whiteView.backgroundColor = UIColor.whiteColor;
	[self.view addSubview:whiteView];
	self.kucunLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
	[whiteView addSubview:_kucunLabel];
	_kucunLabel.text = [NSString stringWithFormat:@"库存:%@",_categoryModel.data.stockQuantity];
	
}


-(void)reload {
	[self reloadInfoMsg];
	
	[self.collectionView reloadData];
}


-(void)reloadInfoMsg {
	
	//查询价格区间  库存   已选的sku  限购数量
	
	
}



#pragma mark - UICollection dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return self.categoryModel.data.attributeList.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	NSInteger num = self.categoryModel.data.attributeList[section].attributeValueList.count;
	return num;
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	UICollectionReusableView *reusableview = nil;
	if (kind == UICollectionElementKindSectionHeader) {
		UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
		[headerView removeAllSubviews];
		
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 44)];
		[headerView addSubview:titleLabel];
		titleLabel.textColor = QMTextColor;
		titleLabel.text = [NSString stringWithFormat:@"%@ -- %@",self.categoryModel.data.attributeList[indexPath.section].attributeName,self.categoryModel.data.attributeList[indexPath.section].attributeId];
		
		reusableview = headerView;
	}
	return reusableview;
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	//cell.tag 用来临时作为是否可以点击的变量
	//0 可选  1已选  2不可选
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"defaultCell" forIndexPath:indexPath];
	[cell.contentView removeAllSubviews];
	
	UILabel *titleLabel = [[UILabel alloc] init];
	titleLabel.userInteractionEnabled = false;
	[cell.contentView addSubview:titleLabel];
	titleLabel.layer.borderWidth = 1;
	titleLabel.textAlignment = NSTextAlignmentCenter;
	titleLabel.layer.borderColor = UIColor.lightGrayColor.CGColor;
	titleLabel.text = self.categoryModel.data.attributeList[indexPath.section].attributeValueList[indexPath.row].attributeValue;
	[titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
	}];
	
	//设置样式
	[self settingCellStatusForCollectionView:collectionView cell:cell ForItemAtIndexPath:indexPath];
	
	return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
	if (cell.tag != 2) {
		//将对应的选择存入数组中 或者从数组中移除
		if (cell.tag == 0) {
			[self.selectSKUArr replaceObjectAtIndex:indexPath.section withObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
		} else {
			[self.selectSKUArr replaceObjectAtIndex:indexPath.section withObject:NOSELECTSTRING];
		}
	}
	//刷新
	[self reload];
}

#pragma mark 按钮的状态设置
- (void)settingCellStatusForCollectionView:(UICollectionView *)collectionView  cell:(UICollectionViewCell *)cell ForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	//需要过滤的字段
	NSMutableArray *needConformArray = [[NSMutableArray alloc] init];
	[self.selectSKUArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if (indexPath.section == idx) {
			
		} else if (![obj isEqualToString:NOSELECTSTRING]) {
			NSString *skuValue = _categoryModel.data.attributeList[idx].attributeValueList[[obj integerValue]].attributeValue;
			[needConformArray addObject:skuValue];
		}
	}];
	
	NSMutableArray<SkuInfoList *> *includArr = [[NSMutableArray alloc] initWithArray:self.categoryModel.data.skuInfoList];
	[self.categoryModel.data.skuInfoList enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(SkuInfoList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[needConformArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString *  _Nonnull skuValue, NSUInteger idx, BOOL * _Nonnull stop) {
			__block BOOL remove = true;
			[obj.attributeValueList enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(AttributeValueList * _Nonnull attribute, NSUInteger idx, BOOL * _Nonnull stop) {
				if ([attribute.attributeValue isEqualToString:skuValue]) {
					remove = false;
				}
			}];
			
			if (remove) {
				[includArr removeObject:obj];
			}
		}];
		
	}];
	if ([_selectSKUArr[indexPath.section] integerValue] == indexPath.row) {
		cell.tag = 1;
		cell.backgroundColor = UIColor.redColor;
		return;
	}
	__block NSInteger status = 2;// 0 1 2
	//尺码有被选中的
	[includArr enumerateObjectsUsingBlock:^(SkuInfoList * _Nonnull skuinfoList, NSUInteger idx, BOOL * _Nonnull stop) {
		[skuinfoList.attributeValueList enumerateObjectsUsingBlock:^(AttributeValueList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull skuinfoListStop) {
			if ([obj.attributeValue isEqualToString:_categoryModel.data.attributeList[indexPath.section].attributeValueList[indexPath.row].attributeValue]) {
				status = 0;
			}
		}];
	}];
	cell.tag = status;
	if (cell.tag == 0) {
		cell.backgroundColor = UIColor.whiteColor;
	} else {
		cell.backgroundColor = UIColor.blackColor;
	}
}



@end
