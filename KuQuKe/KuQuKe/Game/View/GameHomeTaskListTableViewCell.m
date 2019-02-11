//
//  GameHomeTaskListTableViewCell.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/18.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "GameHomeTaskListTableViewCell.h"

@interface GameHomeTaskListTableViewCell ()

/** 下标 */
@property (nonatomic,copy  ) NSIndexPath *indexPath;
/** 用来撑开高度的View */
@property(nonatomic,strong) UIView          *backView;

@end

@implementation GameHomeTaskListTableViewCell

+(GameHomeTaskListTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight
{
	static NSString *identifier = @"GameHomeTaskListTableViewCell";
	GameHomeTaskListTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil)
	{
		cell = [[GameHomeTaskListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	cell.fixedCellHeight = fixedCellHeight;
	cell.indexPath = indexPath;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self)
	{
		
		UIView *shadowView = ({
			UIView *view = [[UIView alloc] init];
			[self.contentView addSubview: view];
			[view.layer setShadowOffset:CGSizeMake(3,3)];
			[view.layer setShadowColor:QMBackColor.CGColor];
			[view.layer setShadowRadius:3];
			[view.layer setShadowOpacity:0.8];
			[view.layer setCornerRadius:20];
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.edges.mas_equalTo(UIEdgeInsetsMake(10, 20, 10, 20));
			}];
			view;
		});
		shadowView.backgroundColor = UIColor.whiteColor;
		
		
		self.backView = ({
			UIView *view = [[UIView alloc] init];
			[self.contentView addSubview: view];
			QMViewBorderRadius(view, 20, 0, DQMMainColor);
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.edges.mas_equalTo(UIEdgeInsetsMake(10, 20, 10, 20));
			}];
			view;
		});

		/** 背景图片 */
		UIImageView *backImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[_backView addSubview: imageView];
			QMSetImage(imageView, @"horizontal_placehold_image");
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
			}];
			imageView;
		});

		/** 波浪 */
		UIImageView *wavesImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[_backView addSubview: imageView];
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
			}];
			imageView;
		});
		QMSetImage(wavesImageView, @"icon_game_list_waves");

		/** 图标 */
		UIImageView *iconImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[_backView addSubview: imageView];
			QMSetImage(imageView, @"logo");
			QMViewBorderRadius(imageView, 8, 2, UIColor.whiteColor);
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(_backView.mas_left).offset(20);
				make.bottom.mas_equalTo(_backView.mas_bottom).offset(-40);
				make.size.mas_equalTo(CGSizeMake(50, 50));
			}];
			imageView;
		});

		UILabel *nameLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[_backView addSubview:label];
			QMLabelFontColorText(label, @"酷趣客", QMTextColor, 18);
			label.font = [UIFont boldSystemFontOfSize:18];
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(_backView.mas_left).offset(16);
				make.top.mas_equalTo(iconImageView.mas_bottom).offset(3);
			}];
			label;
		});

		UILabel *priceLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[_backView addSubview:label];
			label.backgroundColor = QMHexColor(@"feeef2");
			QMViewBorderRadius(label, 15, 0, DQMMainColor);
			QMLabelFontColorText(label, @"  +0.00元  ", QMPriceColor, 18);
			label.font = [UIFont boldSystemFontOfSize:18];
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(_backView.mas_right).offset(-16);
				make.centerY.mas_equalTo(iconImageView.mas_bottom);
				make.height.mas_equalTo(30);
			}];
			label;
		});

		[[RACObserve(self, gameListModel) skip:1] subscribeNext:^(GameListModel *x) {
			[backImageView qm_setImageUrlString:x.backIamgeUrl];
			[iconImageView qm_setImageUrlString:x.logoImageUrl];
			nameLabel.text = x.name;
			priceLabel.text = [NSString stringWithFormat:@"  %.2lf元  ",[x.price floatValue]];
		}];
	}
	return self;
}


- (void)setFixedCellHeight:(CGFloat)fixedCellHeight {
	_fixedCellHeight = fixedCellHeight;
	if (fixedCellHeight != 0) {
		[_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.edges.mas_equalTo(UIEdgeInsetsMake(10, 20, 10, 20));
			make.height.mas_equalTo(fixedCellHeight);
		}];
	}
}




@end


@implementation GameListModel

@end
