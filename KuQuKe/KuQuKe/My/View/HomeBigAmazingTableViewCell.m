//
//  HomeBigAmazingTableViewCell.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "HomeBigAmazingTableViewCell.h"
#import "UIView+WebCache.h"
#import "UIImage+GIF.h"

@implementation HomeBigAmazingTableViewCell

+(HomeBigAmazingTableViewCell *)cellWithTableView:(UITableView *)tableview
{
	static NSString *identifier = @"HomeBigAmazingTableViewCell";
	HomeBigAmazingTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil)
	{
		cell = [[HomeBigAmazingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self)
	{
		UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/375*111)];
		headerView.contentMode = UIViewContentModeScaleAspectFit;
		[headerView setImage:[UIImage imageNamed:@"banner.jpg"]];
		[self.contentView addSubview:headerView];
		[headerView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
			make.height.mas_equalTo(kScreenWidth/375*111);
		}];
		
		@weakify(self);
		[[RACObserve(self, adimgString) skip:1] subscribeNext:^(NSString *x) {

			[headerView sd_internalSetImageWithURL:[NSURL URLWithString:x] placeholderImage:nil options:0 operationKey:nil setImageBlock:^(UIImage * _Nullable image, NSData * _Nullable imageData) {
				if (imageData) {
					[headerView setImage:[UIImage sd_animatedGIFWithData:imageData]];
				}
			} progress:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
				@strongify(self);
				if (!error) {
					
				} else {
					self.hidden = YES;
				}
			}];
		}];
		
		
	}
	return self;
}

@end
