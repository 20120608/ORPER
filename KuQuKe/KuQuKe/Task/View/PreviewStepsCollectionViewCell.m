//
//  PreviewStepsCollectionViewCell.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/16.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "PreviewStepsCollectionViewCell.h"

@interface PreviewStepsCollectionViewCell ()

/** 下标 */
@property(nonatomic,copy) NSIndexPath          *indexPath;

@end

@implementation PreviewStepsCollectionViewCell

+(PreviewStepsCollectionViewCell *)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *identifier = @"PreviewStepsCollectionViewCell";
	PreviewStepsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
	if (cell == nil)
	{
		cell = [[PreviewStepsCollectionViewCell alloc] initWithFrame:CGRectZero];
	}
	cell.indexPath = indexPath;
	return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		self.taskImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			imageView.contentMode = UIViewContentModeScaleAspectFill;
			imageView.layer.masksToBounds = true;
			imageView.layer.cornerRadius = 4;
			QMSetImage(imageView, @"timg-1.jpg");
			[self addSubview: imageView];
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
			}];
			imageView;
		});
		
		UILabel *numLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[self addSubview:label];
			label.textAlignment = NSTextAlignmentCenter;
			label.layer.masksToBounds = true;
			label.layer.cornerRadius = 4;
			QMLabelFontColorText(label, @"0", UIColor.whiteColor, 35);
			label.font = [UIFont boldSystemFontOfSize:35];
			label.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.5];
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
			}];
			label;
		});
		
		[[RACObserve(self, indexPath) skip:1] subscribeNext:^(NSIndexPath *x) {
			numLabel.text = [NSString stringWithFormat:@"%ld",(long)x.row+1];
		}];
		
		//订阅步骤图片
		QMWeak(self);
		[RACObserve(self, stepModel) subscribeNext:^(TaskPreviewStepModel *x) {
			[weakself.taskImageView qm_setImageUrlString:x.imageUrl];
		}];
		
	}
	return self;
}



@end

