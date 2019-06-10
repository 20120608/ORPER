//
//  HXCollectionViewCell.m
//  KuQuKe
//
//  Created by Xcoder on 2019/5/31.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "HXCollectionViewCell.h"

@interface HXCollectionViewCell ()<HXPhotoViewDelegate>

/** 下标 */
@property(nonatomic,copy) NSIndexPath          *indexPath;
/**  照片管理  */
@property (nonatomic, strong) HXPhotoManager *manager;

@end

@implementation HXCollectionViewCell

+(HXCollectionViewCell *)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *identifier = @"HXCollectionViewCell";
	HXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
	if (cell == nil)
	{
		cell = [[HXCollectionViewCell alloc] initWithFrame:CGRectZero];
	}
	cell.indexPath = indexPath;
	return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		self.exImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[self addSubview: imageView];
			QMSetImage(imageView, @"img_track_of_reading");
			QMViewBorderRadius(imageView, 4, 0, DQMMainColor);
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.top.right.mas_equalTo(0);
				make.height.mas_equalTo(imageView.mas_width);
			}];
			imageView;
		});
		
		[self.contentView addSubview:self.photoView];

	}
	return self;
}

-(void)settingExImg:(NSString *)img {
	[_exImageView qm_setWithImageURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
}


- (void)setModel:(HXModel *)model {
	_model = model;
	
	[self.manager changeAfterCameraArray:model.endCameraList];
	[self.manager changeAfterCameraPhotoArray:model.endCameraPhotos];
	[self.manager changeAfterCameraVideoArray:model.endCameraVideos];
	[self.manager changeAfterSelectedCameraArray:model.endSelectedCameraList];
	[self.manager changeAfterSelectedCameraPhotoArray:model.endSelectedCameraPhotos];
	[self.manager changeAfterSelectedCameraVideoArray:model.endSelectedCameraVideos];
	[self.manager changeAfterSelectedArray:model.endSelectedList];
	[self.manager changeAfterSelectedPhotoArray:model.endSelectedPhotos];
	[self.manager changeAfterSelectedVideoArray:model.endSelectedVideos];
	[self.manager changeICloudUploadArray:model.iCloudUploadArray];
	
	// 这些操作需要放在manager赋值的后面，不然会出现重用..
	if (model.section == 0) {
		self.manager.configuration.albumShowMode = HXPhotoAlbumShowModePopup;
		self.photoView.previewStyle = HXPhotoViewPreViewShowStyleDark;
		self.photoView.collectionView.editEnabled = NO;
		self.photoView.hideDeleteButton = YES;
		self.photoView.showAddCell = NO;
		if (!model.addCustomAssetComplete && model.customAssetModels.count) {
			[self.manager addCustomAssetModel:model.customAssetModels];
			model.addCustomAssetComplete = YES;
		}
	}else {
		self.manager.configuration.albumShowMode = HXPhotoAlbumShowModeDefault;
		self.photoView.previewStyle = HXPhotoViewPreViewShowStyleDefault;
		self.photoView.collectionView.editEnabled = YES;
		self.photoView.hideDeleteButton = NO;
		self.photoView.showAddCell = YES;
	}
	
	[self.photoView refreshView];
}
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
	if (photoView == self.photoView) {
		self.model.endCameraList = self.manager.afterCameraArray.mutableCopy;
		self.model.endCameraPhotos = self.manager.afterCameraPhotoArray.mutableCopy;
		self.model.endCameraVideos = self.manager.afterCameraVideoArray.mutableCopy;
		self.model.endSelectedCameraList = self.manager.afterSelectedCameraArray.mutableCopy;
		self.model.endSelectedCameraPhotos = self.manager.afterSelectedCameraPhotoArray.mutableCopy;
		self.model.endSelectedCameraVideos = self.manager.afterSelectedCameraVideoArray.mutableCopy;
		self.model.endSelectedList = self.manager.afterSelectedArray.mutableCopy;
		self.model.endSelectedPhotos = self.manager.afterSelectedPhotoArray.mutableCopy;
		self.model.endSelectedVideos = self.manager.afterSelectedVideoArray.mutableCopy;
		self.model.iCloudUploadArray = self.manager.afterICloudUploadArray.mutableCopy;
	}
	if (photos.count > 0) {
		self.selectHXPhotoModel = photos[0];
	} else {
		self.selectHXPhotoModel = nil;
	}
}

- (HXPhotoManager *)manager {
	if (!_manager) {
		_manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
		_manager.configuration.selectTogether = YES;
		_manager.configuration.photoMaxNum = 1;
		_manager.configuration.videoMaxNum = 0;
		_manager.configuration.maxNum = 1;
	}
	return _manager;
}

- (HXPhotoView *)photoView {
	if (!_photoView) {
		_photoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(0, ((kScreenWidth - 33)/4 - 1)+10, ((kScreenWidth - 33)/4 - 1), ((kScreenWidth - 33)/4 - 1)) manager:self.manager];
		_photoView.backgroundColor = [UIColor whiteColor];
		_photoView.delegate = self;
		_photoView.lineCount = 1;
	}
	return _photoView;
}


@end

